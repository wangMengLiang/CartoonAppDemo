//
//  MoreCartoonCollectionViewCell.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "MoreCartoonCollectionViewCell.h"

@implementation MoreCartoonCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.cellImageView.layer.cornerRadius = 5 * GlobalScale;
    self.cellImageView.clipsToBounds = YES;
    self.updataLabel.font = [UIFont systemFontOfSize:15 * GlobalScale];
    self.nameLabel.font = [UIFont systemFontOfSize:14 * GlobalScale];



}



@end
