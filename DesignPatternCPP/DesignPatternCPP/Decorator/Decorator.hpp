//
//  Decorator.hpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Decorator_hpp
#define Decorator_hpp

class Component {
public:
    virtual ~Component();
    virtual void Operation();
protected: Component();
private:
};

class ConcreteComponent:public Component {
public:
    ConcreteComponent();
    ~ConcreteComponent();
    void Operation();
protected:
private:
};

class Decorator:public Component {
public:
    Decorator(Component* com);
    virtual ~Decorator();
    void Operation();
protected:
    Component* _com;
private:
};

class ConcreteDecorator:public Decorator {
public:
    ConcreteDecorator(Component* com);
    ~ConcreteDecorator();
    void Operation();
    void AddedBehavior();
protected:
private:
};

#endif /* Decorator_hpp */
