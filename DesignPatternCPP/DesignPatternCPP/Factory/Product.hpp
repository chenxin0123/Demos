//
//  Product.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/17/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Product_hpp
#define Product_hpp

class Product {
public:
    virtual ~Product() = 0;
protected:
    Product();
private:
};

class ConcreteProduct : public Product {
public:
    ~ConcreteProduct();
    ConcreteProduct();
protected:
private:
};


#endif /* Product_hpp */
