//
//  MyTableViewCell.m
//  一点抓包
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "MyTableViewCell.h"



@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//解决cell宽度适配的问题
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame.size.width = WIDTH;
    self.frame = frame;
}















@end
