//
//  BIvarModel.h
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/3.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BIvarType) {
    BIvarObjectType,
    BIvarBlockType,
    BIvarStructType,
    BIvarUnknownType,
};

@interface BIvarModel : NSObject

- (instancetype)initWithIvar:(nullable Ivar)ivar owner:(id)ivarOwner;

@property (nonatomic, weak, readonly) id ivarOwner;
@property (nonatomic, assign, readonly) Ivar ivar;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) BIvarType ivarType;
@property (nonatomic, assign, readonly) NSInteger index;
@property (nonatomic, assign, readonly) ptrdiff_t offset;

- (id)getValue;
- (NSString *)className;

@end

NS_ASSUME_NONNULL_END
