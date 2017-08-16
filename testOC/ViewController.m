//
//  ViewController.m
//  testOC
//
//  Created by BillBo on 2017/8/15.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "ViewController.h"
#import "MyClass.h"

#import "SubMyClass.h"

#import "MyClass+Category.h"

#import <objc/runtime.h>

#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - 替换方法不带参数

- (IBAction)test1:(id)sender {
    
    SubMyClass *subCla = [[SubMyClass alloc] init];
    
    [subCla showUserName];
    
}

#pragma mark - 替换方法带参数有返回值

- (IBAction)test2:(id)sender {
    
    SubMyClass *cla = [[SubMyClass alloc] init];
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    
    NSString *inputString = [formatter stringFromDate:date];
    
    NSLog(@"%@", [cla showYourInputString:inputString]);
    
}
#pragma mark - 在viewController里面声明方法及实现,并且替换class的方法

- (IBAction)test3:(id)sender {
    
    [self testReplace];
    
    SubMyClass *cla = [[SubMyClass alloc] init];
    
    [cla showTime];
    
}


- (void)testReplace {
    
    Class myClas = NSClassFromString(@"MyClass");
    
    SEL oriSEL = @selector(showTime);
    SEL newSEL = @selector(replaceMethod);
    Method oriMethod = class_getInstanceMethod(myClas, oriSEL);
    Method newMethod = class_getInstanceMethod(myClas, newSEL);
    
    //获取参数
    char *typeDescription = (char *) method_getTypeEncoding(oriMethod);
    
    IMP replaceIMP = class_getMethodImplementation([self class], newSEL);
    
    //给 MyClass 新增方法,并指向 replaceMethod 的实现
    BOOL addSuccess =  class_addMethod(myClas, newSEL, replaceIMP, typeDescription);
 
    if (addSuccess) {
        
        //方法添加成功后, 替换原有的方法的实现
        class_replaceMethod(myClas, oriSEL, replaceIMP, typeDescription);
   
    }else{
        
        method_exchangeImplementations(oriMethod, newMethod);
        
    }
    
}




- (IBAction)nextPage:(id)sender {
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    
    [self.navigationController pushViewController:secondVC animated:YES];
    
}

- (NSString *)replaceMethod {
    
    return @"换种姿态呀! ";
    
}

@end
