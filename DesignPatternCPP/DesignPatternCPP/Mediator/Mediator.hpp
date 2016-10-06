//
//  Mediator.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Mediator_hpp
#define Mediator_hpp

class Colleage;

class Mediator {
public:
    virtual ~Mediator();
    virtual void DoActionFromAtoB() = 0;
    virtual void DoActionFromBtoA() = 0;
protected:
    Mediator();
private:
};

class ConcreteMediator:public Mediator {
public:
    ConcreteMediator();
    ConcreteMediator(Colleage* clgA,Colleage* clgB);
    ~ConcreteMediator();
    void SetConcreteColleageA(Colleage* clgA);
    void SetConcreteColleageB(Colleage* clgB);
    Colleage* GetConcreteColleageA();
    Colleage* GetConcreteColleageB();
    void IntroColleage(Colleage* clgA,Colleage* clgB);
    void DoActionFromAtoB();
    void DoActionFromBtoA();
protected:
private:
    Colleage* _clgA;
    Colleage* _clgB;
};

#endif /* Mediator_hpp */
