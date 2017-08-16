//
//  BasicModel.m
//  testOC
//
//  Created by BillBo on 2017/8/16.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "BasicModel.h"
#import <objc/runtime.h>
@implementation BasicModel
/*
 
 有时候我们要对一些信息进行归档，如用户信息类UserInfo，这将需要重写initWithCoder和encodeWithCoder方法，并对每个属性进行encode和decode操作。那么问题来了：当属性只有几个的时候可以轻松写完，如果有几十个属性呢？那不得写到天荒地老？。。。
 
 原理描述：用runtime提供的函数遍历Model自身所有属性，并对属性进行encode和decode操作。
 核心方法：在Model的基类中重写方法：
 
 */
- (id)initWithCode:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        unsigned int outCount = 0 ;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        
        for (int i = 0 ; i < outCount; i ++) {
            
            Ivar ivar = ivars[i];
            
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
            
        }
    }
    
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int outCount = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    
    for (int i =0; i < outCount; i ++) {
        
        Ivar ivar = ivars[i];
        
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
        
    }
    
}

@end
