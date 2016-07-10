//
//  RecommendTableViewCell.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellItemModel.h"

@interface RecommendTableViewCell : UITableViewCell

@property (nonatomic, strong) UIViewController *controller;

- (void)configViewWithDate:(CellItemModel*)dataModel;

@end
