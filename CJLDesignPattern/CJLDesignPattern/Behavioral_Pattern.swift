//
//  Behavioral_Pattern.swift
//  CJLDesignPattern
//
//  Created by chenjialin16 on 2022/8/16.
//

import Cocoa

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 1、职责链模式（Chain-of-Responsibility Pattern）
// 避免请求发送者与接收者耦合在一起，让多个对象都有可能接收请求，将这些对象连接成一条链，并且沿着这条链传递请求，直到有对象处理它为止。职责链模式是一种对象行为型模式
// 举例：职责链模式在 iOS 中有大量的应用，比如事件响应链，事件传递下来会先判断该事件是不是应该由自己处理，如果不是由自己处理则传给下一位响应者去处理，如此循环下去。需要注意的是要避免响应链循环调用造成死循环，还有当所有的响应者都无法处理时的情况

//// 响应者
//class Response {
//    var nextResponse: Response? = nil
//    var name: String = ""
//    var upperLimit: UInt = 0
//    var lowerLimit: UInt = 0
//
//    func responseWithCode(_ code: UInt){
//        if lowerLimit <= code && code <= upperLimit {
//            //在处理范围
//            print("code: \(code) is \(name)")
//        }else if let response = nextResponse{
//            // 不在处理范围则 传递给下一位响应者
//            response.responseWithCode(code)
//        }else{
//            // 响应链结束
//            print("code: \(code) no match responder")
//        }
//    }
//}

//// 测试
//func test01(){
//    //建立响应链
//    let successR: Response = Response()
//    let warningR: Response = Response()
//    let httpR: Response = Response()
//    let serviceR: Response = Response()
//
//    successR.nextResponse = warningR
//    warningR.nextResponse = httpR
//    httpR.nextResponse = serviceR
//
//    //设置处理范围
//    successR.lowerLimit = 200
//    successR.upperLimit = 299
//    successR.name = "success"
//
//    warningR.lowerLimit = 300
//    warningR.upperLimit = 399
//    warningR.name = "warning"
//
//    httpR.lowerLimit = 400
//    httpR.upperLimit = 499
//    httpR.name = "http fail"
//
//    serviceR.lowerLimit = 500
//    serviceR.upperLimit = 599
//    serviceR.name = "service fail"
//
//    //使用响应者链
//    successR.responseWithCode(200)
//    successR.responseWithCode(310)
//    successR.responseWithCode(401)
//    successR.responseWithCode(555)
//    successR.responseWithCode(666)
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 2、命令模式（Command Pattern）
// 将一个请求封装为一个对象，从而让我们可用不同的请求对客户进行参数化；对请求排队或者记录请求日志，以及支持可撤销的操作。命令模式是一种对象行为型模式，其别名为动作(Action)模式或事务(Transaction)模式。
// 命令模式的本质是对命令进行封装，将发出命令的责任和执行命令的责任分割开。
// 举例：遥控器是一个调用者，不同按钮代表不同的命令，而电视是接收者。

//// 命令 -> 按钮
//class Command {
//    var sel: Selector? = nil
//    var target: AnyObject? = nil
//
//    func excute(){
//        target?.perform(sel, with: nil)
//    }
//}
//// 调用者 -> 遥控器
//class Controller{
//    //执行命令
//    func invokCommand(_ command: Command){
//        command.excute()
//    }
//    //取消命令
//    func cancelCommand(_ command: Command){}
//}
//// 接受者 -> 电视
//class TV {
//    @objc func turnOn(){
//        print("turn on")
//    }
//    @objc func turnOff(){
//        print("turn off")
//    }
//}

//// 测试
//func test02(){
//    // 接收者
//    let tv: TV = TV()
//
//    // 定义命令 可以定义一个命令抽象类然后派生出各种命令类，这里作者就偷个懒了
//    let turnOnCommand: Command = Command()
//    turnOnCommand.sel = #selector(TV.turnOn)// 开电视命令
//    turnOnCommand.target = tv
//
//    // 关电视命令
//    let turnOffCommand: Command = Command()
//    turnOffCommand.sel = #selector(TV.turnOff)// 开电视命令
//    turnOffCommand.target = tv
//
//    // 调用者
//    let controller: Controller = Controller()
//
//    // 调用者直接调用命令，不接触接收者
//    controller.invokCommand(turnOnCommand)// trun on
//    controller.invokCommand(turnOffCommand)// trun off
//
//    // 在此基础上也可以拓展出取消命令 cancelCommand 等方法就不一一列举
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 3、解释器模式
// 定义一个语言的文法，并且建立一个解释器来解释该语言中的句子，这里的“语言”是指使用规定格式和语法的代码。解释器模式是一种类行为型模式。
// 举例：我们的编译器，在对代码进行编译的时候也用到了该模式。我们可以直接来做一个简单的解释器，一个给机器人下发指令的解释器。

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 4、迭代器模式
// 提供一种方法来访问聚合对象，而不用暴露这个对象的内部表示，其别名为游标(Cursor)。迭代器模式是一种对象行为型模式。
// 举例：迭代器帮助请求方获取数据，避免直接操作数据聚合类，使数据聚合类专注存储数据。具体应用有分页等功能，分页功能的迭代器将专门负责操作分页数据，将操作逻辑和数据源分离

////数据列表
//class List{
//    var list: Array<String> = []
//
//    init(){
//        list = ["1", "2", "3", "4", "5"]
//    }
//}
//
////迭代器
//class Interator{
//    var index: Int = 0
//    private var list: List? = nil
//
//    init(){
//        list = List()
//    }
//
//    // 上一个数据
//    func previous() -> String{
//        index = max(0, index - 1)
//        return list!.list[index]
//    }
//    // 下一个数据
//    func next() -> String{
//        index = min(list!.list.count - 1, index+1)
//        return list!.list[index]
//    }
//    // 当前是否为第一个数据
//    func isFirst() -> Bool{
//        return index == 0
//    }
//}

//// 测试
//func test04(){
//    // 使用迭代器输出数据
//    let iterator: Interator = Interator()
//    print(iterator.next())
//    print(iterator.next())
//    print(iterator.next())
//    print(iterator.previous())
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 5、中介者模式（Mediator Pattern）
// 用一个中介对象（中介者）来封装一系列的对象交互，中介者使各对象不需要显式地相互引用，从而使其耦合松散，而且可以独立地改变它们之间的交互。中介者模式又称为调停者模式，它是一种对象行为型模式
// 举例：中介者模式将一个网状的系统结构变成一个以中介者对象为中心的星形结构，在这个星型结构中，使用中介者对象与其他对象的一对多关系来取代原有对象之间的多对多关系。所有成员通过中介者交互，方便拓展新的成员，例如下面的例子，新增一个聊天室成员只需要新建一个成员实例，然后再在聊天室中介者那注册就可以加入聊天室了，像iOS中的 CTMediator

//// 聊天室中介者
//class ChatMediator{
//    static let shareMediator = ChatMediator()
//
//    private var memberList: Array<ChatMember>
//
//    init (){
//        memberList = [ChatMember]()
//    }
//
//    // 聊天室成员注册
//    func registerChatMember(_ member: ChatMember){
//        memberList.append(member)
//    }
//
//    // 转发消息
//    func forwardMsg(_ msg: String, from member: ChatMember){
//        for chatM in memberList {
//            if chatM.userName != member.userName {
//                chatM.receiveMsg(msg, from: chatM)
//            }
//        }
//    }
//}
//
//// 聊天室成员
//class ChatMember{
//    // 成员昵称
//    var userName: String = ""
//
//    // 发送消息
//    func sendMsg(_ msg: String){
//        ChatMediator.shareMediator.forwardMsg(msg, from: self)
//    }
//    // 接收消息
//    func receiveMsg(_ msg: String, from member: ChatMember){
//        print("\(userName) receive: \(msg) from \(member.userName)")
//    }
//}

//// 测试
//func test05(){
//    // 聊天室中介者
//    let mediator: ChatMediator = ChatMediator.shareMediator
//    // 新建聊天室成员
//    let lily: ChatMember = ChatMember()
//    let tom: ChatMember = ChatMember()
//    let jack: ChatMember = ChatMember()
//    // 成员在中介者处注册
//    mediator.registerChatMember(lily)
//    mediator.registerChatMember(tom)
//    mediator.registerChatMember(jack)
//    // 命名
//    lily.userName = "lily"
//    tom.userName = "tom"
//    jack.userName = "jack"
//    // 发送消息
//    lily.sendMsg("hello everyone")
//    tom.sendMsg("hello lily")
//    jack.sendMsg("hi tom")
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 6、备忘录模式
// 在不破坏封装的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态，这样可以在以后将对象恢复到原先保存的状态。它是一种对象行为型模式，其别名为Token。
// 备忘录模式提供了一种状态恢复的实现机制，使得用户可以方便地回到一个特定的历史步骤，当新的状态无效或者存在问题时，可以使用暂时存储起来的备忘录将状态复原，当前很多软件都提供了撤销操作，其中就使用了备忘录模式。
// 举例：用一个简单的游戏存档来举例，这也是备忘录模式的一种应用

//// 角色状态
//class PlayerState {
//    var name: String = ""
//    var level: Int = 0
//    var rank: Int = 0
//}
//// 角色类
//class Player{
//    var state: PlayerState? = nil
//
//    // 设置角色状态
//    func setPlayerState(_ name: String, level: Int, rank: Int){
//        if state == nil {
//            state = PlayerState()
//        }
//        state?.name = name
//        state?.level = level
//        state?.rank = rank
//    }
//}
//// 备忘录
//class Memorandum{
//
//    // 备忘录存储的角色状态
//    private var state: PlayerState? = nil
//
//    //存储
//    func storeWithPlayer(_ player: Player){
//        state = player.state
//    }
//    //恢复
//    func restoreWithPlayer(_ player: Player){
//        if let tmp = state {
//            player.state = tmp
//        }
//    }
//}

//// 测试
//func test06(){
//    //创建角色A
//    let playA = Player()
//    playA.setPlayerState("King", level: 99, rank: 30)
//
//    //创建备忘录并保存角色A的状态
//    let memorandum: Memorandum = Memorandum()
//    memorandum.storeWithPlayer(playA)
//
////    创建角色B并使用备忘录恢复状态
//    let playB: Player = Player()
//    memorandum.restoreWithPlayer(playB)
//    print("name: \(playB.state!.name) level: \(playB.state!.level) rank: \(playB.state!.rank)")
//
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 7、观察者模式
// 定义对象之间的一种一对多依赖关系，使得每当一个对象状态发生改变时，其相关依赖对象皆得到通知并被自动更新。观察者模式的别名包括发布-订阅（Publish/Subscribe）模式、模型-视图（Model/View）模式、源-监听器（Source/Listener）模式或从属者（Dependents）模式。观察者模式是一种对象行为型模式。
// 观察者模式是使用频率最高的设计模式之一，它用于建立一种对象与对象之间的依赖关系，一个对象发生改变时将自动通知其他对象，其他对象将相应作出反应。
// 举例：在 iOS 中，观察者模式经常使用到，下面我就用 KVO 实现了一个通过气象台观察天气变化的简单例子。

//// 观察目标 - 气象站
//class WeatherStation: NSObject {
//    // 天气状态
//    var state: String = ""
//    private var observerList: Array<Observer> = [Observer]()
//
//    override init(){
//        super.init()
//        self.addObserver(self, forKeyPath: "state", options: .new, context: nil)
//
//    }
//
//    deinit{
//        self.removeObserver(self, forKeyPath: "state")
//    }
//
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        let state: String = change![NSKeyValueChangeKey(rawValue: "new")] as! String
//        for observer in observerList {
//            observer.observerWeather(state)
//        }
//    }
//
//    // 观察者注册方法
//    func registerWithObserver(_ observer: Observer){
//        observerList.append(observer)
//    }
//
//}
//// 观察者
//class Observer{
//    // 观察者名字
//    var name: String = ""
//
//    // 被通知方法
//    func observerWeather(_ weather: String){
//        print("\(name) observer weather changed: \(weather)")
//    }
//}

//// 测试
//func test07(){
//    // 新建监听目标 - 气象站
//    let station: WeatherStation = WeatherStation()
//
//    // 新建监听者
//    let farmer: Observer = Observer()
//    let student: Observer = Observer()
//    farmer.name = "farmer";
//    student.name = "student";
//
//    // 监听者注册
//    station.registerWithObserver(farmer)
//    station.registerWithObserver(student)
//
//    // 改变状态
//    station.state = "rainy";
//    station.state = "sunny";
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 8、状态模式
// 允许一个对象在其内部状态改变时改变它的行为，对象看起来似乎修改了它的类。其别名为状态对象(Objects for States)，状态模式是一种对象行为型模式。
// 举例：设计了一个银行账户系统，根据存钱余额来自动设置账户的状态，银行账户在不同状态下，进行存钱、取钱和借钱的行为。在不同状态下，这些行为得到的回复也不一样，比如说没有余额时无法取钱，只能借钱。

//// 账户状态抽象类
//protocol State{
//    // 存钱
//    func saveMoney(_ money: Float) -> Bool
//    // 取钱
//    func drawMoney(_ money: Float) -> Bool
//    // 借钱
//    func borrowMoney(_ money: Float) -> Bool
//}
//extension State{
//    func saveMoney(_ money: Float) -> Bool { return false }
//    func drawMoney(_ money: Float) -> Bool { return false }
//    func borrowMoney(_ money: Float) -> Bool { return false }
//}
//
//// 存款富余状态
//class RichState: State{
//    func saveMoney(_ money: Float) -> Bool {
//        print("欢迎存钱：\(money)")
//        return true
//    }
//    func drawMoney(_ money: Float) -> Bool {
//        print("欢迎取钱：\(money)")
//        return true
//    }
//    func borrowMoney(_ money: Float) -> Bool {
//        print("您还有余额，请先花完余额")
//        return false
//    }
//}
//
//// 零存款零负债状态
//class ZeroState: State{
//    func saveMoney(_ money: Float) -> Bool {
//        print("欢迎存钱：\(money)")
//        return true
//    }
//    func drawMoney(_ money: Float) -> Bool {
//        print("您当前没有余额")
//        return false
//    }
//    func borrowMoney(_ money: Float) -> Bool {
//        print("欢迎借钱：\(money)")
//        return true
//    }
//}
//
//// 负债状态
//class DebtState: State{
//    func saveMoney(_ money: Float) -> Bool {
//        print("欢迎存钱：\(money)")
//        return true
//    }
//    func drawMoney(_ money: Float) -> Bool {
//        print("您当前没有余额")
//        return false
//    }
//    func borrowMoney(_ money: Float) -> Bool {
//        print("上次欠的账还没有还清，暂时无法借钱")
//        return false
//    }
//}
//
//// 银行账户类
//class Account{
//    private var currentMoney: Float = 0
//    private var state: State = ZeroState()
//
//    func saveMoney(_ money: Float) {
//        if state.saveMoney(money) {
//            currentMoney += money
//            updateState()
//        }
//        print("余额：\(currentMoney)")
//    }
//    func drawMoney(_ money: Float)  {
//        if state.drawMoney(money) {
//            currentMoney -= money
//            updateState()
//        }
//        print("余额：\(currentMoney)")
//    }
//    func borrowMoney(_ money: Float) {
//        if state.borrowMoney(money) {
//            currentMoney -= money
//            updateState()
//        }
//        print("余额：\(currentMoney)")
//    }
//
//    //更新账户状态
//    func updateState(){
//        if currentMoney > 0 {
//            state = RichState()
//        }else if currentMoney == 0{
//            state = ZeroState()
//        }else{
//            state = DebtState()
//        }
//    }
//}

//// 测试
//func test08(){
//    // 初始化银行账户
//    let account: Account = Account()
//    // 取 50
//    account.drawMoney(50)// 余额：0 您当前没有余额
//    // 存 100
//    account.saveMoney(100) // 余额：0 欢迎存钱 100.00
//    // 借 100
//    account.borrowMoney(100) // 余额：100 您还有余额，请先花完余额
//    // 取 100
//    account.drawMoney(100) // 余额：100 欢迎取钱 100.00
//    // 借 100
//    account.borrowMoney(100) // 余额：0 欢迎借钱 100.00
//    // 借 50
//    account.borrowMoney(50)// 余额：-100 上次欠的账还没有还清，暂时无法借钱
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 9、策略模式
// 定义一系列算法类，将每一个算法封装起来，并让它们可以相互替换，策略模式让算法独立于使用它的客户而变化，也称为政策模式(Policy)。策略模式是一种对象行为型模式。
// 使用策略模式时，我们可以定义一些策略类，每一个策略类中封装一种具体的算法。在这里，每一个封装算法的类我们都可以称之为一种策略，根据传入不同的策略类，使环境类执行不同策略类中的算法。
// 举例：生活中也有很多类似的例子，就比如说商城的会员卡机制。我们去商城购物可以通过持有的会员卡打折，购买同一件商品时，持有不同等级的会员卡，能得到不同力度的折扣。下面的例子中我列举了青铜、白银、黄金三种 Vip 会员卡，传入不同的会员卡最终需要支付的金额也会有所不同。

//// Vip - 销售策略抽象类
//protocol Vip{
//    // vip 折扣
//    func getDiscount() -> Float
//    // vip 所需邮费
//    func getPostage() -> Float
//    // 根据折扣和邮费计算价格
//    func calcPrice(_ price: Float) -> Float
//}
//extension Vip{
//    func getDiscount() -> Float { return 1 }
//    func getPostage() -> Float { return 20 }
//    func calcPrice(_ price: Float) -> Float {
//        return price * getDiscount() + getPostage()
//    }
//}
//// 青铜 vip - 具体策略类
//class BronzeVip: Vip {
//    func getDiscount() -> Float { return 0.9 }
//    func getPostage() -> Float { return 20 }
//}
//// 白银 vip
//class SilverVip: Vip {
//    func getDiscount() -> Float { return 0.7 }
//    func getPostage() -> Float { return 10 }
//}
//// 黄金 vip
//class GoldVip: Vip {
//    func getDiscount() -> Float { return 0.5 }
//    func getPostage() -> Float { return 0 }
//}
//
////线上商城 - 环境类
//class OnlineShop{
//    // 购买商品 传入持有的 vip 卡
//    func buyProductWithVip(_ vip: Vip){
//        let productPrice: Float = 100
//        let payPrice = vip.calcPrice(productPrice)
//        print("pay：\(payPrice)")
//    }
//}

//// 测试
//func test09(){
//    // 初始化商城类
//    let shop: OnlineShop = OnlineShop()
//    // 新建各种 vip
//    let gold: GoldVip = GoldVip()
//    let silver: SilverVip = SilverVip()
//    let bronze: BronzeVip = BronzeVip()
//
//    // 使用青铜 vip 购买 100 元的商品
//    shop.buyProductWithVip(bronze) // 9折+20运费 pay: 110.00
//    // 使用白银 vip 购买 100 元的商品
//    shop.buyProductWithVip(silver) // 7折+10运费 pay: 80.00
//    // 使用黄金 vip 购买 100 元的商品
//    shop.buyProductWithVip(gold) // 5折+ 0运费 pay: 50.00
//
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 10、模板方法模式
// 定义一个操作中算法的框架，而将一些步骤延迟到子类中。模板方法模式使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤
// 应用分类： 抽象方法、具体方法、钩子方法
// 举例：在给定一个有固定模板的烹饪教程的情况下，根据不同烹饪需求对教程中的内容进行动态调整。

//// 烹饪教程 - 模板方法类
//class CookTutorial{
//    // 烹饪食物 - 具体方法
//    func cook(){
//        prepareIngredients()
//        // 如果是健康食物不加食用油
//        if isHealthyFood() {
//            addFat()
//        }
//        addIngredients()
//        addFlavouring()
//    }
//    // 准备食材 - 抽象方法
//    func prepareIngredients() {}
//    // 加食用油 具体方法
//    func addFat(){
//        print("2、加调和油")
//    }
//    // 加入食材 - 抽象方法
//    func addIngredients() {}
//    // 加入调味品 - 具体方法
//    func addFlavouring() { print("4、加盐") }
//    // 是否为健康食物 - 钩子方法
//    func isHealthyFood() -> Bool { return false }
//}
//// 烹饪 🐟 - 模板方法子类
//class CookFinsh: CookTutorial {
//    override func prepareIngredients() {
//        print("1、准备好生鳕鱼")
//    }
//
//    override func addIngredients() {
//        print("3、生鳕鱼入锅")
//    }
//
//    override func addFlavouring() {
//        super.addFlavouring()
//        print("4、加黑胡椒")
//    }
//
//    override func isHealthyFood() -> Bool {
//        return true
//    }
//}

//// 测试
//func test10(){
//    let cookFish: CookFinsh = CookFinsh()
//    cookFish.cook()
//}

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 11、访问者模式
// 提供一个作用于某对象结构中的各元素的操作表示，它使我们可以在不改变各元素的类的前提下定义作用于这些元素的新操作。访问者模式是一种对象行为型模式。
// 在使用访问者模式时，被访问元素通常不是单独存在的，它们存储在一个集合中，这个集合被称为「对象结构」，访问者通过遍历对象结构实现对其中存储的元素的逐个操作。
// 举例： 访问者有财务部门FADepartment和 HR 部门HRDepartment，通过访问雇员Employee来查看雇员的工作情况。

// 部门抽象类
protocol Department {
    // 访问抽象方法 用来声明方法
    func visitEmployee(_ employee: Employee)
}
// 财务部门 - 具体访问类
class FADepartment: Department {
    func visitEmployee(_ employee: Employee) {
        if employee.workTime > 40 {
            print("\(employee.name) 工作时间满 40 小时")
        }else {
            print("\(employee.name) 工作时间不满 40 小时，要警告！")
        }
    }
}
// HR部门 - 具体访问类
class HRDepartment: Department {
    func visitEmployee(_ employee: Employee) {
        let weekSalary = employee.workTime * employee.salary
        print("\(employee.name) 本周获取薪资 \(weekSalary)")
    }
}

// 抽象雇员类 - 被访问者类
protocol Employee{
    // 姓名
    var name: String {get set}
    // 工作时间
    var workTime: Int {get set}
    // 时薪
    var salary: Int {get set}
    // 接受访问抽象方法
    func accept(_ department: Department)
    
}
// 雇员具体类 - 被访问者具体类
class FulltimeEmployee: Employee {
    var name: String = ""
    
    var workTime: Int = 0
    
    var salary: Int = 0
    
    func accept(_ department: Department) {
        department.visitEmployee(self)
    }
}

// 测试
func test11(){
    // 新建财务和 HR - 访问者
    let fa: FADepartment = FADepartment()
    let hr: HRDepartment = HRDepartment()

    // 新建雇员 - 被访问者
    let tim: FulltimeEmployee = FulltimeEmployee()
    tim.name = "tim";
    tim.workTime = 55;
    tim.salary = 100;

    let bill: FulltimeEmployee = FulltimeEmployee()
    bill.name = "bill";
    bill.workTime = 38;
    bill.salary = 150;

    // 一般被访问者都存储在数据集合中方便遍历，集合中可以存储不同类型的被访问者
    let employeeList = [tim, bill]
    for e in employeeList {
        let em: Employee = e
        // 接受财务访问
        em.accept(fa)
        // 接受 HR 访问
        em.accept(hr)
    }
}
