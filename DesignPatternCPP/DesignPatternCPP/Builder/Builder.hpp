//
//  Builder.hpp
//  DesignPatternCPP
//
//  Created by CX on 9/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Builder_hpp
#define Builder_hpp

#include <iostream> 
using namespace std;

namespace NS_Builder {
    
    class Product {
    public:
        Product();
        ~Product();
        void ProducePart();
    protected:
    private:
    };
    
    class ProductPart {
    public:
        ProductPart();
        ~ProductPart();
        ProductPart* BuildPart();
        protected:
        private:
    };
    
    class Builder {
    public:
        virtual ~Builder();
        virtual void BuildPartA(const string& buildPara) = 0;
        virtual void BuildPartB(const string& buildPara) = 0;
        virtual void BuildPartC(const string& buildPara) = 0;
        virtual Product* GetProduct() = 0;
    protected:
        Builder();
    private:
    };
    
    class ConcreteBuilder:public Builder {
    public:
        ConcreteBuilder();
        ~ConcreteBuilder();
        void BuildPartA(const string& buildPara);
        void BuildPartB(const string& buildPara);
        void BuildPartC(const string& buildPara);
        Product* GetProduct();
    protected:
    private:
    };
}

#endif /* Builder_hpp */
