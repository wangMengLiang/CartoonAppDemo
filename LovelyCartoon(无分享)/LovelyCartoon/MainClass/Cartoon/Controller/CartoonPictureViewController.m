//
//  CartoonPictureViewController.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "CartoonPictureViewController.h"
#import "CartoonPictureModel.h"
#import "PictureParamsModel.h"
#import "PictureParamsModel.h"
#import "ESRootClass.h"
@interface CartoonPictureViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *imageArr;

@property (nonatomic, strong) ESRootClass *dataModel;
@end

@implementation CartoonPictureViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    _imageArr = [NSMutableArray new];
    [self loadData];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = 800;
    self.tabBarController.tabBar.frame = frame;

}


- (void)loadData{

    [[WMHTTPEngine shareManager] GET:self.urlStr params:nil success:^(id responseObject) {
        _dataModel = [[ESRootClass alloc] initWithDictionary:responseObject error:nil];
        
        NSArray *resArr = [CartoonPictureModel arrayOfModelsFromDictionaries:_dataModel.results];
        
        
        [resArr enumerateObjectsUsingBlock:^(CartoonPictureModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat iWidth = WIDTH;
            CGFloat iHeight = [obj.imgHeight doubleValue] / [obj.imgWidth doubleValue] * iWidth;
            UIImageView *imageView = [[UIImageView alloc] init];
            if (idx == 0) {
                imageView.frame = CGRectMake(0, 0, iWidth, iHeight);
            }else{
                UIImageView *view = [_imageArr lastObject];
                imageView.frame = CGRectMake(0, CGRectGetMaxY(view.frame), iWidth, iHeight);
            }
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj.images] placeholderImage:[UIImage imageNamed:@"placeholder1"]];
            [_imageArr addObject:imageView];
            
            [self createScrollView];
        }];
        
    } failure:^(NSError *error) {
        [self showNetError];
    }];


}

- (void)createScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _scrollView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY([[_imageArr lastObject] frame]));
    _scrollView.delegate = self;
    for (UIImageView *imageView in _imageArr) {
        [_scrollView addSubview:imageView];
    }
    
    [self.view addSubview:_scrollView];


}

-(void)viewWillDisappear:(BOOL)animated{

//    self.tabBarController.tabBar.hidden = ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
