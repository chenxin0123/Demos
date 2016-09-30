//
//  AbstractionImp.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/30/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef AbstractionImp_hpp
#define AbstractionImp_hpp

class AbstractionImp {
public:
    virtual ~AbstractionImp();
    virtual void Operation() = 0;
protected:
    AbstractionImp();
    private:
};

class ConcreteAbstractionImpA:public AbstractionImp {
public:
    ConcreteAbstractionImpA();
    ~ConcreteAbstractionImpA();
    virtual void Operation();
protected:
private:
};

class ConcreteAbstractionImpB:public AbstractionImp {
public:
    ConcreteAbstractionImpB();
    ~ConcreteAbstractionImpB();
    virtual void Operation();
protected:
private:
};

#endif /* AbstractionImp_hpp */
