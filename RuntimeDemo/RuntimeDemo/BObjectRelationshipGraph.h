//
//  BObjectRelationshipGraph.h
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/3.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BObjectRelationshipNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface BObjectRelationshipGraph : NSObject

- (instancetype)initWithRootNode:(BObjectRelationshipNode *)node;
- (void)findLeak;

@end

NS_ASSUME_NONNULL_END
