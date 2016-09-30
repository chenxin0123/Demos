//
//  main.cpp
//  DesignPatternCPP
//
//  Created by CX on 9/17/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include <iostream>

#include "Factory.hpp"
#include "Product.hpp"

#include "AbstractFactory.hpp"
#include "AbstractProduct.hpp"

#include "Singleton.hpp"

#include "Builder.hpp"
#include "Director.hpp"

#include "Prototype.hpp"

#include "Abstraction.hpp"
#include "AbstractionImp.hpp"

#include "Adapter.hpp"

using namespace std;

///AbstractFactory 模式和 Factory 模式的区别是初学(使用)设计模式时候的一个容易引 起困惑的地方。实际上,AbstractFactory 模式是为创建一组(有多类)相关或依赖的对象提 供创建接口,而 Factory 模式正如我在相应的文档中分析的是为一类对象提供创建接口或延 迟对象的创建到子类中实现。并且可以看到,AbstractFactory 模式通常都是使用 Factory 模 式实现(ConcreteFactory1)。
void FactoryTest() {
    Factory *fac = new ConcreteFactory();
    ::Product *p = fac->CreateProduct();
    
    delete fac;
    delete p;
}

void AbstractFactoryTest() {
    AbstractFactory* cf1 = new ConcreteFactory1();
    cf1->CreateProductA();
    cf1->CreateProductB();
    
    AbstractFactory* cf2 = new ConcreteFactory2();
    cf2->CreateProductA();
    cf2->CreateProductB();
}

///Singleton 不可以被实例化,因此我们将其构造函数声明为 protected 或者直接声明为 private。
///Singleton 模式经常和 Factory(AbstractFactory)模式在一起使用,因为系统中工厂对象 一般来说只要一个
void SingletonTest() {
    Singleton *sgn = Singleton::Instance();
    (void)sgn;
}

///当我们要创建的对象很复杂的时候(通常是 由很多其他的对象组合而成),我们要要复杂对象的创建过程和这个对象的表示(展示)分 离开来,这样做的好处就是通过一步步的进行复杂对象的构建,由于在每一步的构造过程中 可以引入参数,使得经过相同的步骤创建最后得到的对象的展示不一样
///Builder 模式和 AbstractFactory 模式在功能上很相似,因为都是用来创建大的复杂的对 象,它们的区别是:Builder 模式强调的是一步步创建对象,并通过相同的创建过程可以获 得不同的结果对象,一般来说 Builder 模式中对象不是直接返回的。而在 AbstractFactory 模 式中对象是直接返回的,AbstractFactory 模式强调的是为创建多个相互依赖的对象提供一个 同一的接口。
void BuilderTest() {
    Director* d = new Director(new ConcreteBuilder());
    d->Construct();
}

///Prototype 模式提供了一个通过已存在对象进行新对象创建的接口
///实际上 Prototype 模式和 Builder 模式、 AbstractFactory 模式都是通过一个类(对象实例)来专门负责对象的创建工作(工厂对象), 它们之间的区别是:
///Builder 模式重在复杂对象的一步步创建 AbstractFactory 模式重在产生多个相互依赖类的对象,而 Prototype 模式重在从自身复制自己
void PrototypeTest() {
    Prototype* p = new ConcretePrototype();
    Prototype* p1 = p->Clone();
    delete p1;
}

///在软件系统中，某些类型由于自身的逻辑，它具有两个或多个维度的变化，那么如何应对这种“多维度的变化”？如何利用面向对象的技术来使得该类型能够轻松的沿着多个方向进行变化，而又不引入额外的复杂度？这就要使用Bridge模式。
///将抽象部分与实现部分分离，使它们都可以独立的变化
///桥接模式中的所谓脱耦，就是指在一个软件系统的抽象化和实现化之间使用关联关系（组合或者聚合关系）而不是继承关系，从而使两者可以相对独立地变化，这就是桥接模式的用意。
void BridgeTest() {
    AbstractionImp* imp = new ConcreteAbstractionImpA();
    Abstraction* abs = new RefinedAbstraction(imp);
    abs->Operation();
}

///Adapter适配器设计模式中有3个重要角色：被适配者Adaptee，适配器Adapter和目标对象Target
///其中两个现存的想要组合到一起的类分别是被适配者Adaptee和目标对象Target角色，我们需要创建一个适配器Adapter将其组合在一起。
void AdapterTest() {
#ifdef AdapterClassMode
    Target* adt = new Adapter();
    adt->Request();
#else
    Adaptee* ade = new Adaptee;
    Target* adt = new Adapter(ade);
    adt->Request();
#endif
}

//void Test() {
//    
//}

int main(int argc, const char * argv[]) {
#define CallAndLog(fn) cout<<#fn<<":"<<endl;fn##Test();cout<<endl;
    //创建型设计模式
    CallAndLog(Factory)
    CallAndLog(AbstractFactory)
    CallAndLog(Singleton)
    CallAndLog(Builder)
    CallAndLog(Prototype)
    
    //结构型
    CallAndLog(Bridge)
    CallAndLog(Adapter)
//    CallAndLog(FactoryTest)
//    CallAndLog(FactoryTest)
//    CallAndLog(FactoryTest)

    return 0;
}
