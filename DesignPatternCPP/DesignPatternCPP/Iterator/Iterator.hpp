//
//  Iterator.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Iterator_hpp
#define Iterator_hpp

class Aggregate;
typedef int Object;

class Iterator {
public:
    virtual ~Iterator();
    virtual void First() = 0;
    virtual void Next() = 0;
    virtual bool IsDone() = 0;
    virtual Object CurrentItem() = 0;
protected:
    Iterator();
    private:
};

class ConcreteIterator:public Iterator {
public:
    ConcreteIterator(Aggregate* ag , int idx = 0);
    ~ConcreteIterator();
    void First();
    void Next();
    bool IsDone();
    Object CurrentItem();
protected:
private:
    Aggregate* _ag;
    int _idx;
};

#endif /* Iterator_hpp */
