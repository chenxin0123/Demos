//
//  Observer.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Observer_hpp
#define Observer_hpp

#include <list> 
#include <string>

using namespace std;

namespace NS_Observer {

typedef string State;

class Observer;

class Subject {
public:
    virtual ~Subject();
    virtual void Attach(Observer* obv);
    virtual void Detach(Observer* obv);
    virtual void Notify();
    virtual void SetState(const State& st) = 0;
    virtual State GetState() = 0;
protected:
    Subject();
private:
    list<Observer* >* _obvs;
};
    
class ConcreteSubject:public Subject {
public:
    ConcreteSubject();
    ~ConcreteSubject();
    State GetState();
    void SetState(const State& st);
protected:
private:
    State _st;
};

class Observer {
public:
    virtual ~Observer();
    virtual void Update(Subject* sub) = 0;
    virtual void PrintInfo() = 0;
protected:
    Observer();
    State _st;
    private:
};
    
class ConcreteObserverA:public Observer {
public:
    virtual Subject* GetSubject();
    ConcreteObserverA(Subject* sub);
    virtual ~ConcreteObserverA();
    //传入 Subject 作为参数，这样可以让一个 View 属于多个的 Subject。
    void Update(Subject*sub);
    void PrintInfo();
protected:
private:
    Subject* _sub;
};
    
class ConcreteObserverB:public Observer {
public:
    virtual Subject* GetSubject();
    ConcreteObserverB(Subject* sub);
    virtual ~ConcreteObserverB();
    //传入 Subject 作为参数，这样可以让一个 View 属于多个的 Subject。
    void Update(Subject*sub);
    void PrintInfo();
protected:
private:
    Subject* _sub;
};
    
}

#endif /* Observer_hpp */
