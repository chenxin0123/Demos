//
//  Abstraction.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/30/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Abstraction_hpp
#define Abstraction_hpp

class AbstractionImp;

class Abstraction {
public:
    virtual ~Abstraction();
    virtual void Operation() = 0;
protected:
    Abstraction();
private:
};

class RefinedAbstraction:public Abstraction {
public:
    RefinedAbstraction(AbstractionImp* imp);
    ~RefinedAbstraction();
    void Operation();
protected:
private:
    AbstractionImp* _imp;
};

#endif /* Abstraction_hpp */
