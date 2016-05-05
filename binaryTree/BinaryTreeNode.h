//
//  BinaryTreeNode.h
//  Arithmetic
//
//  Created by liangyidong on 16/5/4.
//  Copyright © 2016年 liangyidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

/**
 *  值
 */
@property (nonatomic, assign) NSInteger value;

/**
 *  左节点
 */
@property (nonatomic, strong) BinaryTreeNode *leftNode;

/**
 *  右节点
 */
@property (nonatomic, strong) BinaryTreeNode *rightNode;

@end
