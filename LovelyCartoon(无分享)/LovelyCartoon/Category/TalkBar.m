//
//  TalkBar.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "TalkBar.h"

@interface TalkBar (){

    
    //输入待发送文字的文本框
    UITextField *_msgTF;
    //发送按钮
    UIButton *_sendBtn;

    //获取到的键盘的高度
    CGFloat keyHeight;

}

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TalkBar



-(UIView*)setTalkBarWithFrame:(CGRect)frame{
    self.frame = frame;
    
    
    _imageView = [[UIImageView alloc] initWithFrame:self.frame];
    
    _imageView.image = [UIImage imageNamed:@"talkBarImage"];
    
    _imageView.userInteractionEnabled = YES;
    
    _msgTF = [[UITextField alloc] initWithFrame:CGRectMake(60 * GlobalScale, 10, frame.size.width - 110 * GlobalScale, 30)];
    _msgTF.backgroundColor = [UIColor colorWithRed:243/255.0 green:234/255.0 blue:231/255.0 alpha:1.0];
    
    [_imageView addSubview:_msgTF];
    _imageView.userInteractionEnabled = YES;
    _msgTF.tag = 101;
    _msgTF.clearButtonMode = UITextFieldViewModeAlways;
    _msgTF.placeholder = @"我来说两句";
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, WIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_imageView addSubview:lineView];
    
    
    return _imageView;
}










@end
