//
//  CategoryCollectionViewCell.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame.size.width = 110 * GlobalScale;
    frame.size.height = 130 * GlobalScale;
    self.frame = frame;


}


@end
