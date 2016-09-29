//
//  Prototype.cpp
//  DesignPatternCPP
//
//  Created by CX on 9/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Prototype.hpp"
#include <iostream> 
using namespace std;

Prototype::Prototype() {}
Prototype::~Prototype() {}

Prototype* Prototype::Clone() const {
    return 0;
}

ConcretePrototype::ConcretePrototype() {}
ConcretePrototype::~ConcretePrototype() {}

ConcretePrototype::ConcretePrototype(const ConcretePrototype& cp) {
    cout<<"ConcretePrototype copy ..."<<endl;
}

Prototype* ConcretePrototype::Clone() const {
    return new ConcretePrototype(*this);
}
