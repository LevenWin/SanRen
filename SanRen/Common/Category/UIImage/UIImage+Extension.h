//
//  UIImage+Extension.h
//  02-图片拉伸
//
//  Created by xiaomage on 15/6/6.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)resizableImage:(NSString *)name;
+ (UIImage *)buttonImageFromColor:(UIColor *)color;
- (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)newImageWithBlue:(UIImage *)image;
+(UIImage *)getVideoThumbImgWith:(NSString *)url;
-(UIImage *)blurImg;
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;

@end
