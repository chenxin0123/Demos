//
//  Factory.cpp
//  DesignPatternCPP
//
//  Created by CX on 9/28/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Factory.hpp"
#include "Product.hpp"
#include <iostream>

using namespace std;

Factory::Factory() {}

Factory::~Factory() {}

ConcreteFactory::ConcreteFactory() {
    cout<<"ConcreteFactory....."<<endl;
}

ConcreteFactory::~ConcreteFactory() {}

Product* ConcreteFactory::CreateProduct() {
    return new ConcreteProduct();
}
