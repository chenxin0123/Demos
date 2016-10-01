//
//  Flyweight.cpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Flyweight.hpp"
#include <iostream> 

using namespace std;

Flyweight::Flyweight(string intrinsicState) {
    this->_intrinsicState = intrinsicState;
}

Flyweight::~Flyweight() {}

void Flyweight::Operation(const string& extrinsicState) {}

string Flyweight::GetIntrinsicState() {
    return this->_intrinsicState;
}


ConcreteFlyweight::ConcreteFlyweight(string intrinsicState):Flyweight(intrinsicState) {
    cout<<"ConcreteFlyweight Build....."<<intrinsicState<<endl;
}

ConcreteFlyweight::~ConcreteFlyweight() {}

void ConcreteFlyweight::Operation(const string& extrinsicState) {
    cout<<"ConcreteFlyweight:内蕴["<<this->GetIntrinsicState()<<"] 外 蕴["<<extrinsicState<<"]"<<endl;
}
