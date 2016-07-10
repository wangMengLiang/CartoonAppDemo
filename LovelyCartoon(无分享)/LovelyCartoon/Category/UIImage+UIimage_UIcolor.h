//
//  UIImage+UIimage_UIcolor.h
//  Mami
//
//  Created by lijiarui on 15/4/9.
//  Copyright (c) 2015年 lijiarui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIimage_UIcolor)

//颜色转UIImage
+(UIImage *)imageWithColor:(UIColor *)color;
//截取部分图像

-(UIImage*)getSubImage:(CGRect)rect;
//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size;
//uiimage 变成圆形
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset ;



//指定size按比例缩放
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
//指定宽度按比例缩放
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
