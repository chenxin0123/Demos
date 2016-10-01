//
//  Composite.cpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Composite.hpp"

Composite::Composite() {
    //vector<Component*>::iterator itend = comVec.begin();
}
Composite::~Composite() {}

void Composite::Operation() {
    vector<Component*>::iterator comIter = comVec.begin();
    for (;comIter != comVec.end();comIter++) {
        (*comIter)->Operation();
    }
}

void Composite::Add(Component* com) {
    comVec.push_back(com);
}

void Composite::Remove(Component* com) {
    vector<Component*>::iterator comIter = comVec.begin();
    for (;comIter != comVec.end();comIter++) {
        if ((*comIter) == com) {
            comVec.erase(comIter);
            break;
        }
    }
}

Component* Composite::GetChild(int index) {
    return comVec[index];
}
