//
//  MyClass.m
//  testOC
//
//  Created by BillBo on 2017/8/15.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "MyClass.h"

@implementation MyClass

- (instancetype)init{
    
    if (self = [super init]) {
        
        
    }
    
    return self;
    
}


- (NSString *)showTime {
    
    return  @"显示时间呢";
    
}

- (void)showUserName {
    
    NSLog(@"旧方法");
    
}


- (NSString *)showYourInputString:(NSString *)inputStr{
    
    return [NSString stringWithFormat:@"%@", inputStr];
    
}

@end
