//
//  Component.hpp
//  DesignPatternCPP
//
//  Created by CX on 10/1/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Component_hpp
#define Component_hpp

namespace NS_Composite {
    
class Component {
public:
    Component();
    virtual ~Component();
public:
    virtual void Operation() = 0;
    virtual void Add(const Component& );
    virtual void Remove(const Component& );
    virtual Component* GetChild(int);
protected:
private:
};
    
}

#endif /* Component_hpp */
