//
//  People.m
//  RuntimeDemo
//
//  Created by Corbin on 2019/11/18.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import "People.h"

@implementation People

- (NSMutableArray *)marr
{
    if (!_marr)
    {
        _marr = @[].mutableCopy;
    }
    
    return _marr;
}

@end
