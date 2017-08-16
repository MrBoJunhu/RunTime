//
//  Person.h
//  testOC
//
//  Created by BillBo on 2017/8/16.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    
    NSString *address;
    
}

@property (nonatomic, copy) NSString *personName;

@property (nonatomic, assign) BOOL isGirl;

@property (nonatomic, assign) NSUInteger personAge;

@property (nonatomic, strong) NSDictionary * familyDic;

@end
