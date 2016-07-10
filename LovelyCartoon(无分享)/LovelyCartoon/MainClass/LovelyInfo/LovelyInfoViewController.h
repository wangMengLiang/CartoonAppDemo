//
//  LovelyInfoViewController.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "WMBasePullTableViewController.h"

@interface LovelyInfoViewController : WMBasePullTableViewController

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

//记录第一个cell
@property (nonatomic, strong) UITableViewCell *firstCell;


- (void)loadScrollViewData;

- (void)loadDataSourceWithUrl:(NSString*)url;

- (NSString*)myScrollViewAPI;

- (void)pageChanged:(UIPageControl*)pc;

- (void)onTimer:(NSTimer*)timer;


@end
