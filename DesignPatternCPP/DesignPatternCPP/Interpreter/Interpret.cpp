//
//  Interpret.cpp
//  DesignPatternCPP
//
//  Created by CX on 03/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#include "Interpret.hpp"
#include <iostream> 
using namespace std;

AbstractExpression::AbstractExpression() {
}
AbstractExpression::~AbstractExpression() {
}
void AbstractExpression::Interpret(const Interpreter_Context& c) {
}
TerminalExpression::TerminalExpression(const string& statement) {
    this->_statement = statement;
}
TerminalExpression::~TerminalExpression() {
}
void TerminalExpression::Interpret(const Interpreter_Context& c) {
    cout<<this->_statement<<" TerminalExpression"<<endl;
}
NonterminalExpression::NonterminalExpression(AbstractExpression* expression,int times) {
    this->_expression = expression;
    this->_times = times;
}
NonterminalExpression::~NonterminalExpression() {
}
void NonterminalExpression::Interpret(const Interpreter_Context& c) {
    for (int i = 0; i < _times ; i++) {
        this->_expression->Interpret(c);
    }
}
