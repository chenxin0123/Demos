//
//  Context.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Context.hpp"
#include "Strategy.hpp"
#include <iostream> 
using namespace std;

Context::Context(Strategy* stg) {
    _stg = stg;
}
Context::~Context() {
    if (!_stg) delete _stg;
}
void Context::DoAction() {
    _stg->AlgrithmInterface();
}
