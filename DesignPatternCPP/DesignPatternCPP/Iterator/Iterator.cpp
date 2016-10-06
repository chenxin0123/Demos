//
//  Iterator.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Iterator.hpp"
#include "Aggregate.hpp"
#include <iostream> 
using namespace std;

Iterator::Iterator() {
}
Iterator::~Iterator() {
}
ConcreteIterator::ConcreteIterator(Aggregate* ag , int idx) {
    this->_ag = ag;
    this->_idx = idx;
}
ConcreteIterator::~ConcreteIterator() {
}
Object ConcreteIterator::CurrentItem() {
    return _ag->GetItem(_idx);
}
void ConcreteIterator::First() {
    _idx = 0;
}
void ConcreteIterator::Next() {
    if (_idx < _ag->GetSize())
        _idx++;
}
bool ConcreteIterator::IsDone() {
    return (_idx == _ag->GetSize());
}
