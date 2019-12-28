//
//  BLeakFinder.h
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/4.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLeakFinder : NSObject

+ (void)findLeakWithObjc:(id)objc;

@end

NS_ASSUME_NONNULL_END
