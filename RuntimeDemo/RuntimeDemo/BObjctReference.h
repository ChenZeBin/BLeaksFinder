//
//  BObjctReference.h
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/3.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BIvarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BObjctReference : NSObject

- (instancetype)initWithObjc:(id)objc;

@property (nonatomic, weak, readonly) id objc;

/// 获取指定类(包括子类和父类)的所有强引用且不为空的成员变量
- (NSArray<BIvarModel *> *)allStrongIvarsFilterNil;

/// 获取指定类的所有强引用成员变量(包括父类，子类)
- (NSArray<BIvarModel *> *)allStrongIvars;

/// 获取指定类的所有强引用成员变量
- (NSArray<BIvarModel *> *)getSpecifiedClassStrongIvars:(Class)class;

@end

NS_ASSUME_NONNULL_END
