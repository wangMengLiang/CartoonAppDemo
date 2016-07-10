//
//  CommentTableViewCell.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentlistModel.h"

@interface CommentTableViewCell : UITableViewCell


- (void)configViewWithData:(CommentlistModel*)dataModel;

@end
