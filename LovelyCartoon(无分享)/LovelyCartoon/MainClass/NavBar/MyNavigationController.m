//
//  MyNavigationController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 43, WIDTH, 1.5)];
    view.backgroundColor = MainColor;
    [self.navigationBar addSubview:view];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
