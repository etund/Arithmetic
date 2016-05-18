//
//  BinaryTree.m
//  Arithmetic
//
//  Created by liangyidong on 16/5/4.
//  Copyright © 2016年 liangyidong. All rights reserved.
//

#import "BinaryTree.h"
#import "BinaryTreeNode.h"
#import "TreeNodeProperty.h"

/**
 *  代码即文档
 */
@implementation BinaryTree

/**
 *  二叉树排序
 *  左节点的值比根节点小，右节点比根节点大
 *
 *  @param values 数组
 *
 *  @return 返回二叉树节点
 */
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values{
    BinaryTreeNode *binaryTreeNode = nil;
    for (NSInteger i = 0; i < values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        binaryTreeNode = [BinaryTree addTreeNode:binaryTreeNode value:value];
    }
    return binaryTreeNode;
}

/**
 *  添加节点
 *
 *  @param treeNode 节点
 *  @param value    值
 *
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode
                          value:(NSInteger)value{
    if(!treeNode){
        treeNode = [[BinaryTreeNode alloc] init];
        treeNode.value = value;
    }else if (value < treeNode.value){
        treeNode.leftNode = [BinaryTree addTreeNode:treeNode.leftNode value:value];
    }else{
        treeNode.rightNode = [BinaryTree addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

/**
 *  二叉树中某个位置的节点(按层次遍历的某一个点)
 *
 *  @param rootNode
 *
 *  @return
 */
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index
                             inTree:(BinaryTreeNode *)rootNode{
    if(!rootNode || index < 0){
        return nil;
    }
    NSMutableArray *nodes = [NSMutableArray array];
    [nodes addObject:rootNode];
    while (nodes.count > 0) {
        
        BinaryTreeNode *node = [nodes firstObject];
        
        if (index == 0) {
            return node;
        }
        
        [nodes removeObjectAtIndex:0];
        index--;
        
        if (node.leftNode) {
            [nodes addObject:node.leftNode];
        }
        
        if (node.rightNode) {
            [nodes addObject:node.rightNode];
        }
    }
    return nil;
}

/**
 *  先序遍历
 *  先遍历根节点，在遍历左节点，再遍历右节点
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode
                     handler:(void(^)(BinaryTreeNode *treeNode))handler{
    if (rootNode) {
        if (handler) {
            handler(rootNode);
        }
        [self preOrderTraverseTree:rootNode.leftNode handler:handler];
        [self preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/**
 *  中序遍历：先遍历左子树，在遍历根，再遍历右子树
 *
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点的处理函数
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode
                    handler:(void(^)(BinaryTreeNode *treeNode))handler{
    if (rootNode) {
        [self inOrderTraverseTree:rootNode.leftNode handler:handler];
        if (handler) {
            handler(rootNode.leftNode);
        }
        [self inOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/**
 *  后续遍历：先遍历左节点，在遍历右节点，再遍历根节点
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点的处理函数
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode
                      handler:(void(^)(BinaryTreeNode *treeNode))handler{
    if (rootNode) {
        [self postOrderTraverseTree:rootNode.leftNode handler:handler];
        [self postOrderTraverseTree:rootNode.rightNode handler:handler];
        if (handler) {
            handler(rootNode);
        }
    }
}

/**
 *  层次遍历：从上到下，从左到右，遍历完一层有遍历一层，因此又叫广度优先遍历。
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode
                  handler:(void(^)(BinaryTreeNode *treeNode))handler{
    if(!rootNode) return;
    NSMutableArray *nodes = [NSMutableArray array];
    while (nodes.count > 0) {
        BinaryTreeNode *node = [nodes firstObject];
        if (handler) handler(node);
        [nodes removeObjectAtIndex:0];
        if (node.leftNode) [nodes addObject:node.leftNode];
        if (node.rightNode) [nodes addObject:node.rightNode];
    }
}

/**
 *  二叉树的深度:从根节点到叶子节点依次经过的节点形成树的一条路径，最长路径的长度为树的深度。
 *
 *  1 如果根节点为空，则深度为0
 *  2 如果左右节点都是空，则深度为1
 *  3 递归思想：二叉树的深度 = max(右节点， 左节点)
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树的深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) return 0;
    
    if (!rootNode.leftNode && !rootNode.rightNode) return 1;
    
    NSInteger leftDeep = [self depthOfTree:rootNode.leftNode];
    
    NSInteger rightDeep = [self depthOfTree:rootNode.rightNode];
    
    return MAX(leftDeep, rightDeep) + 1;
}

/**
 *  二叉树宽度：各层节点数的最大值
 *
 *  @param rootNode 根节点
 *
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) return 0;
    NSInteger currentWidth = 0; // 当前的层的宽度
    NSInteger maxWidth = 1; // 因为有第一层的话，宽度就为1
    NSMutableArray *nodes = [NSMutableArray array];
    [nodes addObject:rootNode];
    while (nodes.count > 0) {
        currentWidth = nodes.count;
        for (int i = 0; i < currentWidth; i++) {
            BinaryTreeNode *node = [nodes firstObject];
            [nodes removeObjectAtIndex:0];  // 移除最开始哪一个
            if (node.leftNode) {
                [nodes addObject:node.leftNode];
            }
            if (node.rightNode) {
                [nodes addObject:node.rightNode];
            }
        }
        maxWidth = MAX(maxWidth, nodes.count);
    }
    return maxWidth;
}

/**
 *  二叉树的所有节点数：递归思想，二叉树所有节点数 = 左子树节点树 + 右子树节点树 + 1
 *
 *  @param rootNode 根节点
 */
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) return 0;
    return [self numberOfNodesInTree:rootNode.leftNode] + [self numberOfNodesInTree:rootNode.rightNode] + 1;
}

/**
 *  二叉树的某层中的节点数
 *  1 根节点为空，则节点数为0
 *  2 层为1，则节点数为1
 *  3 递归思想：二叉树第k层节点数 = 左子树第k-1层节点数 + 右子树第k-1层节点数，前提k > 1
 *
 *  @param level    指定某一层
 *  @param rootNode 根节点
 *
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level
                           inTree:(BinaryTreeNode *)rootNode{
    if (!rootNode || level < 1) return 0; // 根节点不存在或者level < 0
    if (level == 1) return 1;
    return [self numberOfNodesOnLevel:level - 1 inTree:rootNode.rightNode] + [self numberOfNodesOnLevel:level - 1 inTree:rootNode.leftNode];
}

/**
 *  二叉树叶子节点数：终端节点
 *  1 递归思想：叶子节点数，等于左子树和右子树都是空的节点
 *
 *  @param rootNode 根节点
 *
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) return 0;
    if (!rootNode.leftNode && !rootNode.rightNode) return 1;
    return [self numberOfLeafsInTree:rootNode.leftNode] + [self numberOfLeafsInTree:rootNode.rightNode];
}

/**
 *  二叉树最大距离： 二叉树任意两个节点有且仅有一条路径，这个路径的长度叫这两个节点的距离。二叉树中所有节点之间的距离的最大值就是二叉树的直径。
 *  三种情况
 *
 *      1 这两个节点分别在根节点的右子树和左子树上，他们之间的路径肯定经过根节点，而且他们肯定是根节点左右子树上最远的叶子节点数(他们到根节点的角力=左右子树的深度)
 *      2 这两个节都在左子树上
 *      3 这两个几点都在右子树上
 *
 *  @param rootNode 根节点
 *
 */
/**
 *  二叉树最大距离：方案一
 *  缺点：这个方案的效率较低，因为计算子树的深度和最远距离是分开递归的，存在重读递归遍历的情况。
 *
 */
+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode{
    NSInteger distance = [self depthOfTree:rootNode.leftNode] + [self depthOfTree:rootNode.rightNode];
    NSInteger distanceLeft = [self maxDistanceOfTree:rootNode.leftNode];
    NSInteger distanceRight = [self maxDistanceOfTree:rootNode.rightNode];
    return MAX(MAX(distanceLeft, distanceRight), distance);
}

/**
 *  二叉树最大距离：方案二
 *
 */
+ (NSInteger)maxDistanceOfTree_Fast:(BinaryTreeNode *)rootNode{
    if (!rootNode) return 0;
    TreeNodeProperty *p = [self propertyOfTreeNode:rootNode];
    return p.distance;
}


+ (TreeNodeProperty *)propertyOfTreeNode:(BinaryTreeNode *)rootNode{
    if (!rootNode) return nil;
    TreeNodeProperty *left = [self propertyOfTreeNode:rootNode.leftNode];
    TreeNodeProperty *right = [self propertyOfTreeNode:rootNode.rightNode];
    TreeNodeProperty *p = [[TreeNodeProperty alloc] init];
    p.depth = MAX(left.depth, right.depth) + 1; // 最深的距离等于（左子树深度 + 右子树深度）+ 1
    p.distance = MAX(MAX(left.distance, right.distance), left.depth + right.depth); // 最远距离 = 左子树最远距离，右子树最远距离和横跨左右字数最远距离中最大值。
    return p;
}

/**
 *  寻找某一个节点到根节点的路径(不是队列，但还是可以用数组来实现的)
 *
 *  @param treeNode 指定节点
 *  @param rootNode 根节点
 *
 */
+ (NSArray *)pathOfTreeNode:(BinaryTreeNode *)treeNode
                     inTree:(BinaryTreeNode *)rootNode{
    NSMutableArray *array = [NSMutableArray array];
    [self isFoundTreeNode:treeNode inTree:rootNode routePath:array];
    return array;
}

/**
 *  查找某个节点是否在树中间那个
 *
 *  @param treeNode 制定查找的节点
 *  @param rootNode 根节点
 *
 */
+ (BOOL)isFoundTreeNode:(BinaryTreeNode *)treeNode
                 inTree:(BinaryTreeNode *)rootNode
              routePath:(NSMutableArray *)path{
    if (!treeNode || !rootNode) return NO;
    if (treeNode == rootNode){
        [path addObject:rootNode];
        return YES; // 找到了,返回真
    }
    
    [path addObject:rootNode];
    
    BOOL find = [self isFoundTreeNode:treeNode inTree:rootNode.leftNode routePath:path]; // 先从左子树找
    if (!find) [self isFoundTreeNode:treeNode inTree:rootNode.rightNode routePath:path];
    
    if (!find) [path removeLastObject]; // 两边找不到，就弹出这个节点
    
    return find;
}

/**
 *  二叉树中两个节点最近的公共父节点
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 */
+ (BinaryTreeNode *)parentOfNode:(BinaryTreeNode *)nodeA
                         andNode:(BinaryTreeNode *)nodeB
                          inTree:(BinaryTreeNode *)rootNode{
    if (!nodeA || !nodeB || !rootNode) return nil;
    if (nodeA == nodeB) return nodeA;
    
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];//     根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];//     根节点到节点A的路径
    if (pathA.count == 0 || pathA.count == 0) return nil; // 其中一个节点不在树中，则没有公共父节点
    
    for (NSInteger i = pathA.count - 1; i >= 0; i--) { // 由于获取的路径是栈，所以从后往前推，查找第一个出现的公共节点
        for (NSInteger j = pathB.count - 1; j >= 0; j--) {
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                return [pathA objectAtIndex:i];
            }
        }
    }
    return nil;
}

/**
 *  二叉树中两个节点之间的路径
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 */
+ (NSArray *)pathFromNode:(BinaryTreeNode *)nodeA
                   toNode:(BinaryTreeNode *)nodeB
                   inTree:(BinaryTreeNode *)rootNode{
    if (!nodeA || !nodeB || !rootNode) return nil;
    NSMutableArray *path = [NSMutableArray array];
    if (nodeA == nodeB) {
        [path addObject:nodeA];
        return path;
    }
    
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode]; // 从根节点到节点A的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode]; // 从根节点到节点B的路径
    
    if (pathA.count == 0 || pathB.count == 0) return nil;
    for (NSInteger i = pathA.count - 1; i >= 0; i--) { // 由于获取的路径是栈，所以从后往前推，查找第一个出现的公共节点
        [path addObject:[path objectAtIndex:i]];
        for (NSInteger j = pathB.count - 1; j >= 0; j--) {
            //            找到公共父节点，则将pathB中后面的节点压进path
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                j++; // 避免重复添加公共父节点
                while (j < pathB.count) {
                    [path addObject:[pathB objectAtIndex:j]];
                    j++;
                }
                return path;
            }
        }
    }
    return nil;
}

/**
 *  二叉树两个节点之间的距离
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 */
+ (NSInteger)distanceFromNode:(BinaryTreeNode *)nodeA
                       toNode:(BinaryTreeNode *)nodeB
                       inTree:(BinaryTreeNode *)rootNode{
    if (!nodeA || !nodeB || !rootNode) return -1;
    if (nodeA == nodeB) return 0;
    
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];//     根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];//     根节点到节点A的路径
    if (pathA.count == 0 || pathA.count == 0) return -1; // 其中一个节点不在树中，则没有公共父节点
    
    for (NSInteger i = pathA.count - 1; i >= 0; i--) { // 由于获取的路径是栈，所以从后往前推，查找第一个出现的公共节点
        for (NSInteger j = pathB.count - 1; j >= 0; j--) {
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                //             距离 = 路径节点数 - 1(这里-2是因为这里有一个公共父节点)
                return (pathA.count - i) + (pathB.count - j) - 2;
            }
        }
    }
    return -1;
}

/**
 *  翻转二叉树：也叫二叉树的镜像，就是把二叉树的左右子树对调
 *  Google: 90% of our engineers use the software you wrote (Homebrew), but you can’t invert a binary tree on a whiteboard so fuck off.
 *
 *
 *
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) return nil;
    if (!rootNode.leftNode && !rootNode.rightNode) return rootNode;
    
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    
    BinaryTreeNode *temNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = temNode;
    
    return rootNode;
}

/**
 *  判断二叉树是否完全二叉树
 *  完全二叉树定义为：若设二叉树的高度为h，除第h层外，其他各层的节点数都达到醉倒个数，第h层有叶子节点，并且叶子节点都是从左到右依次排布的。
 *  完全二叉树必须满足的2个条件
 *      1 如果某个节点的右子树不为空，则右子树必须不为空
 *      2 如果某个节点的右子树为空，则排在后面的节点必须没有孩子孩子节点
 *  这里还需要理解"排在他后面的节点"，回头看看层次遍历算法，我们就能知道在层次遍历时，是从上到下从左到右遍历的，先将根节点弹出队列，再亚入孩子及诶单，因"排在它后面的节点"有两种情况
 *      1 同层次的后面的节点
 *      2 同层次的前面的节点的孩子节点(因为遍历前面的节点时，会弹出节点，同事将孩子节点压入队列)
 *  通过以上分析，我们设置一个标志位flag，当子树满足完全二叉树，设置flag = YES。当flag = YES而节点有破坏完全二叉树的条件，那么他就不是完全二叉树。
 *
 *  @param rootNode 根节点
 *
 */
+ (BOOL)isCompleteBinaryTree:(BinaryTreeNode *)rootNode {
    if(!rootNode){
        return NO;
    }
    
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return YES;
    }
    
    if (!rootNode.leftNode && rootNode.rightNode) {
        return NO;
    }
    //    按层次遍历节点，找到满足完全二叉树的条件：
    //      1 如果某个节点的右子树不为空，则他的左子树必须不为空
    //      2 如果某个节点的右子树为空，则排在他后面的节点的孩子节点必须为空
    //    排在该节点后面的节点有两种
    //      1 同层次后面的节点
    //      2 同层次的前面的节点的孩子节点（因为在遍历节点的时候会把节点从队列里面pop，并且将其子节点push进队列）
    NSMutableArray *nodes = [NSMutableArray array];
    [nodes addObject:rootNode];
    BOOL isComplete = NO;
    while (nodes.count > 0) {
        BinaryTreeNode *node = [nodes firstObject];
        [nodes removeObjectAtIndex:0];
        
        if (!node.leftNode && node.rightNode) { // 条件一
            return NO;
        }
        
        if (isComplete && (node.leftNode || node.rightNode)) { // 条件二
            return NO;
        }
        
        if(!node.rightNode){
            isComplete = YES;
        }
        
        //        打进队列
        if (node.leftNode) {
            [nodes addObject:node.leftNode];
        }
        
        if (node.rightNode) {
            [nodes addObject:node.rightNode];
        }
    }
    return NO;
}

/**
 *  是否满二叉树
 *      定义：除了叶节点外，每一个节点都有左右子叶且叶子节点都处在最底层的二叉树
 *      特性：吃椰子树= 2^(深度 - 1)
 *
 *  @param rootNode 根节点
 *
 */
+ (BOOL)isFullBinaryTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return NO;
    }
    
    NSInteger depth = [self depthOfTree:rootNode];
    NSInteger leafNum = [self numberOfLeafsInTree:rootNode];
    
    if (leafNum == pow(2, depth - 1)) {
        return YES;
    }
    return NO;
}


static NSInteger height;
/**
 *  是否为平衡二叉树
 *      定义：他是一个空树，或他的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一颗平衡二叉树
 *
 *  @param rootNode 根节点
 *
 */
+ (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode{
    
    if(!rootNode) { // 空树
        height = 0;
        return YES;
    }
    
    if (!rootNode.leftNode && !rootNode.rightNode ) { // 只有一个节点的树
        height = 1;
        return YES;
    }
    
    BOOL isAVLLeft = [self isAVLBinaryTree:rootNode.leftNode];
    NSInteger leftHeight = height;
    BOOL isAVLRight = [self isAVLBinaryTree:rootNode.rightNode];
    NSInteger rightHeight = height;
    
    height = MAX(leftHeight, rightHeight) + 1; // 根节点 + 1;
    
    if (isAVLLeft && isAVLRight && ABS(leftHeight - rightHeight) <= 1) {
        return YES;
    }
    return NO;
    
}

/**
 *  重建二叉树
 *  先序遍历的第一个元素是根节点，根节点左右的为左右子树
 *
 *  @return
 */
+ (BinaryTreeNode *)reCreateTreeWithPre:(NSArray<NSNumber *> *)preA
                                 center:(NSArray<NSNumber *> *)cenA{
    if (preA == nil || cenA == nil || preA.count != cenA.count) {
        return nil;
    }
    
    NSNumber *root_node = preA[0]; // 先序序遍历的第一个数字就是根节点
    BinaryTreeNode *node = [[BinaryTreeNode alloc] init];
    
    for (int i = 0; i < cenA.count; i++) { //
        if (root_node == cenA[i]) {
            if (i > 0) { // 排除边界情况 一个根节点
                node.leftNode = [self reCreateTreeWithPre:[preA subarrayWithRange:NSMakeRange(1, i + i)] center:[cenA subarrayWithRange:NSMakeRange(0, i)]];
            }
            if (i < cenA.count + 1){ // 排除边界情况只有一个左右子树,中序遍历的的i是某一个根节点，所以要i + 1
                node.rightNode = [self reCreateTreeWithPre:[preA subarrayWithRange:NSMakeRange(i + 1, preA.count)] center:[cenA subarrayWithRange:NSMakeRange(i + 1, cenA.count)]];
            }
            return node;
        }
    }
    return nil;
}

@end
