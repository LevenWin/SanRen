//
//  CustomTabBar.m
//  SanRen
//
//  Created by 吴狄 on 16/10/25.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "CustomTabBar.h"

#define RoundBtn_Width 60
@interface CustomTabBar(){
    
}

@end
@implementation CustomTabBar
-(void)awakeFromNib{
    [super awakeFromNib];
      [self addTopLine];
    self.roundButton.frame = CGRectMake(0, 0, RoundBtn_Width, RoundBtn_Width);
    self.roundButton.drawRadius=[NSString stringWithFormat:@"%d",RoundBtn_Width/2];
    self.roundButton.backgroundColor=[UIColor whiteColor];
    [self.roundButton setImage:[UIImage imageNamed:@"icon_发布.png" ] forState:UIControlStateNormal];
//    self.roundButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 5);
    [self.roundButton addTarget:self action:@selector(roundBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.roundButton];
    self.backgroundColor=[UIColor whiteColor];
    
    //给 roundBtn画圆弧;
    CAShapeLayer *roundLayer=[CAShapeLayer layer];
    roundLayer.frame=CGRectMake(0, 0, RoundBtn_Width, RoundBtn_Width);
    roundLayer.fillColor=[UIColor clearColor].CGColor;
    roundLayer.lineWidth=0.5;
    roundLayer.strokeColor=LineColor.CGColor;
    roundLayer.backgroundColor=[UIColor clearColor].CGColor;
    UIBezierPath *roundPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(RoundBtn_Width/2, RoundBtn_Width/2) radius:RoundBtn_Width/2-0.5 startAngle:M_PI+M_PI/6 endAngle:2*M_PI-M_PI/6 clockwise:YES];
   
    
     roundLayer.path=roundPath.CGPath;
    [self.roundButton.layer addSublayer:roundLayer];
    
  
}

//懒加载
- (UIButton *)roundButton
{
    if (!_roundButton) {
        _roundButton = [[UIButton alloc] init];
    }
    return _roundButton;
}

- (void)roundBtnClicked{
    
    if ([self.myDelegate respondsToSelector:@selector(RoundButtonClicked)]) {
        [self.myDelegate RoundButtonClicked];
    }
   UITabBarController *tab= (id)[AppTraceManager shareInstance].rootViewController;
    tab.selectedIndex=1;
}

- (void)layoutSubviews{
    int centerx = self.bounds.size.width * 0.5;
    int centery = self.bounds.size.height * 0.5;
    self.roundButton.frame = CGRectMake(centerx - RoundBtn_Width/2, centery - 59+20, RoundBtn_Width, RoundBtn_Width);
    
//    Class class = NSClassFromString(@"UITabBarButton");
//    int index = 0;
//    int tabWidth = self.bounds.size.width / 3.0;
//
//    for (UIView *view in self.subviews) {
//        //找到UITabBarButton类型子控件
//        if ([view isKindOfClass:class]) {
//            CGRect rect = view.frame;
//            rect.origin.x = index * tabWidth;
//            rect.size.width = tabWidth;
//            view.frame = rect;
//            index++;
//            //留出位置放置中间凸出按钮
//            if (index == 1) {
//                index++;
//            }
//            
//        }
//    }
}

//响应触摸事件，如果触摸位置位于圆形按钮控件上，则由圆形按钮处理触摸消息
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //判断tabbar是否隐藏
    if (self.hidden == NO) {
        if ([self touchPointInsideCircle:self.roundButton.center radius:RoundBtn_Width/2 targetPoint:point]) {
            //如果位于圆形按钮上，则由圆形按钮处理触摸消息
            return self.roundButton;
        }
        else{
            //否则系统默认处理
            return [super hitTest:point withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}

- (BOOL)touchPointInsideCircle:(CGPoint)center radius:(CGFloat)radius targetPoint:(CGPoint)point
{
    CGFloat dist = sqrtf((point.x - center.x) * (point.x - center.x) +
                         (point.y - center.y) * (point.y - center.y));
    return (dist <= radius);
}
@end
