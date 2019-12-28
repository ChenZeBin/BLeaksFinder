//
//  BObjectRelationshipNode.m
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/3.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import "BObjectRelationshipNode.h"
#import "BObjctReference.h"

@implementation BObjectRelationshipNode

@synthesize ivarModel = _ivarModel;
@synthesize object = _object;
@synthesize allSubNode = _allSubNode;
@synthesize nodeEnumerator = _nodeEnumerator;

- (NSString *)description
{
    return [self className];
}

- (instancetype)initWithIvar:(BIvarModel *)ivarModel
{
    if (self = [super init])
    {
        _ivarModel = ivarModel;
    }
    
    return self;
}

- (NSSet<BObjectRelationshipNode *> *)allSubNode
{
    if (!_allSubNode)
    {
        id objc = [self.ivarModel getValue];
        BObjctReference *ship = [[BObjctReference alloc] initWithObjc:objc];
        NSArray<BIvarModel *> *arr = [ship allStrongIvarsFilterNil];
        
        NSMutableSet<BObjectRelationshipNode *> *resultMset = [[NSMutableSet alloc] init];
        
        [arr enumerateObjectsUsingBlock:^(BIvarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BObjectRelationshipNode *node = [[BObjectRelationshipNode alloc] initWithIvar:obj];
            [resultMset addObject:node];
        }];
        
        _allSubNode = resultMset;
    }
    
    return _allSubNode;
}

- (NSString *)className
{
    return NSStringFromClass([[self getValue] class]);
}

- (id)getValue
{
    return [self.ivarModel getValue];
}

- (size_t)objectAddress
{
    return (size_t)[self getValue];
}

- (id)object
{
    return self.ivarModel.ivarOwner;
}

- (BObjectRelationshipNode *)nextNode
{
    BObjectRelationshipNode *node = [self.nodeEnumerator nextObject];
    
    return node;
}

- (NSEnumerator<BObjectRelationshipNode *> *)nodeEnumerator
{
    if (!_nodeEnumerator)
    {
        _nodeEnumerator = [self.allSubNode objectEnumerator];
    }
    
    return _nodeEnumerator;
}

@end
