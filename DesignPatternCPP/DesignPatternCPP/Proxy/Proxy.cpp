//
//  Proxy.cpp
//  DesignPatternCPP
//
//  Created by CX on 10/2/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Proxy.hpp"
#include <iostream> 

using namespace std;

Subject::Subject() {}
Subject::~Subject() {}
ConcreteSubject::ConcreteSubject() {}
ConcreteSubject::~ConcreteSubject() {}
void ConcreteSubject::Request() {
    cout<<"ConcreteSubject......request ...."<<endl;
}

Proxy::Proxy() {}
Proxy::Proxy(Subject* sub) {
    _sub = sub;
}
Proxy::~Proxy() {}
void Proxy::Request() {
    cout<<"Proxy request...."<<endl;
    _sub->Request();
}
