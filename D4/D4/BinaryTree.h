//
//  BinaryTree.h
//  D4
//
//  Created by CX on 8/22/16.
//  Copyright © 2016 cx. All rights reserved.
//
#ifndef BinaryTree_h
#define BinaryTree_h

#import <Foundation/Foundation.h>
#include <iostream>

void TreeNodeTest();


class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x):val(x) {}
    TreeNode* invertTree(TreeNode *root);
};

@interface BinaryTreeNode : NSObject
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) BinaryTreeNode *leftNode;
@property (nonatomic, strong) BinaryTreeNode *rightNode;

+(instancetype)nodeWithValues:(NSArray *)values;

@end

#endif