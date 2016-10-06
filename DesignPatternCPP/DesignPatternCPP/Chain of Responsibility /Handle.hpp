//
//  Handle.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Handle_hpp
#define Handle_hpp

class Handle {
public:
    virtual ~Handle();
    virtual void HandleRequest() = 0;
    void SetSuccessor(Handle* succ);
    Handle* GetSuccessor();
protected:
    Handle();
    Handle(Handle* succ);
private:
    Handle* _succ;
};

class ConcreteHandleA:public Handle {
public:
    ConcreteHandleA();
    ~ConcreteHandleA();
    ConcreteHandleA(Handle* succ);
    void HandleRequest();
protected: private:
};

class ConcreteHandleB:public Handle {
public:
    ConcreteHandleB();
    ~ConcreteHandleB();
    ConcreteHandleB(Handle* succ);
    void HandleRequest();
protected: private:
};

#endif /* Handle_hpp */
