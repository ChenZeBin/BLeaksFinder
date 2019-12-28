//
//  BObjectRelationshipNode.h
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/3.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BIvarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BObjectRelationshipNode : NSObject

@property (nonatomic, strong, readonly) BIvarModel *ivarModel;
@property (nonatomic, strong, readonly) id object;
@property (nonatomic, strong, readonly) NSSet<BObjectRelationshipNode *> *allSubNode;
@property (nonatomic, strong, readonly) NSEnumerator<BObjectRelationshipNode *> *nodeEnumerator;

- (instancetype)initWithIvar:(BIvarModel *)ivarModel;
- (BObjectRelationshipNode *)nextNode;
- (size_t)objectAddress;
- (NSString *)className;

@end

NS_ASSUME_NONNULL_END
