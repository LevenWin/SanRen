//
//  UIView+Extension.m
//  ZheJiang
//
//  Created by UI-5 on 15/12/9.
//  Copyright © 2015年 URoad. All rights reserved.
//

#import "UIView+Extension.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIView (Extension)

-(UIView *(^)(UIColor *))setBackground{
    
    return ^(UIColor *color){
        self.backgroundColor=color;
        return self;
    };
}
-(UIView *(^)(CGRect frame))setFrame{
    return ^(CGRect frame){
        self.frame=frame;
        
        return self;
    };
}

-(UIView *(^)(SuccessBlock block))setTapAction{
    return ^(SuccessBlock block){
        
        [self setTapAction:^(UITapGestureRecognizer *tap) {
            if (block) {
                block(tap.view);
            }
        }];
        return self;
    };
    
}

-(UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



- (UIColor *) colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}
-(void)showWithAnimation{
    self.hidden=NO;
    self.alpha=0    ;
    [UIView animateWithDuration:0.7 animations:^{
        self.alpha=1;
    }];
}
-(void)hideWithAnimation{
  
    [UIView animateWithDuration:0.7 animations:^{
            self.alpha=0    ;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)removeAllSubviews{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
}
-(void)addAdjustSubview:(UIView *)view{
    view.frame=self.bounds;
    [self addSubview:view];
}
-(void)setCenterVer:(BOOL)centerVer{
    if (centerVer) {
        
        CGPoint center=self.center;
        center=CGPointMake(self.superview.width_gst/2, center.y);
        self.center=center;
        [self.superview setNeedsLayout];
            
       
    }
}
-(void)setCenterScreen:(BOOL)centerScreen{
    if (centerScreen) {
        CGPoint center=self.center;
        center=CGPointMake(UISCREEN_WIDTH/2, center.y);
        self.center=center;
        [self.superview setNeedsLayout];

    }
}
-(void)toDo:(VoidBlock)block1 orNot:(VoidBlock)block2{
    __Block(blockSelf);
    [self setTapAction:^(UITapGestureRecognizer *tap) {
        if ([blockSelf.attachObj isEqualToString:@"0"]) {
            if (block1) {
                block1();
            }
            blockSelf.attachObj=@"1";
        }else{
            if (block2) {
                block2();
            }
            blockSelf.attachObj=@"0";
        }
    }];
}
-(void)addBlurEffect:(UIBlurEffectStyle )style{
    [self addBlurEffect:style alpha:1];
}
-(void)addBlurEffect:(UIBlurEffectStyle )style alpha:(CGFloat)alpha{
    UIVisualEffectView *effectview=[[UIVisualEffectView alloc]initWithFrame:CGRectMake(self.left_gst, self.top_gst, self.width_gst, self.height_gst)];
    effectview.effect=[UIBlurEffect effectWithStyle:style];
    effectview.alpha=alpha;
    effectview.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    if (self.superview) {
        [self.superview insertSubview:effectview aboveSubview:self];
        
    }else{
        [self addSubview:effectview];
    }

}
-(void)addNoDataImg:(UIImage *)image{
    UIImageView *img=[[UIImageView alloc]initWithFrame:self.bounds];
    img.image=image;
    img.contentMode=UIViewContentModeCenter;
    [self addSubview:img];
}

-(void)addNodataString:(NSString *)text{
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((UISCREEN_WIDTH-100)/2, 200, 100, 100)];
    img.image=Image(@"empty");
    img.contentMode=UIViewContentModeCenter;
    [self addSubview:img];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 320, UISCREEN_WIDTH, 30)
                  ];
    lab.text=text;
    lab.setTextColor([UIColor colorWithRed:0.5284 green:0.5284 blue:0.5284 alpha:1.0]).setFont([UIFont systemFontOfSize:14]).settextAlignment(NSTextAlignmentCenter);
    [self addSubview:lab];
}
@end
