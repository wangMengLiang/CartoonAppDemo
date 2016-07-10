//
//  CommentTableViewCell.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "UseridinfoModel.h"
#import "UserModel.h"
@interface CommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *replayBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configViewWithData:(CommentlistModel*)dataModel{
    _replayBtn.titleLabel.font = [UIFont systemFontOfSize:15 * GlobalScale];
    _headImage.layer.cornerRadius = 25;
    _headImage.clipsToBounds = YES;
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:dataModel.userIDInfo.images] placeholderImage:nil];
    
    _userNameLabel.text = dataModel.userIDInfo.name;
    
    _commentLabel.text = dataModel.content;
    
    _timeLabel.text = dataModel.createTimeValue;
    
}


- (IBAction)replyBtnClick:(id)sender {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)layoutSubviews{
    [super layoutSubviews];
    self.userNameLabel.font = [UIFont systemFontOfSize:14 * GlobalScale];
    self.timeLabel.font = [UIFont systemFontOfSize:15 * GlobalScale];
    self.commentLabel.font = [UIFont systemFontOfSize:17 * GlobalScale];
    
    
}












@end
