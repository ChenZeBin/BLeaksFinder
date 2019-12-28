//
//  MyView.m
//  RuntimeDemo
//
//  Created by Corbin on 2019/11/18.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import "MyView.h"
#import "AViewController.h"

@interface MyView()

@property (nonatomic, strong) AViewController *vc;

@end

@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        self.vc = [[AViewController alloc] init];
//        self.vc.delegate = self;
    }
    
    return self;
}

@end
