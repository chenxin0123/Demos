//
//  Command.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Command_hpp
#define Command_hpp

class Reciever;
class Command {
public:
    virtual ~Command();
    virtual void Excute() = 0;
protected:
    Command();
private:
};

class ConcreteCommand:public Command {
public:
    ConcreteCommand(Reciever* rev);
    ~ConcreteCommand();
    void Excute();
protected:
private:
    Reciever* _rev;
};

#endif /* Command_hpp */
