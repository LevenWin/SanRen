//
//  UIImage+UIImageScale.m
//  PaoPaoYou
//
//  Created by 吴狄 on 16/1/25.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "UIImage+UIImageScale.h"

@implementation UIImage (UIImageScale)


- (UIImage *)reSizeImagetoRect:(CGRect)reRect {
    UIGraphicsBeginImageContext(CGSizeMake(reRect.size.width, reRect.size.height));
    [self drawInRect:reRect];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}
// 2.自定长宽
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

// 1.等比率缩放
- (UIImage *)scaleImagetoScale:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

// 截取部分图像
-(UIImage*)getSubImage:(CGRect)rect{
    CGImageRef imageRef = self.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef,rect);  // 裁剪后图片
    UIImage *cropImage = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return cropImage;
}

// 获取适当截图的图像
- (UIImage *)needImage:(CGFloat)width           // 实际需要的尺寸的（这里默认是正方形）
             refFactor:(CGFloat)PhotoFactor     // 参考因子，用来判断缩放的临界点
{
    UIImage *tempImage = self;
    
    // 得到图片的尺寸
    CGSize size = tempImage.size;
    CGImageRef cgimage;
    
    if ((size.width <= width) && (size.height <= width)){   // w<width,h<width
        // 1、判断WH谁更接近width，然后算出比例，进行比例放大
        if (size.width < size.height) {
            tempImage = [tempImage scaleImagetoScale:(1 + (width - size.width) / size.width )];
            cgimage = CGImageCreateWithImageInRect([tempImage CGImage], CGRectMake(0, (tempImage.size.height - width ) * 0.5f, width,width));
            
        }else{
            tempImage = [tempImage scaleImagetoScale:(1 + (width - size.height) / size.height)];
            cgimage = CGImageCreateWithImageInRect([tempImage CGImage], CGRectMake((tempImage.size.width - width ) * 0.5f, 0, width,width));
        }
        
    }else if ((size.width > width) && (size.height <= width)){ // w>width,h<width
        // 2.根据H求出比例放大倍率，再进行比例放大
        tempImage = [tempImage scaleImagetoScale:(1 + (width - size.height) / size.height)];  // 放大高度
        cgimage = CGImageCreateWithImageInRect([tempImage CGImage], CGRectMake((tempImage.size.width - width ) * 0.5f, 0, width,width));
        
        
    }else if ((size.width <= width) && (size.height > width)){ // w<width,h>width
        // 3.根据w求出比例放大倍率，再进行比例放大
        tempImage = [tempImage scaleImagetoScale:(1 + (width - size.width) / size.width )]; // 放大宽度
        cgimage = CGImageCreateWithImageInRect([tempImage CGImage], CGRectMake(0, (tempImage.size.height - width ) * 0.5f, width,width));
        
    }else if ((size.width > width) && (size.height > width)){ // w>width,h>width
        // 4.判断WH谁比width更大，然后适当缩小，再进行裁剪
        if (size.width > size.height) { // w>h
            
            if (size.height / width >= PhotoFactor) {    // 如果大于1.5倍，则缩小至1.5倍
                // 1.先缩小图片
                tempImage = [tempImage scaleImagetoScale:(width / size.height)];  // 缩放高度
                
            }
            // 2.横向裁剪图片
            cgimage = CGImageCreateWithImageInRect([tempImage CGImage], CGRectMake((tempImage.size.width - width ) * 0.5f, 0, width,width));
            
        }else{  // w<h
            if (size.width / width >= PhotoFactor) {    // 如果大于1.5倍，则缩小至1.5倍
                // 1.先缩小图片
                tempImage = [tempImage scaleImagetoScale:(width / size.width)];  // 缩放宽度
                
            }
            // 2.纵向裁剪图片
            cgimage = CGImageCreateWithImageInRect([tempImage CGImage], CGRectMake(0, (tempImage.size.height - width ) * 0.5f, width,width));
        }
    }
    
    return (UIImage *)[UIImage imageWithCGImage:cgimage];
}

/**
 *  剪切图片为正方形
 *
 *  @param image   原始图片比如size大小为(400x200)pixels
 *  @param newSize 正方形的size比如400pixels
 *
 *  @return 返回正方形图片(400x400)pixels
 */
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width >= image.size.height) {
        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [image drawAtPoint:origin];
    
    //获取缩放后剪切的image图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
- (UIImage *)imagebyScalingToSize:(CGSize)targetSize {
           // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        //Determine whether the screen is retina
        if([[UIScreen mainScreen] scale] == 2.0){
            UIGraphicsBeginImageContextWithOptions(targetSize, NO, 2.0);
        }else{
            UIGraphicsBeginImageContext(targetSize);
        }
        // 绘制改变大小的图片
        [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return scaledImage;
    
}
+(UIImage *)getScreenImg{
    UIGraphicsBeginImageContextWithOptions([UIApplication sharedApplication].keyWindow.bounds.size,NO,[UIScreen mainScreen].scale);
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}
-(UIImage *)setRadiusImg:(CGFloat)radius{
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.size.width, self.size.width)];
    CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage* output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;

}
@end
