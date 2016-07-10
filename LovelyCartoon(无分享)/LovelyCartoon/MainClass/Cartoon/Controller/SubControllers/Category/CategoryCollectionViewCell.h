//
//  CategoryCollectionViewCell.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@end
