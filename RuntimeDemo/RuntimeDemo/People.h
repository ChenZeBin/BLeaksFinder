//
//  People.h
//  RuntimeDemo
//
//  Created by Corbin on 2019/11/18.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface People : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSMutableArray *marr;

@end

NS_ASSUME_NONNULL_END
