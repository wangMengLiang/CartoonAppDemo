//
//  MainTabBarViewController.m
//  JokeText
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MyNavigationController.h"
#import "TabBarModel.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadConfigFile];
    [self creataTabBarViewControllers];
    
    //设置导航栏的 标题的字体
    NSDictionary *att = @{NSForegroundColorAttributeName:MainColor, NSFontAttributeName:[UIFont systemFontOfSize:20 * GlobalScale]};
    [[UINavigationBar appearance] setTitleTextAttributes:att];
    
    self.tabBar.translucent = NO;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12 * GlobalScale]} forState:UIControlStateNormal];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    view.backgroundColor = MainColor;
    [self.tabBar addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creataTabBarViewControllers {
    NSArray *tabBarModelArray = [self loadConfigFile];
    //创建子视图控制器
    for (TabBarModel *item in tabBarModelArray) {
        UIViewController *vc = [[NSClassFromString(item.className) alloc]init];
        vc.title = item.title;
        vc.tabBarController.tabBar.tintColor = MainColor;
        vc.tabBarItem.title = item.title;
        vc.tabBarItem.image = [[UIImage imageNamed:item.image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_press",item.image]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MainColor} forState:UIControlStateSelected];
        MyNavigationController *nav = [[MyNavigationController alloc]initWithRootViewController:vc];

        nav.navigationBar.tintColor = MainColor;
        [self addChildViewController:nav];
    }
}

/**
 *  记载配置文件
 */
- (NSMutableArray*)loadConfigFile {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Tabbar.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *resultArray = [TabBarModel arrayOfModelsFromDictionaries:array];
    return resultArray;
    
}



@end
