//
//  ViewController.m
//  RuntimeDemo
//
//  Created by Corbin on 2019/11/12.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "People.h"
#import "BViewController.h"
#import "BObjctReference.h"

@interface ViewController ()

@property (nonatomic, assign) int int333;
@property (nonatomic, strong) UIView *view1;

@property (nonatomic, assign) NSInteger view2;
@property (nonatomic, assign) int int222;

@property (nonatomic, weak) UIView *view3;
@property (nonatomic, copy) NSString *str;

@property (nonatomic, copy) void(^ssss)(void);
@property (nonatomic, assign) int int111;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    BViewController *b = [BViewController new];
    b.delegate = self;
    [self presentViewController:b animated:YES completion:nil];
}

@end
