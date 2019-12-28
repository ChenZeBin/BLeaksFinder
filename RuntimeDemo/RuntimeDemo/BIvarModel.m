//
//  BIvarModel.m
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/3.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import "BIvarModel.h"

@implementation BIvarModel

@synthesize ivarOwner = _ivarOwner;
@synthesize ivar = _ivar;
@synthesize name = _name;
@synthesize ivarType = _ivarType;
@synthesize index = _index;
@synthesize offset = _offset;

- (instancetype)initWithIvar:(nullable Ivar)ivar owner:(id)ivarOwner
{
    if (self = [super init])
    {
        _ivarOwner = ivarOwner;
        
        if (ivar)
        {
            _ivar = ivar;
            _offset = ivar_getOffset(_ivar);
            _index =  _offset / sizeof(void *);
            
            const char *ivarName = ivar_getName(_ivar);
            const char *ivarType = ivar_getTypeEncoding(_ivar);
            
            _name = [[NSString alloc] initWithUTF8String:ivarName];
            _ivarType = [self convertEncodingToType:ivarType];
        }
    }
    
    return self;
}

#pragma mark - Public
- (id)getValue
{
    if (!self.ivar)
    {
        return self.ivarOwner;
    }
    
    return object_getIvar(self.ivarOwner,self.ivar);
}

- (NSString *)className
{
    if (self.ivar)
    {
        return NSStringFromClass([[self getValue] class]);
    }
    else
    {
        return NSStringFromClass([self.ivarOwner class]);
    }
}

#pragma mark - Private
- (BIvarType)convertEncodingToType:(const char *)typeEncoding
{
  if (typeEncoding[0] == '{') {
    return BIvarStructType;
  }

  if (typeEncoding[0] == '@') {
    // It's an object or block

    // Let's try to determine if it's a block. Blocks tend to have
    // @? typeEncoding. Docs state that it's undefined type, so
    // we should still verify that ivar with that type is a block
    if (strncmp(typeEncoding, "@?", 2) == 0) {
      return BIvarBlockType;
    }

    return BIvarObjectType;
  }

  return BIvarUnknownType;
}


@end
