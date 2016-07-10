//
//  WMBaseTableViewController.h
//  JokeText
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "WMBaseViewController.h"

@interface WMBaseTableViewController : WMBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

- (void)loadDataSource;


@end
