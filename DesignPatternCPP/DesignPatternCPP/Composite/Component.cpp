//
//  Component.cpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Component.hpp"

namespace NS_Composite {
    
Component::Component() {}
Component::~Component() {}

void Component::Add(const Component& com) {}
void Component::Remove(const Component& com) {}

Component* Component::GetChild(int index) {
    return 0;
}

}
