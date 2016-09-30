//
//  Adapter.cpp
//  DesignPatternCPP
//
//  Created by CX on 9/30/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Adapter.hpp"
#include <iostream>

#ifdef AdapterClassMode

Target::Target() {}
Target::~Target() {}
void Target::Request() {
    std::cout<<"Target::Request"<<std::endl;
}

Adaptee::Adaptee() {}
Adaptee::~Adaptee() {}
void Adaptee::SpecificRequest() {
    std::cout<<"Adaptee::SpecificRequest"<<std::endl;
}

Adapter::Adapter() {}
Adapter::~Adapter() {}
void Adapter::Request() {
    this->SpecificRequest();
}

#else

Target::Target() {}
Target::~Target() {}
void Target::Request() {
    std::cout<<"Target::Request"<<std::endl;
}

Adaptee::Adaptee() {}
Adaptee::~Adaptee() {}
void Adaptee::SpecificRequest() {
    std::cout<<"Adaptee::SpecificRequest"<<std::endl;
}

Adapter::Adapter(Adaptee* ade) {
    this->_ade = ade;
}
Adapter::~Adapter() {}
void Adapter::Request() {
    _ade->SpecificRequest();
}

#endif
