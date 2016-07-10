//
//  ImageCollectionViewCell.m
//  ZZ15221010WangMengLiang
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        
        [self.contentView addSubview:_imageView];
        
    }
    return self;
}







//重写该方法，重新布局子视图
- (void)layoutSubviews{
    [super layoutSubviews];
    //重新修改label的大小
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
