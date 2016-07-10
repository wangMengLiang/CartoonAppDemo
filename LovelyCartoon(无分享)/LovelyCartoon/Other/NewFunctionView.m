//
//  NewFunctionView.m
//  JokeText
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "NewFunctionView.h"
#import "UIImageView+WebCache.h"
@interface NewFunctionView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, strong) Finish finish;

@property (nonatomic) BOOL isNetImage;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation NewFunctionView

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray*)imageArr isNetImage:(BOOL)isNetImage finish:(Finish)finish{
    if (self = [super init]) {
        self.frame = frame;
        self.imageArr = imageArr;
        self.finish = finish;
        self.isNetImage = isNetImage;
        [self createScrollViewAndBtn];
        [self createPageControl];
    }
    return self;
}


- (void)createScrollViewAndBtn{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * self.imageArr.count, self.frame.size.height);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    for (int i = 0; i < self.imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        if (_isNetImage) {
            //进行网络下载
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArr[i]] placeholderImage:[UIImage imageNamed:@"placeholder1"]];
        }else{
            imageView.image = [UIImage imageNamed:_imageArr[i]];
        }
        [_scrollView addSubview:imageView];
        
        if (i == _imageArr.count - 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.layer.cornerRadius = 25 * GlobalScale;
            btn.clipsToBounds = YES;
            btn.frame = CGRectMake((self.frame.size.width - 190 * GlobalScale)/2 , self.frame.size.height - 140 * GlobalScale, 190 * GlobalScale, 50 * GlobalScale);
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:20 * GlobalScale];
            btn.alpha = 0.8;
            [btn setTitle:@"立即去麦萌吧" forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:btn];
            imageView.userInteractionEnabled = YES;
        }
    }
    
    [self addSubview:_scrollView];
}


- (void)btnClick:(UIButton*)btn{

    self.finish();

}

#pragma mark - 创建pageControl
- (void)createPageControl{
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width - 200)/2, self.frame.size.height - 70, 200, 20)];
    _pageControl.numberOfPages = _imageArr.count;
    
    _pageControl.currentPage = 0;
    
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}


- (void)pageChanged:(UIPageControl*)pc{
    CGPoint offset = _scrollView.contentOffset;
    offset.x = pc.currentPage * self.frame.size.width;
    [_scrollView setContentOffset:offset animated:YES];
}



#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_scrollView == scrollView) {
        int page = scrollView.contentOffset.x / self.frame.size.width;
        _pageControl.currentPage = page;
    }
}








@end
