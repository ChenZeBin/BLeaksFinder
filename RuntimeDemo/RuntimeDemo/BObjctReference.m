//
//  BObjctReference.m
//  RuntimeDemo
//
//  Created by ChenZeBin on 2019/12/3.
//  Copyright © 2019 ChenZeBin. All rights reserved.
//

#import "BObjctReference.h"

@implementation BObjctReference

@synthesize objc = _objc;

- (instancetype)initWithObjc:(id)objc
{
    if (!objc)
    {
        return nil;
    }
    
    if (self = [super init])
    {
        _objc = objc;
    }
    
    return self;
}

- (NSArray<BIvarModel *> *)getIvarsWithClass:(Class)class
{
    unsigned int outCount;
    
    NSMutableArray *mArr = @[].mutableCopy;
    
    Ivar *ivars = class_copyIvarList(class, &outCount);
    
    for (int i = 0; i < outCount; i++)
    {
        Ivar ivar = ivars[i];
        
        BIvarModel *model = [[BIvarModel alloc] initWithIvar:ivar owner:self.objc];
                
        [mArr addObject:model];
    }
    
    free(ivars);
    
    return mArr.copy;
}

#pragma mark - Public
- (NSArray<BIvarModel *> *)allStrongIvarsFilterNil
{
    NSArray<BIvarModel *> *arr = [self allStrongIvars];
    
    NSMutableArray *resultMarr = @[].mutableCopy;
    
    [arr enumerateObjectsUsingBlock:^(BIvarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [obj getValue];
        
        if (value)
        {
            [resultMarr addObject:obj];
        }
    }];
    
    return resultMarr;
}

/// 获取指定类所有变量，除了Unknown
- (NSArray<BIvarModel *> *)getIvarsFilterUnknownIvarWithClass:(Class)class
{
    NSArray<BIvarModel *> *allIvars = [self getIvarsWithClass:class];
    
    // 过滤掉IvarUnknownType的对象
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        if ([evaluatedObject isKindOfClass:[BIvarModel class]]) {
            BIvarModel *model = evaluatedObject;
            return model.ivarType != BIvarUnknownType;
        }
        return YES;
    }];
    
    NSArray<BIvarModel *> *ivars = [allIvars filteredArrayUsingPredicate:predicate];
    
    return ivars;
}

- (NSArray<BIvarModel *> *)allStrongIvars
{
    NSMutableArray<BIvarModel *> *array = @[].mutableCopy;
    NSMutableDictionary<Class, NSArray<BIvarModel *> *> *ivarsDict = @{}.mutableCopy;
    
    __unsafe_unretained Class previousClass = nil;
    __unsafe_unretained Class currentClass = [self.objc class];

    while (previousClass != currentClass) {
      NSArray<BIvarModel *> *ivars;
      
      if (ivarsDict && currentClass) {
        ivars = ivarsDict[currentClass];
      }
      
      if (!ivars) {
        ivars = [self getSpecifiedClassStrongIvars:currentClass];
        if (ivarsDict && currentClass) {
          ivarsDict[currentClass] = ivars;
        }
      }
      [array addObjectsFromArray:ivars];

      previousClass = currentClass;
      currentClass = class_getSuperclass(currentClass);
    }

    return [array copy];
}

- (NSArray<BIvarModel *> *)getSpecifiedClassStrongIvars:(Class)class
{
    const uint8_t *ivarReferenceTypePrt = class_getIvarLayout(class);

    if (!ivarReferenceTypePrt)
    {
      return nil;
    }
    
    NSArray<BIvarModel *> *ivars = [self getIvarsFilterUnknownIvarWithClass:class];
        
    NSUInteger minimumIndex = [self getMinimumIvarIndex:class];
    NSIndexSet *parsedLayout = [self getLayoutAsIndexesForDescription:minimumIndex layoutDescription:ivarReferenceTypePrt];
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(BIvarModel *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [parsedLayout containsIndex:evaluatedObject.index];
    }];
    
    NSArray<BIvarModel *> *fiterModels = [ivars filteredArrayUsingPredicate:predicate];
    
    return fiterModels;
}

- (NSUInteger)getMinimumIvarIndex:(__unsafe_unretained Class)aCls
{
    NSUInteger minimumIndex = 1;
    unsigned int count;
    Ivar *ivars = class_copyIvarList(aCls, &count);

    if (count > 0) {
        Ivar ivar = ivars[0];
        ptrdiff_t offset = ivar_getOffset(ivar);
        minimumIndex = offset / (sizeof(void *));
    }

    free(ivars);

    return minimumIndex;
}

- (NSIndexSet *)getLayoutAsIndexesForDescription:(NSUInteger)minimumIndex layoutDescription:(const uint8_t *)layoutDescription
{
    //layoutDescription 为class_getIvarLayout([self class]);
    NSMutableIndexSet *interestingIndexes = [NSMutableIndexSet new];
    NSUInteger currentIndex = minimumIndex;

    while (*layoutDescription != '\x00') {
        int upperNibble = (*layoutDescription & 0xf0) >> 4;
        int lowerNibble = *layoutDescription & 0xf;

        currentIndex += upperNibble;
        [interestingIndexes addIndexesInRange:NSMakeRange(currentIndex, lowerNibble)];
        currentIndex += lowerNibble;

        ++layoutDescription;
    }

    return interestingIndexes;
}

#pragma mark - getter

@end
