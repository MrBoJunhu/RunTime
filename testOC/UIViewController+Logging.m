

//
//  UIViewController+Logging.m
//  testOC
//
//  Created by BillBo on 2017/8/16.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "UIViewController+Logging.h"
#import <objc/runtime.h>
@implementation UIViewController (Logging)

+ (void)load{
   
    //方法替换植入的位置
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class clas = [self class];
        
        SEL originalSEL = @selector(viewWillAppear:);
        
        SEL newSEL = @selector(swizzled_viewWillAppear:);
        
        swizzledMethod(clas, originalSEL, newSEL);
        
    });
    
}

void swizzledMethod(Class class, SEL originalSEL, SEL swizzledSEL){
        
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    IMP swizzledIMP = class_getMethodImplementation(class, swizzledSEL);
    
    //获取原方法里面的参数,包括返回值
    char *swizzledTypes =  (char *)method_getTypeEncoding(originalMethod);
    
    BOOL swizzledSuccess = class_addMethod(class, swizzledSEL, swizzledIMP, swizzledTypes);
    
    if (swizzledSuccess) {
        
        //添加成功,替换方法的调用接口
        class_replaceMethod(class, originalSEL, swizzledIMP, swizzledTypes);
        
    }else{
        
        //添加失败,替换方法的实现
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    }
    
}


- (void)swizzled_viewWillAppear:(BOOL)animated {
    
    if ([[self class] isKindOfClass:[UINavigationController class]] || [[self class] isSubclassOfClass:[UINavigationController class]] || [[self class] isKindOfClass:[UITabBarController class]] || [[self class] isSubclassOfClass:[UITabBarController class]] ) {
        return;
    }
 
    NSLog(@"🍎当前类是 : %@ , animated :%d", NSStringFromClass([self class]) ,animated);
    
}


@end
