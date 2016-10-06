//
//  Element.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Element.hpp"
#include "Visitor.hpp"
#include <iostream> 
using namespace std;

Element::Element() {
}
Element::~Element() {
}
void Element::Accept(Visitor* vis) {
}
ConcreteElementA::ConcreteElementA() {
}
ConcreteElementA::~ConcreteElementA() {
}
void ConcreteElementA::Accept(Visitor* vis) {
    vis->VisitConcreteElementA(this);
    cout<<"visiting ConcreteElementA..."<<endl;
}
ConcreteElementB::ConcreteElementB() {
}
ConcreteElementB::~ConcreteElementB() {
}
void ConcreteElementB::Accept(Visitor* vis) {
    cout<<"visiting ConcreteElementB..."<<endl;
    vis->VisitConcreteElementB(this);
}
