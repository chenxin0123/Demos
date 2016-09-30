//
//  Abstraction.cpp
//  DesignPatternCPP
//
//  Created by CX on 9/30/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Abstraction.hpp"
#include "AbstractionImp.hpp"
#include <iostream>

using namespace std;

Abstraction::Abstraction() {}
Abstraction::~Abstraction() {}

RefinedAbstraction::RefinedAbstraction(AbstractionImp* imp) {
    _imp = imp;
}
RefinedAbstraction::~RefinedAbstraction() {}
void RefinedAbstraction::Operation() {
    _imp->Operation();
}
