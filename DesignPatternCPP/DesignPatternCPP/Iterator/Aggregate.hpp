//
//  Aggregate.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Aggregate_hpp
#define Aggregate_hpp

class Iterator;
typedef int Object;

class Aggregate {
public:
    virtual ~Aggregate();
    virtual Iterator* CreateIterator() = 0;
    virtual Object GetItem(int idx) = 0;
    virtual int GetSize() = 0;
protected:
    Aggregate();
    private:
};

class ConcreteAggregate:public Aggregate {
public:
    enum {SIZE = 3};
    ConcreteAggregate();
    ~ConcreteAggregate();
    Iterator* CreateIterator();
    Object GetItem(int idx);
    int GetSize();
protected:
private:
    Object _objs[SIZE];
};

#endif /* Aggregate_hpp */
