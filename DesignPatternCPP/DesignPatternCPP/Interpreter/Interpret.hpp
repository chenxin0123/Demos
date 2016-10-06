//
//  Interpret.hpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Interpret_hpp
#define Interpret_hpp

#include "Interpreter_Context.hpp"
#include <string> 
using namespace std;

class AbstractExpression {
public:
    virtual ~AbstractExpression();
    virtual void Interpret(const Interpreter_Context& c);
protected:
    AbstractExpression();
    private:
};
class TerminalExpression:public AbstractExpression {
public:
    TerminalExpression(const string& statement);
    ~ TerminalExpression();
    void Interpret(const Interpreter_Context& c);
protected:
private:
    string _statement;
};
class NonterminalExpression:public AbstractExpression {
public:
    NonterminalExpression(AbstractExpression* expression,int times); ~ NonterminalExpression();
    void Interpret(const Interpreter_Context& c);
protected:
private:
    AbstractExpression* _expression;
    int _times;
};


#endif /* Interpret_hpp */
