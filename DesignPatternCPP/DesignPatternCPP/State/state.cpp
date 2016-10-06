//
//  state.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "state.hpp"
#include "Context_State.hpp"
#include <iostream>
using namespace std;

State::State() {
}
State::~State() {
}
void State::OperationInterface (Context_State* con) {
    cout<<"State::.."<<endl;
}
bool State::ChangeState(Context_State* con,State* st) {
    con->ChangeState(st);
    return true;
}

void State::OperationChangeState(Context_State* con) {
}

ConcreteStateA::ConcreteStateA() {
}
ConcreteStateA::~ConcreteStateA() {
}
void ConcreteStateA::OperationInterface (Context_State* con) {
    cout<<"ConcreteStateA::OperationInterface ......"<<endl;
}
void ConcreteStateA::OperationChangeState(Context_State* con) {
    OperationInterface(con);
    this->ChangeState(con,new ConcreteStateB());
}

ConcreteStateB::ConcreteStateB() {
}
ConcreteStateB::~ConcreteStateB(){
}
void ConcreteStateB::OperationInterface (Context_State* con) {
    cout<<"ConcreteStateB::OperationInterface......"<<endl;
}
void ConcreteStateB::OperationChangeState (Context_State* con) {
    OperationInterface(con);
    this->ChangeState(con,new ConcreteStateA());
}
