//
//  RecommendTableViewCell.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "RecommendTableViewCell.h"
#import "RecommendMoreController.h"
#import "CellItemModel.h"
#import "CartoonDetailViewController.h"
@interface RecommendTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *itemView;

@property (nonatomic, strong) CellItemModel *dataModel;

@property (nonatomic, strong) RecommendMoreController *recommendMoreVC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemViewConstraintsHeight;

@end

@implementation RecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)configViewWithDate:(CellItemModel*)dataModel{
    self.dataModel = dataModel;
    _titleLabel.text = dataModel.title;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18 * GlobalScale];
    CGFloat itemWidth = (WIDTH - 40)/3;
    CGFloat itemHieght = itemWidth * 360 / 270;
    
    
    _itemViewConstraintsHeight.constant = itemHieght;
    
    for (int i = 0; i < dataModel.cartoonSetList.count; i++) {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(0, 0, itemWidth, itemHieght);
        [btn addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (itemWidth + 10) * i, 0, itemWidth, itemHieght)];
        imageView.layer.cornerRadius = 5;
        imageView.clipsToBounds = YES;
        
        CellImageModel *imageModel = dataModel.cartoonSetList[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.images] placeholderImage:[UIImage imageNamed:@"placeholder2"]];
        
        imageView.userInteractionEnabled = YES;

        [self.itemView addSubview:imageView];
    
        UILabel *updataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, itemHieght - 15, itemWidth, 15)];
        updataLabel.text = imageModel.updateInfo;
        updataLabel.backgroundColor = [UIColor lightGrayColor];
        updataLabel.alpha = 0.8;
        [imageView addSubview:updataLabel];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + (itemWidth + 10) * i, CGRectGetMaxY(imageView.frame) + 5, itemWidth, 10)];
        nameLabel.text = imageModel.name;
        
        [self.itemView addSubview:nameLabel];
        
        updataLabel.font = [UIFont boldSystemFontOfSize:15 * GlobalScale];
        nameLabel.font = [UIFont boldSystemFontOfSize:15 * GlobalScale];
        updataLabel.textColor = [UIColor whiteColor];
        updataLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        
        [imageView addSubview:btn];
        
    }
}

-(RecommendMoreController *)recommendMoreVC{
    if (_recommendMoreVC == nil) {
        _recommendMoreVC = [[RecommendMoreController alloc] init];
    }
    return _recommendMoreVC;

}


- (IBAction)btnClick:(id)sender {
//    RecommendMoreController *moreVC = [[RecommendMoreController alloc] init];
    self.recommendMoreVC.valueID = self.dataModel.valueID;
    self.recommendMoreVC.title = self.dataModel.title;
    
    [self.controller.navigationController pushViewController:self.recommendMoreVC animated:YES];
    
}


- (void)imageClick:(UIButton*)btn{
    CartoonDetailViewController *cartoonDetailVC = [[CartoonDetailViewController alloc] init];
    CellImageModel *model = self.dataModel.cartoonSetList[btn.tag];
    
    
    cartoonDetailVC.cartoonID = model.id;
    cartoonDetailVC.images = model.images;
    
    
    [self.controller.navigationController pushViewController:cartoonDetailVC animated:YES];
    
    
    
}

//解决屏幕的适配问题
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame.size.width = WIDTH;
    self.frame = frame;


}




@end
