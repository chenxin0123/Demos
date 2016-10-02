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

#include "Decorator.hpp"

#include "Component.hpp"
#include "Composite.hpp"
#include "Leaf.hpp"

#include "Flyweight.hpp"
#include "FlyweightFactory.hpp"

#include "Facade.hpp"

#include "Proxy.hpp"

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

///Decorator 提供了一种给类增加职责的方法,不是通过继承实现的,而是通过组合。
///动态地给一个对象添加一些额外的职责或者行为。就增加功能来说， Decorator模式相比生成子类更为灵活。
///它是通过创建一个包装对象，也就是装饰来包裹真实的对象
///Decorator 模式除了采用组合的方式取得了比采用继承方式更好的效果,Decorator 模式 还给设计带来一种“即用即付”的方式来添加职责
///Decorator 模式和 Proxy 模式的相似的地方在于它们都拥有一个指向其他对象的引用
///为了多态,通过父类指针指向其具体子类,但是这就带来另外一个问题,当具体子类要添加 新的职责,就必须向其父类添加一个这个职责的抽象接口,否则是通过父类指针是调用不到 这个方法了。这样处于高层的父类就承载了太多的特征(方法),并且继承自这个父类的所 有子类都不可避免继承了父类的这些接口,但是可能这并不是这个具体子类所需要的。而在 Decorator 模式提供了一种较好的解决方法,当需要添加一个操作的时候就可以通过 Decorator 模式来解决,你可以一步步添加新的职责。
///透明性使得你可以递归的嵌套多个装饰，从而可以添加任意多的功能
///以下情况使用Decorator模式
///1.在不影响其他对象的情况下，以动态、透明的方式给单个对象添加职责。
///2 处理那些可以撤消的职责。
///3.当不能采用生成子类的方法进行扩充时。一种情况是，可能有大量独立的扩展
void DecoratorTest() {
    ::Component* com = new ConcreteComponent();
    Decorator* dec = new ConcreteDecorator(com);
    dec->Operation();
    delete com;
    delete dec;
}

///Composite 模式通过和 Decorator 模式有着类似的结构图,但是 Composite 模式旨在构造 类,而 Decorator 模式重在不生成子类即可给对象添加职责。Decorator 模式重在修饰,而 Composite 模式重在表示
void CompositeTest() {
    Leaf* l = new Leaf();
    l->Operation();
    
    Composite* com = new Composite();
    com->Add(l);
    com->Operation();
    
    NS_Composite::Component* ll = com->GetChild(0);
    ll->Operation();
}

///Flyweight 模式中有一个类似 Factory 模式的对象构造工厂FlyweightFactory,当客户程序员(Client)需要一个对象时候就会向 FlyweightFactory 发出 请求对象的消息 GetFlyweight()消息,FlyweightFactory 拥有一个管理、存储对象的“仓 库”(或者叫对象池,vector 实现),GetFlyweight()消息会遍历对象池中的对象,如果已 经存在则直接返回给 Client,否则创建一个新的对象返回给 Client。
void FlyweightTest() {
FlyweightFactory* fc = new FlyweightFactory();
    Flyweight* fw1 = fc->GetFlyweight("hello");
    Flyweight* fw2 = fc->GetFlyweight("world!");
    Flyweight* fw3 = fc->GetFlyweight("hello");
    void(fw1||fw2||fw3);
}

///为子系统中的一组接口提供一个一致的界面， Facade模式定义了一个高层接口，这个接口使得这一子系统更加容易使用
///比如为点灯 冰箱 空调提供一个关闭电源的高层接口
///Façade 模式在高层提供了一个统一的接口,解耦了系统。设计模式中还有另一种模式 Mediator 也和 Façade 有类似的地方。但是 Mediator 主要目的是对象间的访问的解耦
void FacadeTest() {
    Facade* f = new Facade();
    f->OperationWrapper();
}

///装饰者（Decorator）：动态地给一个对象添加一些额外的职责，代理模式（Proxy）：为另一个对象提供一个替身或占位符以控制对这个对象的访问，简而言之就是用一个对象来代表另一个对象。。
///适配器Adapter 为它所适配的对象提供了一个不同的接口。相反，代理提供了与它的实体相同的接口，用于访问保护的代理可能会拒绝执行实体会执行的操作，因此，它的接口实际上可能只是实体接口的一个子集。
///1、“增加一层间接层”是软件系统中对许多负责问题的一种常见解决方法。在面向对象系统中，直接使用某些对象会带来很多问题，作为间接层的proxy对象便是解决这一问题的常用手段。
///2、具体proxy设计模式的实现方法、实现粒度都相差很大，有些可能对单个对象作细粒度的控制，有些可能对组件模块提供抽象代理层，在架构层次对对象作proxy。
///3、proxy并不一定要求保持接口的一致性，只要能够实现间接控制，有时候损及一些透明性是可以接受的。
void ProxyTest() {
    Subject* sub = new ConcreteSubject();
    Proxy* p = new Proxy(sub);
    p->Request();
}

void TemplateTest() {

}

void StrategyTest() {

}

void StateTest() {

}

void ObserverTest() {

}

void MementoTest() {

}

void MediatorTest() {
    
}

void CommandTest() {
    
}

void VisitorTest() {
    
}

void ChainOfResponsibilityTest() {
    
}


void IteratorTest() {
    
}

void InterpreterTest() {
    
}

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
    CallAndLog(Decorator)
    CallAndLog(Composite)
    CallAndLog(Flyweight)
    CallAndLog(Facade)
    CallAndLog(Proxy)
    
    //行为模式
    CallAndLog(Template)
    CallAndLog(Strategy)
    CallAndLog(State)
    CallAndLog(Observer)
    CallAndLog(Memento)
    CallAndLog(Mediator)
    CallAndLog(Command)
    CallAndLog(Visitor)
    CallAndLog(ChainOfResponsibility)
    CallAndLog(Iterator)
    CallAndLog(Interpreter)

    return 0;
}
