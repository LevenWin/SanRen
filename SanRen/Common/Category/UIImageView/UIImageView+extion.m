//
//  UIImageView+extion.m
//  SmartSchool
//
//  Created by 吴狄 on 16/7/18.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "UIImageView+extion.h"

@implementation UIImageView (extion)
-(void)setImgWithFadeAnimationUIImage:(UIImage *)image{
    [self setImgWithFadeAnimationUIImage:image inteval:0.5];

}
-(void)setImgWithFadeAnimationUIImage:(UIImage *)image inteval:(CGFloat)inteval{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = inteval;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:transition forKey:nil];
    self.image=image;
}
-(void)setImgWithFadeAnimationNSString:(NSString *)imageUrl{
    [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType==SDImageCacheTypeNone) {
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration = 0.4f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [self.layer addAnimation:transition forKey:nil];
            self.image=image;
        }else{
            self.image=image;
            
        }
        
        
    }];

}
//static char  *animation;
//-(void)setImage:(UIImage *)image{
//    if (self.hasAnimationShow.integerValue==0) {
//        self.hasAnimationShow=@"1";
//        CATransition *transition = [CATransition animation];
//        transition.type = kCATransitionFade;
//        transition.duration = 0.7f;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        [self.layer addAnimation:transition forKey:nil];
//        self.image=image;
//
//    }else {
//        self.image=image;
//    }
//   
//}
//-(void)setHasAnimationShow:(NSString*)hasAnimationShow{
//    objc_setAssociatedObject(self, animation, hasAnimationShow, OBJC_ASSOCIATION_RETAIN);
//}
//-(NSString *)hasAnimationShow{
//    if (objc_getAssociatedObject(self, animation)) {
//        return objc_getAssociatedObject(self, animation);
//    }
//    return @"0";
//}


-(void)setImg:(NSString *) url withCorner:(int)cordius{
    
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
        UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cordius, cordius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        CGContextClip(UIGraphicsGetCurrentContext());
        
        [image drawInRect:rect];
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
        UIImage* output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.image=output;

    }];
    
   
}
-(void)touchEnd:(CGPoint )endPoint begin:(CGPoint)beginPoint model:(MessageModel *)model type:(NSInteger)type{
    if (CGRectContainsPoint(self.frame,endPoint)&&CGRectContainsPoint(self.frame , beginPoint)) {
        self.highlighted=!self.highlighted;
        
        if (self.highlighted) {
           
        }
        if (type==0) {
            
        }else if (type==1){
            model.commentlikestatues=[NSNumber numberWithBool:self.highlighted];
        }else if (type==2){
            
        }

       
        
        
    }
}
@end
