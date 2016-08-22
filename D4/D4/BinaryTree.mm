//
//  BinaryTree.m
//  D4
//
//  Created by CX on 8/22/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "BinaryTree.h"

/**
 *    递归方式
 */
TreeNode* TreeNode::invertTree(TreeNode *root) {
    if (root != NULL) {
        TreeNode *tmp = root->left;
        root->left = root->right;
        root->right = tmp;
        
        root->left = invertTree(root->left);
        root->right = invertTree(root->right);
    }
    return root;
}

@implementation BinaryTreeNode

+(instancetype)nodeWithValues:(NSArray *)values {
    BinaryTreeNode *root = nil;
    for (NSInteger i=0; i<values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        root = [[self class] addTreeNode:root value:value];
    }
    return root;
}

+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value {
    //根节点不存在，创建节点
    if (!treeNode) {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
        NSLog(@"node:%@", @(value));
    }
    else if (value <= treeNode.value) {
        NSLog(@"to left");
        //值小于根节点，则插入到左子树
        treeNode.leftNode = [[self class] addTreeNode:treeNode.leftNode value:value];
    }
    else {
        NSLog(@"to right");
        //值大于根节点，则插入到右子树
        treeNode.rightNode = [[self class] addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

/**
 *    非递归方式
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {  return nil; }
    if (!rootNode.leftNode && !rootNode.rightNode) {  return rootNode; }
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        
        BinaryTreeNode *pLeft = node.leftNode;
        node.leftNode = node.rightNode;
        node.rightNode = pLeft;
        
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
        
    }
    
    return rootNode;
}

@end

