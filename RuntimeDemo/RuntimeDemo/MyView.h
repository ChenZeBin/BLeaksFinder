//
//  MyView.h
//  RuntimeDemo
//
//  Created by Corbin on 2019/11/18.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyView : UIView

@property (nonatomic, strong) id delegate;
@property (nonatomic, copy) void(^block)(void);

@end

NS_ASSUME_NONNULL_END
