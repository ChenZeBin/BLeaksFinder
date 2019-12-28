//
//  BViewController.m
//  RuntimeDemo
//
//  Created by Corbin on 2019/11/18.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import "BViewController.h"
#import "MyView.h"
#import "People.h"
#import "BObjctReference.h"
#import "BLeakFinder.h"
#import "AViewController.h"

@interface BViewController ()

@property (nonatomic, strong) MyView *myView;
@property (nonatomic, strong) People *people;
@property (nonatomic, strong) AViewController *avc;
@end

@implementation BViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myView = [MyView new];
    self.myView.delegate = self;
    self.people = [People new];
    self.avc = [[AViewController alloc] init];
    self.myView.block = ^{
        [self.people.marr addObject:self.avc];
    };
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//            NSArray<IvarModel *> *result = [[FindLeakHelper new] allStrongObjcsWithClass:[weakSelf class]];
//
//           [result enumerateObjectsUsingBlock:^(IvarModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//               id sss = object_getIvar(weakSelf,obj.ivar);
//               NSLog(@"%@,%@",sss, obj.class);
//           }];
        
        
        [BLeakFinder findLeakWithObjc:weakSelf];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"delloc");
}


@end
