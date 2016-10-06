//
//  state.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef state_hpp
#define state_hpp

#include "Context_State.hpp"
    
class State {
public:
    State();
    virtual ~State();
    virtual void OperationInterface(Context_State* ) = 0;
    virtual void OperationChangeState(Context_State*) = 0;
protected:
    bool ChangeState(Context_State* con,State* st);
private:
};

class ConcreteStateA:public State {
public:
    ConcreteStateA();
    virtual ~ConcreteStateA();
    virtual void OperationInterface(Context_State* );
    virtual void OperationChangeState(Context_State*);
    protected: private:
};
class ConcreteStateB:public State {
public:
    ConcreteStateB();
    virtual ~ConcreteStateB();
    virtual void OperationInterface(Context_State* );
    virtual void OperationChangeState(Context_State*);
protected:
private:
};

#endif /* state_hpp */
