//
//  UIImage+UIImageScale.h
//  PaoPaoYou
//
//  Created by 吴狄 on 16/1/25.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)

// 获取适当截图的图像
- (UIImage *)needImage:(CGFloat)width           // 实际需要的尺寸的（这里默认是正方形）
             refFactor:(CGFloat)PhotoFactor;     // 参考因子，用来判断缩放的临界点
- (UIImage *)imagebyScalingToSize:(CGSize)targetSize;
- (UIImage *)reSizeImagetoRect:(CGRect)reRect;

+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
+(UIImage *)getScreenImg;
- (UIImage *)scaleImagetoScale:(float)scaleSize;

-(UIImage *)setRadiusImg:(CGFloat)radius;
@end
