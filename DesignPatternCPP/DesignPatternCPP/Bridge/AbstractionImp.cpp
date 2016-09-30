//
//  AbstractionImp.cpp
//  DesignPatternCPP
//
//  Created by CX on 9/30/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "AbstractionImp.hpp"
#include <iostream> 

using namespace std;

AbstractionImp::AbstractionImp() {}
AbstractionImp::~AbstractionImp() {}
void AbstractionImp::Operation() {
    cout<<"AbstractionImp....imp..."<<endl;
}

ConcreteAbstractionImpA::ConcreteAbstractionImpA() {}
ConcreteAbstractionImpA::~ConcreteAbstractionImpA() {}
void ConcreteAbstractionImpA::Operation() {
    cout<<"ConcreteAbstractionImpA...."<<endl;
}

ConcreteAbstractionImpB::ConcreteAbstractionImpB() {}
ConcreteAbstractionImpB::~ConcreteAbstractionImpB() {}
void ConcreteAbstractionImpB::Operation() {
    cout<<"ConcreteAbstractionImpB...."<<endl;
}
