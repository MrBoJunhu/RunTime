//
//  MyClass+Category.m
//  testOC
//
//  Created by BillBo on 2017/8/15.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "MyClass+Category.h"
#import <objc/runtime.h>
@implementation MyClass (Category)

+ (void)load{
    
    static dispatch_once_t onceToken;
   
    dispatch_once(&onceToken, ^{
        
        Method originalMethod = class_getInstanceMethod([MyClass class], @selector(showUserName));
        
        SEL replaceSEL = @selector(showOtherUsername);
        SEL originalSEL = @selector(showUserName);
        IMP replaceIMP = class_getMethodImplementation([MyClass class], replaceSEL);
        
        class_replaceMethod([MyClass class], originalSEL, replaceIMP, method_getTypeEncoding(originalMethod));
        
        
        //携带参数方法的替换
        Class class = [MyClass class];
        SEL oldSEL = @selector(showYourInputString:);
        SEL newSEL = @selector(newShowYourInputString:);
        exchangeMethod(class, oldSEL, newSEL);
        
    });

}

- (void)showOtherUsername {
    
    NSLog(@"替换的方法");
    
}


- (void)newMethodTest:(NSString *)inputTestString {
 
    NSLog(@"扩展的方法:%@", inputTestString);
    
}


#pragma mark - 封装对Class的方法的替换

void exchangeMethod(Class class, SEL  originalSEL ,SEL exchangeSEL ){
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    
    Method exchangeMethod = class_getInstanceMethod(class, exchangeSEL);
    
    char *typeDescription =  (char *)method_getTypeEncoding(originalMethod);
    
    IMP  exchangeIMP = class_getMethodImplementation(class, exchangeSEL);
    
    IMP originalIMP = class_getMethodImplementation(class, originalSEL);
    
    BOOL addMethodSuccess = class_addMethod(class, exchangeSEL, exchangeIMP, typeDescription);
    
    if (addMethodSuccess) {
        
        //添加成功后替换
        class_replaceMethod(class, exchangeSEL, originalIMP, typeDescription);
        
    }else{
        
        // 添加失败，表明已经有这个方法，直接交换
        method_exchangeImplementations(originalMethod, exchangeMethod);
    }
    
}

#pragma mark - 替换方法携带参数

- (NSString *)newShowYourInputString:(NSString *)input {

    return [NSString stringWithFormat:@"您当前输入的是: %@", input];
    
}



@end
