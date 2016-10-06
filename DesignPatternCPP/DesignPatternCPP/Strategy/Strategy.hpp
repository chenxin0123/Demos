//
//  Strategy.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Strategy_hpp
#define Strategy_hpp

class Strategy {
public:
    Strategy();
    virtual ~Strategy();
    virtual void AlgrithmInterface() = 0;
protected: private:
};
class ConcreteStrategyA:public Strategy {
public:
    ConcreteStrategyA();
    virtual ~ConcreteStrategyA();
    void AlgrithmInterface();
    protected: private:
};
class ConcreteStrategyB:public Strategy {
public:
    ConcreteStrategyB();
    virtual ~ConcreteStrategyB();
    void AlgrithmInterface();
protected: private:
};

#endif /* Strategy_hpp */
