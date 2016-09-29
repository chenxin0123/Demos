//
//  Singleton.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Singleton_hpp
#define Singleton_hpp

#include <iostream> 
using namespace std;

class Singleton {
public:
    static Singleton* Instance();
protected:
    Singleton();
private:
    static Singleton* _instance;
};

#endif /* Singleton_hpp */
