//
//  Director.cpp
//  DesignPatternCPP
//
//  Created by CX on 9/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Director.hpp"

Director::Director(Builder* bld) {
    _bld = bld;
}

Director::~Director() {}

void Director::Construct() {
    _bld->BuildPartA("user-defined1");
    _bld->BuildPartB("user-defined2");
    _bld->BuildPartC("user-defined3");
}
