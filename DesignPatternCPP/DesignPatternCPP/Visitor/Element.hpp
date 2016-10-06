//
//  Element.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Element_hpp
#define Element_hpp

class Visitor;
class Element {
public:
    virtual ~Element();
    virtual void Accept(Visitor* vis) = 0;
protected:
    Element();
private:
};

class ConcreteElementA:public Element {
public:
    ConcreteElementA(); ~ConcreteElementA(); void Accept(Visitor* vis);
    protected: private:
};

class ConcreteElementB:public Element {
public:
    ConcreteElementB(); ~ConcreteElementB(); void Accept(Visitor* vis);
protected: private:
};

#endif /* Element_hpp */
