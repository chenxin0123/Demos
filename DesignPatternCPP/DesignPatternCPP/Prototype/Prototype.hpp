//
//  Prototype.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Prototype_hpp
#define Prototype_hpp

#include <stdio.h>

class Prototype {
public:
    virtual ~Prototype();
    virtual Prototype* Clone() const = 0;
protected:
    Prototype();
private:
};

class ConcretePrototype:public Prototype {
public:
    ConcretePrototype();
    ConcretePrototype(const ConcretePrototype& cp);
    ~ConcretePrototype();
    Prototype* Clone() const;
protected:
private:
};

#endif /* Prototype_hpp */
