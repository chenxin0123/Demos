//
//  Composite.hpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Composite_hpp
#define Composite_hpp

#include "Component.hpp"
#include <vector> 
using namespace std;
using namespace NS_Composite;

class Composite:public NS_Composite::Component {
public:
    Composite();
    ~Composite();
public:
    void Operation();
    void Add(Component* com);
    void Remove(Component* com);
    Component* GetChild(int index);
protected:
private:
    vector<Component*> comVec;
};

#endif /* Composite_hpp */
