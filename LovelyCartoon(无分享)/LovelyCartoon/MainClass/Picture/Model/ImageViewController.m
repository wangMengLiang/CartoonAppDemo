//
//  ImageViewController.m
//  ZZ15221010WangMengLiang
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "ImageViewController.h"

#import "UIImageView+WebCache.h"
@interface ImageViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ImageViewController

- (void)viewWillDisappear:(BOOL)animated{
    //显示tabBar
    self.navigationController.navigationBar.hidden = NO;
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = HEIGHT - 49;
    self.tabBarController.tabBar.frame = frame;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;

    //将tabBar隐藏
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = 800;
    self.tabBarController.tabBar.frame = frame;
    
    [self createScrollView];
    [self addHeadView];
//    [self addFootView];
}

- (void)createScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.pagingEnabled = YES;
    for (int i = 0; i < _modelArr.count; i++) {

        ImageModel *model = _modelArr[i];
        
        CGFloat iWidth = WIDTH;
        CGFloat iHeight = [model.height floatValue]/[model.width floatValue] * iWidth;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * WIDTH, (HEIGHT - iHeight)/2, iWidth, iHeight)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"placeholder1"]];
        
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(_modelArr.count * WIDTH, HEIGHT - 49 - 44);
    
    CGPoint offset = _scrollView.contentOffset;
    offset.x = _index * WIDTH;
    _scrollView.contentOffset = offset;
    [self.view addSubview:_scrollView];

}

    //添加图片主页的头和尾
- (void)addHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(WIDTH - 45 * GlobalScale, 20, 35 * GlobalScale, 35 * GlobalScale);
    [btn setBackgroundImage:[UIImage imageNamed:@"blackShare"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:btn];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10 * GlobalScale, 20, 35 * GlobalScale, 35 * GlobalScale);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    headView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:headView];
}

//- (void)addFootView{
//    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HEIGHT - 49, WIDTH, 49)];
//    footView.image = [UIImage imageNamed:@"imageBar"];
//    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/2 - 100 * GlobalScale, 0, 200 * GlobalScale, 49)];
//    blackView.backgroundColor = [UIColor blackColor];
//    [footView addSubview:blackView];
//    [self.view addSubview:footView];
//
//}


- (void)shareBtnClick:(UIButton*)btn{
    [self showTipText:@"该功能暂未开放,敬请期待!"];

}


- (void)backBtnClick:(UIButton*)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
