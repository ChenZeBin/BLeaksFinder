//
//  BLeakFinder.m
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/4.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import "BLeakFinder.h"
#import "BObjectRelationshipGraph.h"
#import "BObjctReference.h"

@implementation BLeakFinder

+ (void)findLeakWithObjc:(id)objc
{
    if (!objc)
    {
        return;
    }
    
    BIvarModel *ivarModel = [[BIvarModel alloc] initWithIvar:nil owner:objc];
    BObjectRelationshipNode *node = [[BObjectRelationshipNode alloc] initWithIvar:ivarModel];
    
    BObjectRelationshipGraph *graph = [[BObjectRelationshipGraph alloc] initWithRootNode:node];
    
    [graph findLeak];
}

@end
