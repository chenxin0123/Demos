//
//  Memento.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Memento_hpp
#define Memento_hpp

#include <string> 
using namespace std;


class Memento;
    
class Originator {
public:
    Originator();
    Originator(const string& sdt);
    ~Originator();
    Memento* CreateMemento();
    void SetMemento(Memento* men);
    void RestoreToMemento(Memento* mt);
    string GetState();
    void SetState(const string& sdt);
    void PrintState();
protected:
private:
    string _sdt;
    Memento* _mt;
};
    
class Memento {
public:
protected:
private:
    friend class Originator;
    
    Memento();
    Memento(const string& sdt);
    ~Memento();
    void SetState(const string& sdt);
    string GetState();
private:
    string _sdt;
};

    
#endif /* Memento_hpp */
