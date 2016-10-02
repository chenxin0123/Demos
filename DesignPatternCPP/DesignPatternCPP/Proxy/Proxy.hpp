//
//  Proxy.hpp
//  DesignPatternCPP
//
//  Created by CX on 10/2/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Proxy_hpp
#define Proxy_hpp

class Subject {
public:
    virtual ~Subject();
    virtual void Request() = 0;
protected: Subject();
};

class ConcreteSubject:public Subject {
public:
    ConcreteSubject();
    ~ConcreteSubject();
    void Request();
};

class Proxy {
public:
    Proxy();
    ~Proxy();
    Proxy(Subject* sub);
    void Request();
protected:
private: Subject* _sub;
};

#endif /* Proxy_hpp */
