//
//  Invoker.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Invoker_hpp
#define Invoker_hpp

class Command;
class Invoker {
public:
    Invoker(Command* cmd);
    ~Invoker();
    void Invoke();
protected:
private: Command* _cmd;
};

#endif /* Invoker_hpp */
