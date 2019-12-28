//
//  BObjectRelationshipGraph.m
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/3.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import "BObjectRelationshipGraph.h"

@interface BObjectRelationshipGraph()

@property (nonatomic, strong) NSMutableArray<BObjectRelationshipNode *> *nodeStack;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *nodeAddressStack;
@property (nonatomic, strong) NSMutableString *nodePath;

@property (nonatomic, strong) BObjectRelationshipNode *rootNode;

@property (nonatomic, strong) NSMutableArray<NSString *> *leaksPathMarr;

@end

@implementation BObjectRelationshipGraph

- (instancetype)initWithRootNode:(BObjectRelationshipNode *)node
{
    if (self = [super init])
    {
        self.rootNode = node;
        self.nodeStack = @[].mutableCopy;
        self.nodeAddressStack = @[].mutableCopy;
        self.leaksPathMarr = @[].mutableCopy;
        [self.nodeStack addObject:node];
        [self.nodeAddressStack addObject:@([node objectAddress])];
        self.nodePath = [[NSMutableString alloc] initWithString:[node className]];
    }
    
    return self;
}

- (void)findLeak
{
    [self recursiveTraversalWithNode:self.rootNode];
}

/// 递归遍历
- (void)recursiveTraversalWithNode:(BObjectRelationshipNode *)node
{
    BOOL isPushStack = YES;
    
    while (self.nodeStack.count > 0)
    {
        @autoreleasepool {
            
            // 取栈顶元素
            BObjectRelationshipNode *topNode = [self.nodeStack lastObject];
                        
            if (isPushStack)
            {
                NSString *tempStr = [NSString stringWithFormat:@" -> %@",[topNode className]];
                [self.nodePath appendString:tempStr];
            }
           
            // 获取下一个节点
            BObjectRelationshipNode *nextNode = [topNode nextNode];
            
            if (nextNode)
            {
                if ([self.nodeAddressStack containsObject:@([nextNode objectAddress])])
                {
                    NSString *tempStr = [NSString stringWithFormat:@" -> %@",[nextNode className]];
                    [self.nodePath appendString:tempStr];
                    
                    [self.leaksPathMarr addObject:self.nodePath];
                    
                    NSLog(@"捕获到内存泄漏:%@", self.nodePath);
                }
                else
                {
                    [self.nodeStack addObject:nextNode];
                    
                    [self.nodeAddressStack addObject:@([nextNode objectAddress])];
                    
                    isPushStack = YES;
                }
            }
            else
            {
                [self.nodeStack removeLastObject];
                [self.nodeAddressStack removeLastObject];
                
                
                NSString *tempStr = [NSString stringWithFormat:@" -> %@",[topNode className]];
                [self popOnPath:tempStr];
                
                
                isPushStack = NO;
            }
        }
    }
    
    NSLog(@"查找结果:%@",self.leaksPathMarr);
}

- (void)popOnPath:(NSString *)tempStr
{
    if ([self.nodePath containsString:tempStr])
    {
        NSRange range = [self.nodePath rangeOfString:tempStr];

        if (self.nodePath.length >= range.location + range.length)
        {
            [self.nodePath deleteCharactersInRange:range];
        }
    }
}

@end
