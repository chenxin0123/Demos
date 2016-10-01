//
//  Facade.hpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Facade_hpp
#define Facade_hpp

class Subsystem1 {
public:
    Subsystem1();
    ~Subsystem1();
    void Operation();
protected:
private:
};

class Subsystem2 {
public:
    Subsystem2();
    ~Subsystem2();
    void Operation();
protected:
private:
};

class Facade {
public:
    Facade();
    ~Facade();
    void OperationWrapper();
protected:
private:
    Subsystem1* _subs1;
    Subsystem2* _subs2;
};

#endif /* Facade_hpp */
