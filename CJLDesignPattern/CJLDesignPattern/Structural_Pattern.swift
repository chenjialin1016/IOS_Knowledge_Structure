//
//  Structural_Pattern.swift
//  CJLDesignPattern
//
//  Created by chenjialin16 on 2022/8/16.
//

import Cocoa

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 1、外观模式
// 外观模式定义了一个高层接口，为子系统中的一组接口提供一个统一的接口。外观模式又称为门面模式，它是一种结构型设计模式模式。
// 举例：就像图片缓存，内部包含了涉及到其他子系统的如缓存、下载等处理，外观模式将这些复杂的逻辑都隐藏了。在UIImageView和UIButton调用的时候，你只需要调一个setImageWithUrl:(NSString *)url接口就可以了，达到解耦合的目的。

//// 子类
//class Stock1 {
//    func buy(){
//        print("买入股票1")
//    }
//    func sell(){
//        print("卖出股票2")
//    }
//}
//class Stock2 {
//  func buy(){
//      print("买入股票2")
//  }
//  func sell(){
//      print("卖出股票2")
//  }
//}
//
//// 高层类 - 统一接口
//class Found {
//
//    private var stock1: Stock1
//    private var stock2: Stock2
//
//    init(){
//        stock1 = Stock1()
//        stock2 = Stock2()
//    }
//
//    func buyFund(){
//        stock1.buy()
//        stock2.buy()
//    }
//
//    func sellFund(){
//        stock1.sell()
//        stock2.sell()
//    }
//}

//// 测试
//func test01(){
//    let found: Found = Found()
//    found.buyFund()
//    found.sellFund()
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 2、适配器模式（包装器模式） - 万能转换器（个人命名）
// 将一个接口转换成客户希望的另一个接口，使得原本由于接口不兼容而不能一起工作的那些类可以一起工作。适配器模式的别名是包装器模式（Wrapper），是一种结构型设计模式
// 举例：适配器模式顾名思义，比如内地用像港版插头需要一个转接头。再比如iPhone的手机卡是特别小的 Nano 卡，把 Nano 卡拿到其他手机上不能贴合卡槽尺寸，所以我们需要加一个符合卡槽尺寸的卡套。

//// 标准卡 尺寸协议
//protocol StandardSIMSizeProtocol{
//    func normalSize()
//}
//// nano 卡尺寸协议
//protocol NanoSIMSizeProtocol{
//    func nanoSize()
//}
//// 标准卡 遵循标准协议
//class StandardSIMCard: SIMCard, StandardSIMSizeProtocol{
//    func normalSize() {
//        print("standard")
//    }
//}
//// nano 卡遵循 nano 协议
//class NanoSIMCard: SIMCard, NanoSIMSizeProtocol {
//    func nanoSize() {
//        print("nano")
//    }
//}
//// Nano 卡套（万能转换器）
//class NanoAdapter: SIMCard, StandardSIMSizeProtocol {
//    var nanoSIMCard: NanoSIMCard? = nil
//    func normalSize() {
//        print("nano to standard")
//    }
//}
//
////手机
//class OnePhone: Phone{
//    override var simCard: SIMCard? {
//        didSet {
//            if simCard is StandardSIMCard {
//                (simCard as! StandardSIMCard).normalSize()
//            }else if simCard is NanoSIMCard {
//                (simCard as! NanoSIMCard).nanoSize()
//            }else{
//                (simCard as! NanoAdapter).normalSize()
//            }
//
//        }
//    }
//}

//// 测试
//func test02(){
//    // 标准卡
//    let standardCard: StandardSIMCard = StandardSIMCard()
//    // Nano 卡
//    let nanoCard: NanoSIMCard = NanoSIMCard()
//
//    // 创建大卡槽手机 插入卡后会调用 normalSize() 方法
//    let onePhone: OnePhone = OnePhone()
//    // 标准卡 遵循 StandardSIMSizeProtocol，协议 实现了 normalSize() 方法
//    onePhone.simCard = standardCard
//
//    // Nano 遵循 NanoSIMSizeProtocol 协议，并没有实现了 normalSize() 方法，所以会报错
////    onePhone.simCard = nanoCard
//
//    // 加一个 Nano 卡套
//    let adapter: NanoAdapter = NanoAdapter()
//    // 卡套持有 Nano 卡实例，方便获取 Nano 卡信息
//    adapter.nanoSIMCard = nanoCard
//    // 将卡套放入手机， 卡套遵循 StandardSIMSizeProtocol，实现了 normalSize() 方法
//    onePhone.simCard = adapter
//}


//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 3、桥接模式
// 将抽象部分与它的实现部分分离,使它们都可以独立地变化。
// 举例：尽管手机都有各自的不同之处，但是他们都有一个手机卡卡槽，卡槽里可以插不同运营商的卡。不管手机和卡内部如何改变，只要卡槽的行业标准没有变，就都可以正常使用。桥接模式在于将复杂的类进行分割，优先对象组合的方式，就像将手机里的手机卡抽离出去新建一个类，实现手机实例持有一个手机卡实例的组合方式。而不是通过继承来新建多个不同手机卡的手机子类

//// 创建手机 SIM 卡协议： 相当于行业标准
//protocol SIMCardProtocol {
//    //读取 SIM 卡信息接口
//    func getSIMInfo()
//}
//
//// SIM卡抽象类
//class SIMCard: SIMCardProtocol{
//    func getSIMInfo() {
//    }
//
//}
//// 联通SIM卡
//class UnicomSIMCard: SIMCard {
//    override func getSIMInfo() {
//        print("Welcome Unicom User")
//    }
//}
//// 移动SIM卡
//class MobileSIMCard: SIMCard {
//    override func getSIMInfo() {
//        print("Welcome Mobile User")
//    }
//}
//
//// 手机抽象类
//class Phone {
//    //持有 SIM 卡
//    var simCard: SIMCard? = nil
//
//    //启动手机方法
//    func launchPhone(){
//        if let sim = simCard {
//            sim.getSIMInfo()
//        }
//    }
//}
//// iPhone
//class iPhone: Phone {}
//// 小米手机
//class miPhone: Phone {}

//// 测试
//func test03(){
//    //联通卡
//    let unicomSim: UnicomSIMCard = UnicomSIMCard()
//    //移动卡
//    let mobileSim: MobileSIMCard = MobileSIMCard()
//    //小米手机安装上联调卡
//    let mi9: miPhone = miPhone()
//    mi9.simCard = unicomSim
//    //iPhone 安装上移动卡
//    let iPhoneX: iPhone = iPhone()
//    iPhoneX.simCard = mobileSim
//    //开机
//    mi9.launchPhone()
//    iPhoneX.launchPhone()
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 4、代理模式
// 为某个对象提供一个代理，并由这个代理对象控制对原对象的访问。
// 举例：代理模式像一个房屋中介，买家只能通过中介来买房，代理具备被代理类的所有功能，就像房东有卖房功能，中介也具有卖房功能。此外代理实例还可以帮助被代理实例进行一些额外处理，比如中介可以帮助房东筛选优质买家的功能，帮助房东pass掉一些不符合条件的买家。还有消息队列也是该模式。代理模式像一个房屋中介，买家只能通过中介来买房，代理具备被代理类的所有功能，就像房东有卖房功能，中介也具有卖房功能。此外代理实例还可以帮助被代理实例进行一些额外处理，比如中介可以帮助房东筛选优质买家的功能，帮助房东pass掉一些不符合条件的买家。还有消息队列也是该模式。

//// 顾客
//class Custom {
//    var waiter: Waiter?
//
//    init(){
//        waiter = nil
//    }
//
//    func callWaiter(){
//        waiter = Waiter()
//    }
//}
//
//// 服务生
//class Waiter {
//    var cacheList: Array<String>
//
//    init() {
//        cacheList = [String]()
//    }
//
//    //下单
//    func orderingFood(_ food: String) {
//        cacheList.append(food)
//    }
//
//    //取消某个菜
//    func removeFood(_ food: String) {
//        if let index = cacheList.firstIndex(of: food) {
//            cacheList.remove(at: index)
//        }
//
//    }
//
//    //将最早点的才推送给厨师
//    func pushToChef(_ chef: Chef){
//        chef.cookFood(cacheList.first!)
//        cacheList.removeFirst()
//    }
//}
//
//// 厨师
//class Chef {
//    func cookFood(_ food: String){
//        print("cook \(food)")
//    }
//}

//// 测试
//func test04(){
//    // 餐厅厨师
//    let chef: Chef = Chef()
//
//    // 顾客
//    let lily: Custom = Custom()
//    // 顾客叫服务生
//    lily.callWaiter()
//    // 顾客点餐
//    lily.waiter!.orderingFood("鸡炖蘑菇")
//    lily.waiter!.orderingFood("东坡肉")
//    // 顾客取消某个菜
//    lily.waiter!.removeFood("东坡肉")
//
//    // 将最早点的菜菜推给厨师去烹饪
//    lily.waiter!.pushToChef(chef)
//
//}


//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 5、装饰者模式
// 不改变原有对象的前提下，动态地给一个对象增加一些额外的功能
// 举例：定一个抽象类Tea，只能提供白开水，但是通过装饰类BlackTea装饰之后拓展了新功能，通过BlackTea类可以用白开水泡红茶，还可以选择加柠檬

//// tea
//class Tea {
//    class func createTea() -> Tea {
//        print("add water")
//        return Tea()
//    }
//}
//
////装饰类
//class BlackTea: Tea{
//    var tea: Tea?
//
//    override init(){
//        tea = nil
//    }
//
//    override class func createTea() -> Tea{
//        return BlackTea()
//    }
//
//    func addBlackTea() {
//        print("add black tea")
//    }
//    func addLemon() {
//        print("add lemon")
//    }
//}

//// 测试
//func test05(){
//    //茶
//    let tea: Tea = Tea.createTea()
//
//    //红茶
//    let blackTea: BlackTea = BlackTea.createTea() as! BlackTea
//    blackTea.tea = tea
//    blackTea.addBlackTea()
//    blackTea.addLemon()
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 6、享元模式
// 运用共享技术复用大量细粒度的对象,降低程序内存的占用,提高程序的性能
// 举例：音乐服务根据收费划分出免费用户和会员用户，免费用户只能听部分免费音乐，会员用户可以听全部的音乐，并且可以下载。虽然权限上二者间有一些区别，但是他们所享受的音乐来是自于同一个音乐库，这样所有的音乐都只需要保存一份就可以了。另外如果出现音乐库里没有的音乐时，则需要新增该音乐，然后其他服务也可以享受新增的音乐，相当于享元池或缓存池的功能。

//// 音乐服务
//class MusicService {
//    //共享的音乐库
//    var musicLibrary: Array<String>
//
//    init(){
//        musicLibrary = [String]()
//    }
//
//    //听音乐
//    func listenMusic(_ music: String){}
//
//    //下载音乐
//    func downloadMusic(_ music: String){}
//}
//
//// 免费音乐服务
//class FreeMusicService {
//    var musicService: MusicService?
//
//    init(){
//        musicService = nil
//    }
//
//    func listenFree(_ music: String){
//        // 如果是免费则播放
//        if music == "free" {
//            musicService?.listenMusic(music)
//        }else{
//            // 如果是收费音乐，则提示用户升级 Vip
//            print("please upgrade to Vip")
//        }
//    }
//}
//
//// VIP音乐服务
//class VIPMusicService{
//    var musicService: MusicService?
//
//    init(){
//        musicService = nil
//    }
//
//    func listen(_ music: String){
//        musicService?.listenMusic(music)
//    }
//
//    func download(_ music: String){
//        musicService?.downloadMusic(music)
//    }
//}


//// 测试
//func test06(){
//    // 新建一个基础音乐库
//    let musicService: MusicService = MusicService()
//
//    // 免费服务
//    let freeMS: FreeMusicService = FreeMusicService()
//    // 收费服务
//    let vipMS: VIPMusicService = VIPMusicService()
//
//    // 共享一个音乐库
//    freeMS.musicService = musicService
//    vipMS.musicService = musicService
//
//    freeMS.listenFree("免费音乐")
//    vipMS.listen("all")
//}
