//
//  RegisterViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (nonatomic, strong) UITextField *tf1;

@property (nonatomic, strong) UITextField *tf2;

@property (nonatomic, strong) UITextField *tf3;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self createView];
}

- (void)createView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT - 20)];
    imageView.image = [[UIImage imageNamed:@"register"] stretchableImageWithLeftCapWidth:0 topCapHeight:10];
    
    [self.view addSubview:imageView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20 * GlobalScale * GlobalHeightScale, 70 * GlobalScale, 50 * GlobalScale * GlobalHeightScale);
    
    backBtn.backgroundColor = [UIColor clearColor];
    backBtn.layer.cornerRadius = 5 * GlobalScale;
    backBtn.clipsToBounds = YES;
    backBtn.tag = 10;
    [backBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    

    
    _tf1 = [[UITextField alloc] initWithFrame:CGRectMake(80 * GlobalScale, 110 * GlobalScale * GlobalHeightScale, 290 * GlobalScale, 40 * GlobalScale * GlobalHeightScale)];
    _tf1.backgroundColor = [UIColor whiteColor];
    _tf1.placeholder = @"请输入注册手机号";
    _tf1.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_tf1];
    
    
    
    _tf2 = [[UITextField alloc] initWithFrame:CGRectMake(30 * GlobalScale, 170 * GlobalScale * GlobalHeightScale, 250 * GlobalScale, 40 * GlobalScale * GlobalHeightScale)];
    _tf2.backgroundColor = [UIColor whiteColor];
    _tf2.placeholder = @"手机验证码";
    _tf2.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_tf2];
    
    UIButton *testNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testNumBtn.frame = CGRectMake(WIDTH - 90 * GlobalScale - 22 * GlobalScale, 172 * GlobalScale * GlobalHeightScale, 90 * GlobalScale, 35 * GlobalScale * GlobalHeightScale);
    testNumBtn.backgroundColor = [UIColor clearColor];
    testNumBtn.tag = 20;
    [testNumBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testNumBtn];
    
    
    _tf3 = [[UITextField alloc] initWithFrame:CGRectMake(30 * GlobalScale, 235 * GlobalScale * GlobalHeightScale, 350 * GlobalScale, 40 * GlobalScale * GlobalHeightScale)];
    _tf3.backgroundColor = [UIColor whiteColor];
    _tf3.placeholder = @"密码";
    _tf3.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_tf3];
    
    _tf1.font = [UIFont systemFontOfSize:18 * GlobalScale];
    
    _tf2.font = [UIFont systemFontOfSize:18 * GlobalScale];
    
    _tf3.font = [UIFont systemFontOfSize:18 * GlobalScale];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(22 * GlobalScale, 337 * GlobalScale * GlobalHeightScale, 370 * GlobalScale, 50 * GlobalScale * GlobalHeightScale);
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.tag = 30;
    [registerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    //状态栏
    UIView *stateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 28 * GlobalHeightScale)];
    
    stateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:stateView];
    
}



- (void)btnClick:(UIButton*)btn{
    switch (btn.tag) {
        case 10:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 20:
            [self showTipText:@"该功能还未开放,敬请期待!"];

            break;
        case 30:{
            [self showTipText:@"该功能还未开放,敬请期待!"];

            break;
        }
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
