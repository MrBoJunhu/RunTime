//
//  SecondViewController.m
//  testOC
//
//  Created by BillBo on 2017/8/16.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "SecondViewController.h"

#import "MyClass.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
   
    MyClass *cla = [[MyClass alloc] init];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:self.view.frame];
    
    lb.text = [cla showTime];
    
    lb.textAlignment = NSTextAlignmentCenter;
    
    lb.textColor = [UIColor redColor];
    
    lb.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:lb];
    
}

@end
