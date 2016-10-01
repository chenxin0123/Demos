//
//  Flyweight.hpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Flyweight_hpp
#define Flyweight_hpp

#include <string> 
using namespace std;

class Flyweight {
public:
    virtual ~Flyweight();
    virtual void Operation(const string& extrinsicState);
    string GetIntrinsicState();
protected:
    Flyweight(string intrinsicState);
private:
    string _intrinsicState;
};

class ConcreteFlyweight:public Flyweight {
public:
    ConcreteFlyweight(string intrinsicState);
    ~ConcreteFlyweight();
    void Operation(const string& extrinsicState);
protected: private:
};

#endif /* Flyweight_hpp */
