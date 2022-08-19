//
//  Creational_Pattern.swift
//  CJLDesignPattern
//
//  Created by chenjialin16 on 2022/8/16.
//

import Foundation

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 1、简单工程模式
// 简单工厂就像一个代工厂，一个工厂可以生产多种产品
// 举例：一个饮料加工厂同时帮百事可乐和可口可乐生产，加工厂根据输入参数Type来生产不同的产品

//// 【抽象接口类】 - iOS中称为【协议】
////可乐抽象类
//protocol Cola{}
////可口可乐产品类
//class CocaCola: Cola {}
////百事可乐产品类
//class PesiCola: Cola {}

//// 简单工厂实现
//class SimpleFactory{
//    class func createColaWithType(_ type: Int) -> Cola{
//        switch type {
//        case 0:
//            return CocaCola()
//        default:
//            return PesiCola()
//        }
//    }
//}
//
//// 测试 - 初始化
////0 - 生产可口可乐
//let cocaCola: Cola = SimpleFactory.createColaWithType(0)
//print(cocaCola)
////1 - 生产百事可乐
//let pesiCola: Cola = SimpleFactory.createColaWithType(1)
//print(pesiCola)

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 2、工厂方法模式
// 工厂父类负责定义创建产品对象的公共接口，工厂子类则负责生成具体的产品对象，即通过不同的工厂子类来创建不同的产品对象
// 举例：可口可乐工厂专门生产可口可乐，百事可乐工厂专门生产百事可乐

//// 可乐抽象类
//protocol Cola{
//}
////可口可乐产品类
//class CocaCola: Cola {}
////百事可乐产品类
//class PesiCola: Cola {}
//// 工厂抽象类
//protocol Factory: Cola{
//    static func createCola() -> Cola
//}
//// 可口可乐工厂
//class CocaColaFactory: Factory{
//    static func createCola() -> Cola {
//        return CocaCola()
//    }
//}
//// 百事可乐工厂
//class PesiColaFactory: Factory {
//    static func createCola() -> Cola {
//        return PesiCola()
//    }
//}

//// 测试 - 根据不同的工厂类生产不同的产品
//let pesiCola: Cola = PesiColaFactory.createCola()
//let cocaCola: Cola = CocaColaFactory.createCola()


//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 3、抽象工厂模式
// 提供一个创建一系列相关或相互依赖对象的接口，而无须指定它们具体的类。
// 举例：可口可乐公司生产可乐的同时，也需要生产装可乐的瓶子和箱子，瓶子和箱子也是可口可乐专属定制的，同样百事可乐公司也会有这个需求

//// 可乐抽象类 + 派生类
//protocol Cola {}
//class CocaCola: Cola {}
//class PesiCola: Cola {}
//
//// 瓶子抽象类 + 派生类
//protocol Bottle {}
//class CocaColaBottle: Bottle {}
//class PesiColaBottle: Bottle {}
//
//// 箱子抽象类 + 派生类
//protocol Box {}
//class CocaColaBox: Box {}
//class PesiColaBox: Box {}
//
//// 工厂抽象类
//protocol Factory {
//    static func createCola() -> Cola
//    static func createBottle() -> Bottle
//    static func createBox() -> Box
//}
//
//// 可口可乐主题工厂
//class CocaColaFactory: Factory{
//    static func createCola() -> Cola{
//        return CocaCola()
//    }
//    static func createBottle() -> Bottle {
//        return CocaColaBottle()
//    }
//    static func createBox() -> Box {
//        return CocaColaBox()
//    }
//}
//
//// 百事可乐主题工厂
//class PesiColaFactory: Factory {
//    static func createCola() -> Cola {
//        return PesiCola()
//    }
//    static func createBottle() -> Bottle {
//        return PesiColaBottle()
//    }
//    static func createBox() -> Box {
//        return PesiColaBox()
//    }
//}

//// 测试 - 初始化
////可口可乐主题
//let cocaCola: Cola = CocaColaFactory.createCola()
//let cocaColaBottle: Bottle = CocaColaFactory.createBottle()
//let cocaColaBox: Box = CocaColaFactory.createBox()
////百事可乐主题
//let pesiCola: Cola = PesiColaFactory.createCola()
//let pesiColaBottle: Bottle = PesiColaFactory.createBottle()
//let pesiColaBox: Box = PesiColaFactory.createBox()

//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 4、单例模式
// 单例模式确保某一个类只有一个实例，并提供一个访问它的全剧访问点。
// 举例：就像一个王国只能有一个国王，一旦王国里的事务多起来，这唯一的国王也容易职责过重

//class Singleton {
//    static let shareInstance: Singleton = Singleton()
//    private init () {}
//}

//// 测试 - 单例初始化
//let singleton: Singleton = Singleton.shareInstance


//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 5、生成器模式（创建者模式）
// 它将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示
// 举例：生产汽车，分步骤创建安装不同的零件。

//// 生产器抽象类
//protocol Builder {
//    func buildEngine()
//    func buildWheel()
//    func buildBody()
//}
//// 奔驰
//class BCBuilder: Builder {
//    func buildEngine() {
//        print("奔驰 - engine")
//    }
//    func buildWheel() {
//        print("奔驰 - wheel")
//    }
//    func buildBody() {
//        print("奔驰 - body")
//    }
//}
//// 奥迪
//class ADBuilder: Builder{
//    func buildEngine() {
//        print("奥迪 - engine")
//    }
//    func buildWheel() {
//        print("奥迪 - wheel")
//    }
//    func buildBody() {
//        print("奥迪 - body")
//    }
//}
//
//// 创建者类
//class CarBuilder{
//
//    var builder: Builder?
//
//    init() {
//        builder = nil
//    }
//
//    func buildCar(){
//        builder!.buildEngine()
//        builder!.buildWheel()
//        builder!.buildBody()
//    }
//}


////测试 - 指定不同的汽车生产步骤
//func test05() {
//    var carBuilder: CarBuilder = CarBuilder()
//    carBuilder.builder = BCBuilder()
//    carBuilder.buildCar()
//
//    carBuilder.builder = ADBuilder()
//    carBuilder.buildCar()
//}


//MARK: ✨✨✨--------------------------------------------------------------------✨✨✨
//MARK: - 6、原型模式
// 使用原型实例指定待创建对象的类型，并且通过复制这个原型来创建新的对象
// 举例：原型模式就像复印技术，根据原对象复印出一个新对象，并根据需求对新对象进行微调

//class Student {
//    var name: String
//    var age: String
//    
//    init(){
//        name = ""
//        age = ""
//    }
//}

//// 测试
//func test06(){
//    //原对象
//    let lily: Student = Student()
//    lily.name = "lily"
//    lily.age = "13"
//    print(lily.name)
//    //复制原对象
//    let tom = lily
//    tom.name = "tom"
//    print(tom.name)
//}

