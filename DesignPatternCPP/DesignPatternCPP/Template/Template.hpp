//
//  Template.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Template_hpp
#define Template_hpp

class AbstractClass {
public:
    virtual ~AbstractClass();
    void TemplateMethod();
protected:
    virtual void PrimitiveOperation1() = 0;
    virtual void PrimitiveOperation2() = 0;
    AbstractClass();
private:
};

class ConcreteClass1:public AbstractClass {
public:
    ConcreteClass1();
    ~ConcreteClass1();
protected:
    void PrimitiveOperation1();
    void PrimitiveOperation2();
private:
};

class ConcreteClass2:public AbstractClass {
public:
    ConcreteClass2();
    ~ConcreteClass2();
protected:
    void PrimitiveOperation1();
    void PrimitiveOperation2();
private:
};

#endif /* Template_hpp */
