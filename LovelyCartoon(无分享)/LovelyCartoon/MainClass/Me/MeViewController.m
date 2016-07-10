//
//  MeViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "MeViewController.h"

#import "LoginViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    [self createView];
}

- (void)createView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 40)];
    imageView.image = [UIImage imageNamed:@"fourImage"];
    [self.view addSubview:imageView];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    MyLog(@"%f", GlobalHeightScale);

    loginBtn.frame = CGRectMake(137 * GlobalScale, 243 * GlobalScale * GlobalHeightScale, 140 * GlobalScale, 39 * GlobalScale * GlobalHeightScale);
    loginBtn.backgroundColor = [UIColor clearColor];
    loginBtn.layer.cornerRadius = 5 * GlobalScale;
    loginBtn.clipsToBounds = YES;
    loginBtn.tag = 10;
    [loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [self addSettingBtn];
    
}
- (void)addSettingBtn{
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(0,280 * GlobalScale * GlobalHeightScale,WIDTH,HEIGHT - 400 * GlobalScale * GlobalHeightScale);
    setBtn.backgroundColor = [UIColor clearColor];
    [setBtn addTarget:self action:@selector(setBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:setBtn];
}

- (void)setBtnClick:(UIButton*)btn{
    [self showTipText:@"您还未登陆,请登陆！"];

}


- (void)btnClick:(UIButton*)btn{
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    
    [self presentViewController:loginVc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



@end
