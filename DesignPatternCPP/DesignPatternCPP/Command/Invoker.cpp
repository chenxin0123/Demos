//
//  Invoker.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Invoker.hpp"
#include "Command.hpp"
#include <iostream>

Invoker::Invoker(Command* cmd) {
    _cmd = cmd;
}
Invoker::~Invoker() {
    delete _cmd;
}
void Invoker::Invoke() {
    _cmd->Excute();
}
