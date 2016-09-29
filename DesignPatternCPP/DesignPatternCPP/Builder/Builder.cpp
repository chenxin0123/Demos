//
//  Builder.cpp
//  DesignPatternCPP
//
//  Created by CX on 9/29/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Builder.hpp"

namespace NS_Builder {
    
    Product::Product() {
        ProducePart();
        cout<<"return a product"<<endl;
    }
    Product::~Product() {}
    
    void Product::ProducePart() {
        cout<<"build part of product.."<<endl;
    }
    
    ProductPart::ProductPart() {
        cout<<"build productpart.."<<endl;
    }
    
    ProductPart::~ProductPart() {}
    
    ProductPart* ProductPart::BuildPart() {
        return new ProductPart;
    }
    
    Builder::Builder() {}
    Builder::~Builder() {}
    ConcreteBuilder::ConcreteBuilder() {}
    ConcreteBuilder::~ConcreteBuilder() {}
    
    void ConcreteBuilder::BuildPartA(const string& buildPara) {
        cout<<"Step1:Build PartA..."<<buildPara<<endl;
    }
    
    void ConcreteBuilder::BuildPartB(const string& buildPara) {
        cout<<"Step1:Build PartB..."<<buildPara<<endl;
    }
    
    void ConcreteBuilder::BuildPartC(const string& buildPara) {
        cout<<"Step1:Build PartC..."<<buildPara<<endl;
    }
    
    Product* ConcreteBuilder::GetProduct() {
        BuildPartA("pre-definedA");
        BuildPartB("pre-definedB");
        BuildPartC("pre-definedC");
        return new Product();
    }
}

