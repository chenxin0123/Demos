//
//  Context_State.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Context_State.hpp"
#include "state.hpp"


Context_State::Context_State() {
}
Context_State::Context_State(State* state) {
    this->_state = state;
}
Context_State::~Context_State() {
    delete _state;
}
void Context_State::OprationInterface() {
    _state->OperationInterface(this);
}
bool Context_State::ChangeState(State* state) {
    this->_state = state;
    return true;
}
void Context_State::OperationChangState() {
    _state->OperationChangeState(this);
}
