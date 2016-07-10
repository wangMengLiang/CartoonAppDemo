//
//  WMBaseViewController.h
//  JokeText
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMBaseViewController : UIViewController

//显示菊花转，提示
- (void)showTipText:(NSString*)text;
//显示错误  菊花转
- (void)showErrorText:(NSString*)text;
- (void)showNetError;
//显示加载   菊花转
- (void)showLoading;
//加载完毕，隐藏菊花转
- (void)hideLoading;




- (void)setNavigationBarwithLeftImage:(NSString*)leftImage rightImage:(NSString*)rightImage;

- (void)leftItemClick:(UIBarButtonItem*)item;

- (void)rightItemClick:(UIBarButtonItem*)item;

@end
