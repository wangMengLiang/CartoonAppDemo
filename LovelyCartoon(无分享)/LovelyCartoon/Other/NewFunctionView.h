//
//  NewFunctionView.h
//  JokeText
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^Finish)(void);
@interface NewFunctionView : UIView

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray*)imageArr isNetImage:(BOOL)isNetImage finish:(Finish)finish;


@end
