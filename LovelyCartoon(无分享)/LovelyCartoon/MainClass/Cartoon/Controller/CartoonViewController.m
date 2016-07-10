//
//  CartoonViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "CartoonViewController.h"
#import "SCNavTabBarController.h"
@interface CartoonViewController ()

@end

@implementation CartoonViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configNavigationBar];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)configNavigationBar{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    RecommendViewController *oneViewController = [[RecommendViewController alloc] init];
    oneViewController.title = @" 推 荐 ";
    
    
    SearchViewController *twoViewController = [[SearchViewController alloc] init];
    twoViewController.title = @"  搜 索 ";
    
    
    TopViewController *threeViewController = [[TopViewController alloc] init];
    threeViewController.title = @"  榜 单 ";
    
    
    CategoryViewController *fourViewController = [[CategoryViewController alloc] init];
    fourViewController.title = @"  分 类 ";
    
    BookshelfViewController *fiveViewController = [[BookshelfViewController alloc] init];
    fiveViewController.title = @"  书 架 ";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    
    navTabBarController.subViewControllers = @[oneViewController, twoViewController, threeViewController, fourViewController, fiveViewController];
    
    navTabBarController.navTabBarColor = [UIColor whiteColor];
    navTabBarController.navTabBarLineColor = MainColor;
    
    [navTabBarController addParentController:self];



}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
