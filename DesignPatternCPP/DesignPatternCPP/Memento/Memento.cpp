//
//  Memento.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Memento.hpp"
#include <iostream>
using namespace std;

Originator::Originator() {
    _sdt = "";
    _mt = 0;
}
Originator::Originator(const string& sdt) {
    _sdt = sdt;
    _mt = 0;
}
Originator::~Originator() {
}
Memento* Originator::CreateMemento() {
    return new Memento(_sdt);
}
string Originator::GetState() {
    return _sdt;
}
void Originator::SetState(const string& sdt) {
    _sdt = sdt;
}
void Originator::PrintState() {
    cout<<this->_sdt<<"....."<<endl;
}
void Originator::SetMemento(Memento* men) {
}
void Originator::RestoreToMemento(Memento* mt) {
    this->_sdt = mt->GetState();
}

Memento::Memento() {
}
Memento::Memento(const string& sdt) {
    _sdt = sdt;
}
string Memento::GetState() {
    return _sdt;
}
void Memento::SetState(const string& sdt) {
    _sdt = sdt;
}
