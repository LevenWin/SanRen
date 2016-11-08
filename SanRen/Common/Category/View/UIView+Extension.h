//
//  UIView+Extension.h
//  ZheJiang
//
//  Created by UI-5 on 15/12/9.
//  Copyright © 2015年 URoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 
 *
 链式编程
 */

//-(UIView *(^)())setTapAction;
-(UIView *(^)(UIColor *font))setBackground;

-(UIView *(^)(CGRect frame))setFrame;

-(UIView *(^)(SuccessBlock block))setTapAction;

@property (nonatomic,assign)BOOL centerScreen;

@property (nonatomic,assign)BOOL centerVer;
-(UIImage *)convertViewToImage;
- (UIColor *) colorOfPoint:(CGPoint)point;
-(void)showWithAnimation;
-(void)hideWithAnimation;
-(void)removeAllSubviews;
-(void)addAdjustSubview:(UIView*)view;
-(void)toDo:(VoidBlock)block1 orNot:(VoidBlock)block2;
-(void)addBlurEffect:(UIBlurEffectStyle )style;
-(void)addBlurEffect:(UIBlurEffectStyle )style alpha:(CGFloat)alpha;
-(void)addNoDataImg:(UIImage *)image;
-(void)addNodataString:(NSString *)text;
@end
