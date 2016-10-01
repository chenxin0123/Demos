//
//  Leaf.hpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Leaf_hpp
#define Leaf_hpp

#include "Component.hpp"


class Leaf:public NS_Composite::Component {
public:
    Leaf();
    ~Leaf();
    void Operation();
    protected: private:
};


#endif /* Leaf_hpp */
