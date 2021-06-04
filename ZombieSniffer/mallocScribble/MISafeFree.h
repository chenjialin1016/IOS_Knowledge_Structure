//
//  MISafeFree.h
//  ZombieSnifferTest
//
//  Created by chenjialin16 on 2021/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MISafeFree : NSObject

//系统警告时，用函数释放一些内存
void free_safe_mem(size_t freeNum);

@end

NS_ASSUME_NONNULL_END
