//
//  LoginViewController.m
//  Cathbag
//
//  Created by qianfeng on 16/3/6.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()

@property (nonatomic, strong) UITextField *tf1;

@property (nonatomic, strong) UITextField *tf2;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self createView];
}

- (void)createView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT - 20)];
    imageView.userInteractionEnabled = YES;
    imageView.image = [[UIImage imageNamed:@"loginImage"] stretchableImageWithLeftCapWidth:0 topCapHeight:10];
    
    [self.view addSubview:imageView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(365 * GlobalScale, 20 * GlobalScale * GlobalHeightScale, 70 * GlobalScale, 50* GlobalScale *GlobalHeightScale);
    backBtn.backgroundColor = [UIColor clearColor];
    backBtn.layer.cornerRadius = 5;
    backBtn.clipsToBounds = YES;
    backBtn.tag = 10;
    [backBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    

    _tf1 = [[UITextField alloc] initWithFrame:CGRectMake(60 * GlobalScale, 263 * GlobalScale * GlobalHeightScale, 290 * GlobalScale, 32 * GlobalScale * GlobalHeightScale)];

    _tf1.backgroundColor = [UIColor whiteColor];
    _tf1.placeholder = @"请输入账号";
    _tf1.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_tf1];
    
    

    _tf2 = [[UITextField alloc] initWithFrame:CGRectMake(60 * GlobalScale, 310 * GlobalScale * GlobalHeightScale, 290 * GlobalScale, 32 * GlobalScale * GlobalHeightScale)];
    _tf2.backgroundColor = [UIColor whiteColor];
    _tf2.placeholder = @"请输入密码";
    _tf2.clearButtonMode = UITextFieldViewModeAlways;
    _tf2.secureTextEntry = YES;
    [self.view addSubview:_tf2];
    
    _tf1.font = [UIFont systemFontOfSize:18 * GlobalScale];
    _tf2.font = [UIFont systemFontOfSize:18 * GlobalScale];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(22 * GlobalScale, 418 * GlobalScale * GlobalHeightScale, 370 * GlobalScale, 45 * GlobalScale * GlobalHeightScale);
    startBtn.backgroundColor = [UIColor clearColor];
    startBtn.layer.cornerRadius = 10 * GlobalScale;
    startBtn.clipsToBounds = YES;
    startBtn.tag = 20;
    [startBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(22 * GlobalScale, 475 * GlobalScale * GlobalHeightScale, 370 * GlobalScale, 45 * GlobalScale * GlobalHeightScale);
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.layer.cornerRadius = 10 *GlobalScale;
    registerBtn.clipsToBounds = YES;
    registerBtn.tag = 30;
    [registerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    //状态栏
    UIView *stateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30 * GlobalHeightScale)];
    
    stateView.backgroundColor = [UIColor colorWithRed:231/255.0 green:86/255.0 blue:101/255.0 alpha:1.0];
    [self.view addSubview:stateView];
    

}

- (void)btnClick:(UIButton*)btn{
    switch (btn.tag) {
        case 10:
            
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 20:
            [self showTipText:@"登陆信息有误,请重试!"];
            break;
        case 30:{
            RegisterViewController *registerVC = [[RegisterViewController alloc] init];
            [self presentViewController:registerVC animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];

}




@end
