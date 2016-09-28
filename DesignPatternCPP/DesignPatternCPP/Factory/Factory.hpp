//
//  Factory.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/28/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Factory_hpp
#define Factory_hpp

#include <stdio.h>

class Product;

class Factory {
public:
    virtual ~Factory() = 0;
    virtual Product* CreateProduct() = 0;
protected:
    Factory();
    private:
};

class ConcreteFactory:public Factory {
public:
    ~ConcreteFactory();
    ConcreteFactory();
    Product* CreateProduct();
protected:
private:
};


#endif /* Factory_hpp */
