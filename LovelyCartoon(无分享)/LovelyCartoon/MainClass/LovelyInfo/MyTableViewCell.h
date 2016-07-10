//
//  MyTableViewCell.h
//  一点抓包
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@property (weak, nonatomic) IBOutlet UILabel *name;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewWidthConstraints;


@end
