//
//  Adapter.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/30/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Adapter_hpp
#define Adapter_hpp

//#define AdapterClassMode

#ifdef AdapterClassMode

class Target {
public:
    Target();
    virtual ~Target();
    virtual void Request();
protected:
private:
};

class Adaptee {
public:
    Adaptee(); ~Adaptee();
    void SpecificRequest();
protected:
private:
};

class Adapter:public Target,private Adaptee {
public:
    Adapter();
    ~Adapter();
    void Request();
protected:
private:
};

#else

class Target {
public:
    Target();
    virtual ~Target();
    virtual void Request();
    protected: private:
};

class Adaptee {
public:
    Adaptee(); ~Adaptee();
    void SpecificRequest();
    protected:
    private:
};

class Adapter:public Target {
public:
    Adapter(Adaptee* ade);
    ~Adapter();
    void Request();
protected:
private:
    Adaptee* _ade;
};

#endif

#endif /* Adapter_hpp */
