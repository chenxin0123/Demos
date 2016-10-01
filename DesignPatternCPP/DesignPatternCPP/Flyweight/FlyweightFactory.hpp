//
//  FlyweightFactory.hpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef FlyweightFactory_hpp
#define FlyweightFactory_hpp

#include "Flyweight.hpp" 
#include <string> 
#include <vector> 

using namespace std;

class FlyweightFactory {
public:
    FlyweightFactory();
    ~FlyweightFactory();
    Flyweight* GetFlyweight(const string& key);
protected:
private:
    vector<Flyweight*> _fly;
};

#endif /* FlyweightFactory_hpp */
