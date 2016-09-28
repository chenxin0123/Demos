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
using namespace std;


///AbstractFactory 模式和 Factory 模式的区别是初学(使用)设计模式时候的一个容易引 起困惑的地方。实际上,AbstractFactory 模式是为创建一组(有多类)相关或依赖的对象提 供创建接口,而 Factory 模式正如我在相应的文档中分析的是为一类对象提供创建接口或延 迟对象的创建到子类中实现。并且可以看到,AbstractFactory 模式通常都是使用 Factory 模 式实现(ConcreteFactory1)。
void FactoryTest() {
    Factory *fac = new ConcreteFactory();
    Product *p = fac->CreateProduct();
    
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

int main(int argc, const char * argv[]) {
    FactoryTest();
    AbstractFactoryTest();
    return 0;
}
