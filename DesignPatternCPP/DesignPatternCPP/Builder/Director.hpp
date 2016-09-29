//
//  Director.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Director_hpp
#define Director_hpp

#include "Builder.hpp"

using namespace NS_Builder;

class Director {
public:
    Director(Builder* bld);
    ~Director();
    void Construct();
protected:
private:
    Builder* _bld;
};

#endif /* Director_hpp */
