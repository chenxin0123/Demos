//
//  Command.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Command.hpp"
#include "Reciever.hpp"
#include <iostream>

Command::Command() {
}
Command::~Command() {
}
void Command::Excute() {
}
ConcreteCommand::ConcreteCommand(Reciever* rev) {
    this->_rev = rev;
}
ConcreteCommand::~ConcreteCommand() {
    delete this->_rev;
}
void ConcreteCommand::Excute() {
    _rev->Action();
    std::cout<<"ConcreteCommand..."<<std::endl;
}
