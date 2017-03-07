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

#include "Template.hpp"

#include "Context.hpp"
#include "Strategy.hpp"

#include "Context_State.hpp"
#include "state.hpp"

#include "Observer.hpp"

#include "Memento.hPP"

#include "Mediator.hpp"
#include "Colleage.hpp"

#include "Command.hpp"
#include "Invoker.hpp"
#include "Reciever.hpp"

#include "Element.hpp"
#include "Visitor.hpp"

#include "Handle.hpp"

#include "Iterator.hpp"
#include "Aggregate.hpp"

#include "Interpreter_Context.hpp"
#include "Interpret.hpp"

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
///Builder 建造者模式和 AbstractFactory 模式在功能上很相似,因为都是用来创建大的复杂的对 象,它们的区别是:Builder 模式强调的是一步步创建对象,并通过相同的创建过程可以获 得不同的结果对象,一般来说 Builder 模式中对象不是直接返回的。而在 AbstractFactory 模 式中对象是直接返回的,AbstractFactory 模式强调的是为创建多个相互依赖的对象提供一个 同一的接口。
void BuilderTest() {
    Director* d = new Director(new ConcreteBuilder());
    d->Construct();
}

///Prototype 原型模式提供了一个通过已存在对象进行新对象创建的接口
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

///Decorator 装饰者模式提供了一种给类增加职责的方法,不是通过继承实现的,而是通过组合。
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

///Composite 组合模式通过和 Decorator 模式有着类似的结构图,但是 Composite 模式旨在构造 类,而 Decorator 模式重在不生成子类即可给对象添加职责。Decorator 模式重在修饰,而 Composite 模式重在表示
void CompositeTest() {
    Leaf* l = new Leaf();
    l->Operation();
    
    Composite* com = new Composite();
    com->Add(l);
    com->Operation();
    
    NS_Composite::Component* ll = com->GetChild(0);
    ll->Operation();
}

///Flyweight 享元模式中有一个类似 Factory 模式的对象构造工厂FlyweightFactory,当客户程序员(Client)需要一个对象时候就会向 FlyweightFactory 发出 请求对象的消息 GetFlyweight()消息,FlyweightFactory 拥有一个管理、存储对象的“仓 库”(或者叫对象池,vector 实现),GetFlyweight()消息会遍历对象池中的对象,如果已 经存在则直接返回给 Client,否则创建一个新的对象返回给 Client。
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

///代理模式使用代理对象完成用户请求，屏蔽用户对真实对象的访问.现实世界的代理人被授权执行当事人的一些事宜，无需当事人出面，从第三方的角度看，似乎当事人并不存在，因为他只和代理人通信。而事实上代理人是要有当事人的授权，并且在核心问题上还需要请示当事人。
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

///又叫模板方法模式，在一个方法中定义一个算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以在不改变算法结构的情冴下，重新定义算法中的某些步骤。
void TemplateTest() {
    AbstractClass* p1 = new ConcreteClass1();
    AbstractClass* p2 = new ConcreteClass2();
    p1->TemplateMethod();
    p2->TemplateMethod();
}

///Strategy 策略模式则通过组合(委托) 来达到和 Template 模式类似的效果，其代价就是空间和时间上的代价
///Strategy 模式和 Template 模式要解决的问题是相同(类似)的，都是为了给业务逻辑(算 法)具体实现和抽象接口之间的解耦。Strategy 模式将逻辑(算法)封装到一个类(Context) 里面，通过组合的方式将具体算法的实现在组合对象中实现，再通过委托的方式将抽象接口 的实现委托给组合对象实现。State 模式也有类似的功能
//////Bridge模式和Strategy模式相似就是因为他们都将任务委托给了另外一个接口的具体实现，他们之间的区别在于Bridge的目的是让底层实现和上层接口可以分别演化，从而提高移植性而Strategy的目的是将复杂的算法封装起来，从而便于替换不同的算法。
///以相对策略模式，桥接模式要表达的内容要更多，结构也更加复杂。桥接模式表达的主要意义其实是接口隔离的原则，即把本质上并不内聚的两种体系区别 开来，使得它们可以松散的组合，而策略在解耦上还仅仅是某一个算法的层次，没有到体系这一层次。从结构图中可以看到，策略的结构是包容在桥接结构中的，桥接中必然存在着策略模式
void StrategyTest() {
    Strategy* ps = new ConcreteStrategyA();
    Context* pc = new Context(ps);
    pc->DoAction();
}

/// Strategy 模式很 State 模式也有相似之处，但是 State 模式注重的对象在不同的 状态下不同的操作。两者之间的区别就是State模式中具体实现类中有一个指向Context 的引用，而 Strategy 模式则没有。
///通常我们在实现这类系统会使用到很多的Switch/Case语句，Case某种状态，发生什么动作， Case 另外一种状态，则发生另外一种状态。但是这种实现方式至少有以下两个问题:
///1)当状态数目不是很多的时候，Switch/Case 可能可以搞定。但是当状态数目很多的时 候(实际系统中也正是如此)，维护一大组的 Switch/Case 语句将是一件异常困难并且容易出 错的事情。
///2)状态逻辑和动作实现没有分离。在很多的系统实现中，动作的实现代码直接写在状 态的逻辑当中。这带来的后果就是系统的扩展性和维护得不到保证。
///State 模式很好地实现了对象的状态逻辑和动作实现的分离，状态逻辑分布在 State 的派 生类中实现，而动作实现则可以放在 Context 类中实现(这也是为什么 State 派生类需要拥 有一个指向 Context 的指针)。这使得两者的变化相互独立，改变 State 的状态逻辑可以很容 易复用 Context 的动作，也可以在不影响 State 派生类的前提下创建 Context 的子类来更改或 替换动作实现。
void StateTest() {
    State* st = new ConcreteStateA();
    Context_State* con = new Context_State(st);
    con->OperationChangState();
    con->OperationChangState();
    con->OperationChangState();
}

///Observer 模式应该可以说是应用最多、影响最广的模式之一，因为 Observer 的一个实 例 Model/View/Control(MVC)结构在系统开发架构设计中有着很重要的地位和意义
void ObserverTest() {
    NS_Observer::ConcreteSubject* sub = new NS_Observer::ConcreteSubject();
    NS_Observer::Observer* o1 = new NS_Observer::ConcreteObserverA(sub);
    NS_Observer::Observer* o2 = new NS_Observer::ConcreteObserverB(sub);
    sub->SetState("old");
    sub->Notify();
    sub->SetState("new"); //也可以由 Observer 调用 sub->Notify();
    delete o1;
    delete o2;
}

///Memento 模式的关键就是要在不破坏封装行的前提下，捕获并保存一个类的内部 状态，这样就可以利用该保存的状态实施恢复操作。为了达到这个目标，可以在后面的实现 中看到我们采取了一定语言支持的技术。
///在 Command 模式中，Memento 模式经常被用来维护可以撤销(Undo)操作的状态
void MementoTest() {
    Originator* o = new Originator();
    o->SetState("old"); //备忘前状态
    o->PrintState();
    Memento* m = o->CreateMemento();//将状态备忘
    o->SetState("new"); //修改状态
    o->PrintState();
    o->RestoreToMemento(m); //恢复修改前状态
    o->PrintState();
}

///当系统规模变大，对象的量变引 起系统复杂度的急剧增加，对象间的通信也变得越来越复杂，这时候我们就要提供一个专门 处理对象间交互和通信的类，这个中介者就是 Mediator 模式
///Mediator 模式提供将对象间 的交互和通讯封装在一个类中，各个对象间的通信不必显势去声明和引用，大大降低了系统 的复杂性能
///Mediator 模式是一种很有用并且很常用的模式，它通过将对象间的通信封装到一个类 中，将多对多的通信转化为一对多的通信，降低了系统的复杂性。Mediator 还获得系统解耦 的特性，通过 Mediator，各个 Colleague 就不必维护各自通信的对象和通信协议，降低了系 统的耦合性，Mediator 和各个 Colleague 就可以相互独立地修改了。
///Mediator 模式还有一个很显著额特点就是将控制集中，集中的优点就是便于管理，也正 式符合了 OO 设计中的每个类的职责要单一和集中的原则。
void MediatorTest() {
    ConcreteMediator* m = new ConcreteMediator();
    ConcreteColleageA* c1 = new ConcreteColleageA(m);
    ConcreteColleageB* c2 = new ConcreteColleageB(m);
    m->IntroColleage(c1,c2);
    c1->SetState("old");
    c2->SetState("old");
    c1->Aciton();
    c2->Aciton();
    cout<<endl;
    c1->SetState("new");
    c1->Aciton();
    c2->Aciton();
    cout<<endl;
    c2->SetState("old");
    c2->Aciton();
    c1->Aciton();
}

///Command 模式在实现的实现和思想都很简单，其关键就是将一个请求封装到一个类中 (Command)，再提供处理对象(Receiver)，最后 Command 命令由 Invoker 激活。另外，我 们可以将请求接收者的处理抽象出来作为参数传给 Command 对象，实际也就是回调的机制 (Callback)来实现这一点，也就是说将处理操作方法地址(在对象内部)通过参数传递给 Command 对象，Command 对象在适当的时候(Invoke 激活的时候)再调用该函数
///Command 模式的思想非常简单，但是 Command 模式也十分常见，并且威力不小。实 际上，Command 模式关键就是提供一个抽象的 Command 类，并将执行操作封装到 Command 类接口中，Command 类中一般就是只是一些接口的集合，并不包含任何的数据属性
void CommandTest() {
    Reciever* rev = new Reciever();
    Command* cmd = new ConcreteCommand(rev);
    Invoker* inv = new Invoker(cmd);
    inv->Invoke();
}

///Visitor 模式则提供了一种解决方案:将更新(变更)封装到一个类中(访问操作)，并 由待更改类提供一个接收接口，则可达到效果。
///Visitor 模式在不破坏类的前提下，为类提供增加新的新操作。Visitor 模式的关键是双分派(Double-Dispatch)的技术。C++语言支持的是单分派。
void VisitorTest() {
    Visitor* vis = new ConcreteVisitorA();
    Element* elm = new ConcreteElementA();
    elm->Accept(vis);
}

///MFC 责任链模式提供了消息的处理的链式处理策略，处理消息的请求将沿着预先定义好的路径依次进行处理。消息的发送者并不知道该消息最后是由那个具体对象处理的，当然它也无须也 不想知道
///Chain of Responsibility 模式描述其实就是这样一类问题将可能处理一个请求的对象链 接成一个链，并将请求在这个链上传递，直到有对象处理该请求(可能需要提供一个默认处 理所有请求的类，例如 MFC 中的 CwinApp 类)。
void ChainOfResponsibilityTest() {
    Handle* h1 = new ConcreteHandleA();
    Handle* h2 = new ConcreteHandleB();
    h1->SetSuccessor(h2);
    h1->HandleRequest();
}

///Iterator 模式应该是最为熟悉的模式了，最简单的证明就是我在实现 Composite 模式、 Flyweight 模式、Observer 模式中就直接用到了 STL 提供的 Iterator 来遍历 Vector 或者 List 数据结构。
///Iterator 模式也正是用来解决对一个聚合对象的遍历问题，将对聚合的遍历封装到一个 类中进行，这样就避免了暴露这个聚合对象的内部表示的可能。
void IteratorTest() {
    Aggregate* ag = new ConcreteAggregate();
    Iterator* it = new ConcreteIterator(ag);
    for (; !(it->IsDone()) ; it->Next()) {
        cout<<it->CurrentItem()<<endl;
    }
}

///一些应用提供了内建(Build-In)的脚本或者宏语言来让用户可以定义他们能够在系统 中进行的操作。Interpreter 模式的目的就是使用一个解释器为用户提供一个一门定义语言的 语法表示的解释器，然后通过这个解释器来解释语言中的句子
///Interpreter 模式中使用类来表示文法规则，因此可以很容易实现文法的扩展。另外对于 终结符我们可以使用 Flyweight 模式来实现终结符的共享。
void InterpreterTest() {
    Interpreter_Context* c = new Interpreter_Context();
    AbstractExpression* te = new TerminalExpression("hello");
    AbstractExpression* nte = new NonterminalExpression(te,2);
    nte->Interpret(*c);
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
