//
//  AbstractProduct.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/28/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef AbstractProduct_hpp
#define AbstractProduct_hpp

#include <stdio.h>


class AbstractProductA {
public:
    virtual ~AbstractProductA();
protected:
    AbstractProductA();
private:
};

class AbstractProductB {
public:
    virtual ~AbstractProductB();
protected:
    AbstractProductB();
private:
};

class ProductA1:public AbstractProductA {
public:
    ProductA1();
    ~ProductA1();
protected:
private:
};

class ProductA2:public AbstractProductA {
public:
    ProductA2();
    ~ProductA2();
protected:
private:
};

class ProductB1:public AbstractProductB {
public:
    ProductB1();
    ~ProductB1();
protected:
private:
};
class ProductB2:public AbstractProductB {
public:
    ProductB2();
    ~ProductB2();
protected:
private:
};


#endif /* AbstractProduct_hpp */
