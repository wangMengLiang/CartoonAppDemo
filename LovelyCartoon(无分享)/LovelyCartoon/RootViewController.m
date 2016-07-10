//
//  RootViewController.m
//  JokeText
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "Helpper.h"
#import "NewFunctionView.h"
@interface RootViewController ()
//伪装成启动图
@property (nonatomic, strong) UIImageView *lanuchImage;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([Helpper isFirstOpen]) {
        //加载app功能界面
        NSLog(@"加载应用功能");
        NSArray *imageArr = @[@"start1", @"start2", @"start3", @"start4"];
        NewFunctionView *view = [[NewFunctionView alloc] initWithFrame:self.view.frame imageArr:imageArr isNetImage:NO finish:^{
            [self gotoMain];
        }];
        [self.view addSubview:view];
        
    }else{
    //  加载广告
        NSLog(@"加载广告");
        [self loadADView];
    }
    

    
}



//加载广告界面
- (void)loadADView{
    //伪装启动图
    _lanuchImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    _lanuchImage.image = [UIImage imageNamed:@"LaunchImage"];
    [self.view addSubview:_lanuchImage];
    
    //跳过的按钮
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpBtn setTitle:@"跳过>>" forState:UIControlStateNormal];
    jumpBtn.frame = CGRectMake(WIDTH - 50 * GlobalScale - 80 * GlobalScale, 40 * GlobalScale, 70 * GlobalScale, 25 * GlobalScale);

    [jumpBtn addTarget:self action:@selector(jumpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn];
    
    //倒计时的label  晚上的作业
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 50 * GlobalScale, 40 * GlobalScale, 100 * GlobalScale, 25 * GlobalScale)];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:label repeats:YES];
    _timer.fireDate = [NSDate distantPast];
    
    jumpBtn.titleLabel.font = [UIFont systemFontOfSize:18 * GlobalScale];
    label.font = [UIFont systemFontOfSize:18 * GlobalScale];
    
}

- (void)onTimer:(NSTimer*)timer{
    static int time = 4;
    time--;
    UILabel *label = timer.userInfo;
    label.text = [NSString stringWithFormat:@"%d 秒", time];
    if (time == 0) {
        _timer.fireDate = [NSDate distantFuture];
        [self gotoMain];
    }
}


- (void)jumpBtnClick:(UIButton*)btn{
    _timer.fireDate = [NSDate distantFuture];
    [self gotoMain];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoMain{
    
    MainTabBarViewController *mainVC = [[MainTabBarViewController alloc] init];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = mainVC;

}









@end
