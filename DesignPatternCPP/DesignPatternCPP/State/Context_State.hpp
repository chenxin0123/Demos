//
//  Context_State.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Context_State_hpp
#define Context_State_hpp

class State;


class Context_State {
public:
    Context_State();
    ~Context_State();
    Context_State(State* state);
    void OprationInterface();
    void OperationChangState();
protected:
private:
    friend class State;
    bool ChangeState(State* state);
private:
    State* _state;
};


#endif /* Context_State_hpp */
