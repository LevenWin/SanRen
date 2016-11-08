//
//  LoaderView.m
//  loaderTest
//
//  Created by 吴狄 on 16/10/17.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "LoaderView.h"
@interface LoaderView()
@property (nonatomic,retain)CAShapeLayer *shapeLayer;
@property (nonatomic,retain)CALayer *testLayer;
@end
@implementation LoaderView

-(void)drawRect:(CGRect)rect{
    
    [self.testLayer removeFromSuperlayer];
    _testLayer = [CALayer layer];
    _testLayer.backgroundColor = [UIColor clearColor].CGColor;
    _testLayer.frame = CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6);
    [self.layer addSublayer:_testLayer];
    
    CAShapeLayer* bottomLayer = [CAShapeLayer layer];
    bottomLayer.fillColor = [UIColor clearColor].CGColor;
    bottomLayer.strokeColor = [UIColor whiteColor].CGColor;
    bottomLayer.lineCap = kCALineCapRound;
    bottomLayer.lineWidth = 2;
    
    
    UIBezierPath *bottomPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2-3, self.frame.size.height/2-3) radius:self.frame.size.width/2-6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    bottomLayer.path = bottomPath.CGPath;
    [_testLayer addSublayer:bottomLayer];
    
    
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.strokeColor = [UIColor colorWithRed:0.6477 green:0.6477 blue:0.6477 alpha:1.0].CGColor;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineWidth = 2;
    
    UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2-3, self.frame.size.height/2-3) radius:self.frame.size.width/2-6 startAngle:M_PI*3/2 endAngle:M_PI*3/2 +M_PI*2*self.percent clockwise:YES];
    _shapeLayer.path = thePath.CGPath;
    [_testLayer addSublayer:_shapeLayer];
    
    
}

-(void)setPercent:(CGFloat)percent{
    _percent=percent;
    [self drawRect:self.frame];
}

@end
