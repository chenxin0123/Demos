//
//  AbstractFactory.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/28/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef AbstractFactory_hpp
#define AbstractFactory_hpp

#include <stdio.h>

class AbstractProductA;
class AbstractProductB;

class AbstractFactory {
public:
    virtual ~AbstractFactory();
    virtual AbstractProductA* CreateProductA() = 0;
    virtual AbstractProductB* CreateProductB() = 0;
protected: AbstractFactory();
private:
};

class ConcreteFactory1:public AbstractFactory {
public:
    ConcreteFactory1();
    ~ConcreteFactory1();
    AbstractProductA* CreateProductA();
    AbstractProductB* CreateProductB();
protected:
private:
};

class ConcreteFactory2:public AbstractFactory {
public:
    ConcreteFactory2();
    ~ConcreteFactory2();
    AbstractProductA* CreateProductA();
    AbstractProductB* CreateProductB();
protected:
private:
};

#endif /* AbstractFactory_hpp */
