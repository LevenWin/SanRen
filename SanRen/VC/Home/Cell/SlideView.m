//
//  SlideView.m
//  SanRen
//
//  Created by 吴狄 on 16/11/1.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "SlideView.h"
#define RIGHTE_COLOR [UIColor whiteColor]
#define LEFT_COLOR [UIColor orangeColor]
@interface SlideView()

@property (nonatomic,retain)UIProgressView *progressView;
@property (nonatomic,retain)UIView *pointView;

@end
@implementation SlideView
-(UIProgressView* )progressView{
    if (_progressView) {
        _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, self.width_gst, 2)];
        _progressView.progressTintColor=RIGHTE_COLOR;
    }
    return _progressView;
}
-(UIView *)pointView{
    if (!_pointView) {
        _pointView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
        _pointView.drawRadius=@"4";
        _pointView.backgroundColor=[UIColor whiteColor];
    }
    return _pointView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    return self;
}
-(void)initUI{
    [self addSubviewAtCenter:self.progressView];
    [self addSubview:self.pointView];
}
-(void)setCurrentPrecent:(CGFloat)currentPrecent{
    self.progressView.progress=currentPrecent;
    self.pointView.left_gst=self.width_gst*currentPrecent-4;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject]locationInView:self];
    
    CGFloat prcent=(point.x-self.left_gst)/self.width_gst;
    [self refreshProgress:prcent];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject]locationInView:self];
    
    CGFloat prcent=(point.x-self.left_gst)/self.width_gst;
    [self refreshProgress:prcent];
}
-(void)refreshProgress:(CGFloat)precent{
    if (self.seekDidChange) {
        self.seekDidChange(precent);
    }
    self.currentPrecent=precent;
}
@end
