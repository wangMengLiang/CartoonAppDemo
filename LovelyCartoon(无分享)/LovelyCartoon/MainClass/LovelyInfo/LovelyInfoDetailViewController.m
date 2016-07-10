//
//  LovelyInfoDetailViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "LovelyInfoDetailViewController.h"
#import "ContentModel.h"
#import "TalkBar.h"

@interface LovelyInfoDetailViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LovelyInfoDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = 900;
    self.tabBarController.tabBar.frame = frame;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = HEIGHT - 49;
    self.tabBarController.tabBar.frame = frame;

}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showLoading];
    self.navigationController.navigationBar.hidden = NO;

    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataSource = [NSMutableArray new];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -69, WIDTH, HEIGHT + 10)];
    
    [self.view addSubview:_webView];
    
    [self getHttpRequest];
    [self addBarItem];
}

- (void)addBarItem{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"shareIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

//分享点击事件
- (void)rightItemClick:(UIBarButtonItem*)rightItem{
    [self showTipText:@"该功能暂未开放,敬请期待!"];

}



- (void)getHttpRequest{
    
    [[WMHTTPEngine shareManager] GET:self.urlStr params:nil success:^(id responseObject) {

        NSDictionary *results = responseObject[@"results"];
        
        ContentModel *model = [[ContentModel alloc] initWithDictionary:results error:nil];
        if (model == nil) {
            return ;
        }
        [_dataSource addObject:model];
        
        NSURL *url = [NSURL URLWithString:model.shareUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        
        self.title = model.title;
        [self hideLoading];
    } failure:^(NSError *error) {
        [self showNetError];
    }];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
