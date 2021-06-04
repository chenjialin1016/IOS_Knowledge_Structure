//
//  MISafeFree.m
//  ZombieSnifferTest
//
//  Created by chenjialin16 on 2021/4/26.
//  在对象释放时做数据填充 0x55就可以了。

#import "MISafeFree.h"
#import "queue.h"
#import "fishhook.h"
#import "MIZombieProxy.h"

#import <dlfcn.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

//用于保存zombie类
static Class kMIZombieIsa;
//用于保存zombie类的实例变量大小
static size_t kMIZombieSize;

//用于表示调用free函数
static void(* orig_free)(void *p);
//用于保存已注册的类的集合
static CFMutableSetRef registeredClasses = nil;
/*
 用来保存自己保留的内存
 - 1、队列要线程安全或者自己加锁
 - 2、这个队列内部应该尽量少申请和释放堆内存
 */
struct DSQueue *_unfreeQueue = NULL;
//用来记录自己保存的内存的大小
int unfreeSize = 0;

//最多存储的内存，大于这个值就释放一部分
#define MAX_STEAL_MEM_SIZE 1024*1024*100
//最多保留的指针个数，超过就释放一部分
#define MAX_STEAL_MEM_NUM 1024*1024*10
//每次释放时释放的指针数量
#define BATCH_FREE_NUM 100

@implementation MISafeFree

#pragma mark - Public Method
//系统警告时，用函数释放一些内存
void free_safe_mem(size_t freeNum){
#ifdef DEBUG
    //获取队列的长度
    size_t count = ds_queue_length(_unfreeQueue);
    //需要释放的内存大小
    freeNum = freeNum > count ? count : freeNum;
    //遍历并释放
    for (int i = 0; i < freeNum; i++) {
        //获取未释放的内存块
        void *unfreePoint = ds_queue_get(_unfreeQueue);
        //创建内存块申请的大小
        size_t memSize = malloc_size(unfreePoint);
        //原子减操作，多线程对全局变量进行自减
        __sync_fetch_and_sub(&unfreeSize, (int)memSize);
        //释放
        orig_free(unfreePoint);
    }
#endif
}

#pragma mark - Life Circle

+ (void)load{
#ifdef DEBUG
    loadZombieProxyClass();
    init_safe_free();
#endif
}

#pragma mark - Private Method
void safe_free(void* p){
//
//    //获取自己保留的内存的大小
//    int unFreeCount = ds_queue_length(_unfreeQueue);
//    //保留的内存大于一定值时就释放一部分
//    if (unFreeCount > MAX_STEAL_MEM_NUM*0.9 || unfreeSize>MAX_STEAL_MEM_SIZE) {
//        free_safe_mem(BATCH_FREE_NUM);
//    }else{
//        //创建p申请的内存大小
//        size_t memSize = malloc_size(p);
//        //有足够的空间才覆盖
//        if (memSize > kMIZombieSize) {
//            //指针强转为id对象
//            id obj = (id)p;
//            //获取指针原本的类
//            Class origClass = object_getClass(obj);
//            //判断是不是objc对象
//            char *type = @encode(typeof(obj));
//            /*
//             - strcmp 字符串比较
//             - CFSetContainsValue 查看已注册类中是否有origClass这个类
//
//             如果都满足，则将这块内存填充0x55
//             */
//            if (strcmp("@", type) == 0 && CFSetContainsValue(registeredClasses, origClass)) {
//                //内存上填充0x55
//                memset(obj, 0x55, memSize);
//                //将自己类的isa复制过去
//                memcpy(obj, &kMIZombieIsa, sizeof(void*));
//                //为obj设置指定的类
//                object_setClass(obj, [MIZombieProxy class]);
//                //保留obj原本的类
//                ((MIZombieProxy*)obj).originClass = origClass;
//                //多线程下int的原子加操作，多线程对全局变量进行自加，不用理会线程锁了
//                __sync_fetch_and_add(&unfreeSize, (int)memSize);
//                //入队
//                ds_queue_put(_unfreeQueue, p);
//            }else{
//                orig_free(p);
//            }
//        }else{
//            orig_free(p);
//        }
//    }
}

//加载野指针自定义类
void loadZombieProxyClass(){
    registeredClasses = CFSetCreateMutable(NULL, 0, NULL);
    
    //用于保存已注册类的个数
    unsigned int count = 0;
    //获取所有已注册的类
    Class *classes = objc_copyClassList(&count);
    //遍历，并保存到registeredClasses中
    for (int i = 0; i < count; i++) {
        CFSetAddValue(registeredClasses, (__bridge const void *)(classes[i]));
    }
    //释放临时变量内存
    free(classes);
    classes = NULL;
    
    kMIZombieIsa = objc_getClass("MIZombieProxy");
    kMIZombieSize = class_getInstanceSize(kMIZombieIsa);
}

//初始化以及free符号重绑定
bool init_safe_free(){
    //初始化用于保存内存的队列
    _unfreeQueue = ds_queue_create(MAX_STEAL_MEM_NUM);
    //dlsym 在打开的库中查找符号的值，即动态调用free函数
    orig_free = (void(*)(void*))dlsym(RTLD_DEFAULT, "free");
    /*
     rebind_symbols:符号重绑定
     - 参数1：rebindings 是一个rebinding数组，其定义如下
         struct rebinding {
           const char *name;  // 目标符号名
           void *replacement; // 要替换的符号值（地址值）
           void **replaced;   // 用来存放原来的符号值（地址值）
         };
     - 参数2：rebindings_nel 描述数组的长度
     */
    //重绑定free符号，让它指向自定义的safe_free函数
    rebind_symbols((struct rebinding[]){{"free", (void*)safe_free}}, 1);
    return true;
}

@end
