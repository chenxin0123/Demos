//
//  Singleton.cpp
//  DesignPatternCPP
//
//  Created by CX on 9/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Singleton.hpp"

Singleton* Singleton::_instance = 0;

Singleton::Singleton() {
    cout<<"Singleton...."<<endl;
}

Singleton* Singleton::Instance() {
    if (_instance == 0) {
        _instance = new Singleton();
    }
    return _instance;
}
