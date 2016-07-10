//
//  WMBaseViewController.m
//  JokeText
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "WMBaseViewController.h"
#import "MBProgressHUD+Add.h"
@interface WMBaseViewController ()

@end

@implementation WMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self showLoading];

}

- (void)showTipText:(NSString*)text {
    // MBProgressHUD的使用方法
    [MBProgressHUD show:text icon:nil view:self.view];
}

- (void)showErrorText:(NSString*)text {
    
    [MBProgressHUD showError:text toView:self.view];
}

- (void)showLoading{
    [MBProgressHUD showMessag:@"正在加载..." toView:self.view];
    
}

//当网页加载完毕后，隐藏加载指示器
- (void)hideLoading{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)showNetError{
    
    [MBProgressHUD showError:@"网络请求失败，请检查网络" toView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationBarwithLeftImage:(NSString*)leftImage rightImage:(NSString*)rightImage{
    //设置左侧item
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:leftImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //设置右侧item  在消息页需要判断，给右侧item设置一个标题
    UIBarButtonItem *rightItem;
    if ([NSStringFromClass(self.class) isEqualToString:@"MessageViewController"]) {
        rightItem = [[UIBarButtonItem alloc] initWithTitle:@"黑名单" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    }else{
        rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:rightImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    }
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


- (void)leftItemClick:(UIBarButtonItem*)item{
    
}


- (void)rightItemClick:(UIBarButtonItem*)item{
    
}




@end
