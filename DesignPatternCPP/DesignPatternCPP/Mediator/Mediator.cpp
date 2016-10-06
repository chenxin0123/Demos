//
//  Mediator.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Mediator.hpp"
#include "Colleage.hpp"

Mediator::Mediator() {
}
Mediator::~Mediator() {
}
ConcreteMediator::ConcreteMediator() {
}
ConcreteMediator::~ConcreteMediator() {
}
ConcreteMediator::ConcreteMediator(Colleage* clgA,Colleage* clgB) {
    this->_clgA = clgA;
    this->_clgB = clgB;
}
void ConcreteMediator::DoActionFromAtoB() {
    _clgB->SetState(_clgA->GetState());
}
void ConcreteMediator::SetConcreteColleageA(Colleage* clgA) {
    this->_clgA = clgA;
}
void ConcreteMediator::SetConcreteColleageB(Colleage* clgB) {
    this->_clgB = clgB;
}
Colleage* ConcreteMediator::GetConcreteColleageA() {
    return _clgA;
}
Colleage* ConcreteMediator::GetConcreteColleageB() {
    return _clgB;
}
void ConcreteMediator::IntroColleage(Colleage* clgA,Colleage* clgB) {
    this->_clgA = clgA;
    this->_clgB = clgB;
}
void ConcreteMediator::DoActionFromBtoA() {
    _clgA->SetState(_clgB->GetState());
}
