//
//  UIImageView+extion.h
//  SmartSchool
//
//  Created by 吴狄 on 16/7/18.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface UIImageView (extion)
//@property (nonatomic,copy)NSString* hasAnimationShow;
-(void)setImgWithFadeAnimationUIImage:(UIImage*)image;
-(void)setImgWithFadeAnimationUIImage:(UIImage *)image inteval:(CGFloat)inteval;
-(void)setImgWithFadeAnimationNSString:(NSString *)imageUrl;
//优化圆角
-(void)setImg:(NSString *) url withCorner:(int)cordius;
-(void)touchEnd:(CGPoint )endPoint begin:(CGPoint)beginPoint model:(MessageModel *)model type:(NSInteger)type;
@end
