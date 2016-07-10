//
//  TopViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "TopViewController.h"
#import "RecommendMoreController.h"
@interface TopViewController ()

@property (nonatomic, strong) NSMutableArray *urlArr;
@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49)];
    
    [self.view addSubview:_scrollView];
    CGFloat iWidth = WIDTH;
    CGFloat iHeight = 660 * GlobalScale;
    CGFloat iHeight2 = 220 * GlobalScale;
    
    //    CGFloat iHeight = iWidth * (1510 / 1072);
    //    CGFloat iHeight2 = iWidth * ( 485 / 1072);
    
    UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iWidth, iHeight)];
    view1.image = [UIImage imageNamed:@"image1"];
    [_scrollView addSubview:view1];
    
    UIImageView *view2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame) + 5, iWidth, iHeight2)];
    view2.image = [UIImage imageNamed:@"image2"];
    [_scrollView addSubview:view2];
    
    UIImageView *view3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view2.frame) + 5, iWidth, iHeight)];
    view3.image = [UIImage imageNamed:@"image3"];
    [_scrollView addSubview:view3];
    
    _scrollView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(view3.frame));
    view1.userInteractionEnabled = YES;
    view2.userInteractionEnabled = YES;
    view3.userInteractionEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    
    
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, iHeight2 * i, iWidth, iHeight2);
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [_scrollView addSubview:btn];
    }
}


-(NSMutableArray *)urlArr{
    if (_urlArr == nil) {
        _urlArr = [NSMutableArray new];
        NSArray *arr = @[@"11", @"1", @"14", @"3", @"4", @"12", @"13"];
        for (int i = 0; i < arr.count; i++) {
            NSString *url = [NSString stringWithFormat:APPCartoonBillBoardAPI, arr[i]];
            [_urlArr addObject:url];
        }
    }
    
    return _urlArr;
}

- (NSArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr = @[@"超强人气榜", @"每周点击榜", @"疯狂动物城", @"最强推荐榜", @"每周收藏榜", @"催更不停榜", @"春天的恋爱"];
    }
    return _titleArr;

}



- (void)btnClick:(UIButton*)btn{
    RecommendMoreController *moreVC = [[RecommendMoreController alloc] init];
    
    moreVC.url = self.urlArr[btn.tag];

    moreVC.title = self.titleArr[btn.tag];
    [self.navigationController pushViewController:moreVC animated:YES];

}




@end
