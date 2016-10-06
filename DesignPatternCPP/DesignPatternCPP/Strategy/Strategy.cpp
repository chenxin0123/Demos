//
//  Strategy.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Strategy.hpp"
#include <iostream> 
using namespace std;

Strategy::Strategy() {
}
Strategy::~Strategy() {
    cout<<"~Strategy....."<<endl;
}
void Strategy::AlgrithmInterface() {
}
ConcreteStrategyA::ConcreteStrategyA() {
}
ConcreteStrategyA::~ConcreteStrategyA() {
    cout<<"~ConcreteStrategyA....."<<endl;
}
void ConcreteStrategyA::AlgrithmInterface() {
    cout<<"test ConcreteStrategyA....."<<endl;
}
ConcreteStrategyB::ConcreteStrategyB() {
}
ConcreteStrategyB::~ConcreteStrategyB() {
    cout<<"~ConcreteStrategyB....."<<endl;
}
void ConcreteStrategyB::AlgrithmInterface() {
    cout<<"test ConcreteStrategyB....."<<endl;
}
