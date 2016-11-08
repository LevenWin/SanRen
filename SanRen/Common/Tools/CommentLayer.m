//
//  CommentLayer.m
//  SanRen
//
//  Created by 吴狄 on 16/10/31.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "CommentLayer.h"
#define Avator_Width 30
#define Zan_Width 30
#define Nickname_Font [UIFont systemFontOfSize:14]
#define Content_Font  [UIFont systemFontOfSize:14]
#define Time_Font  [UIFont systemFontOfSize:12]

#define WIDTH ScreenWidth-2*kSpec-minSpec*3-Avator_Width

@interface CommentLayer (){
    
}
//最热评论
@property (nonatomic,retain)LWImageLayer *bgImgLayer;
@property (nonatomic,retain)LWImageLayer *zanImgLayer;

@property (nonatomic,retain)LWImageLayer *headrImgLayer;
@property (nonatomic,retain)ContentTextManager *drawManager;

@end
@implementation CommentLayer
-(void)setModel:(CommentModel *)model{
    _model=model;
    [self drawImage];
    [self drawText];
    self.backgroundColor=[UIColor colorWithRed:0.9444 green:0.9444 blue:0.9444 alpha:1.0].CGColor;
}
-(LWImageLayer*)headrImgLayer{
    if (!_headrImgLayer) {
        _headrImgLayer=[[LWImageLayer alloc]init];
    }
    return _headrImgLayer;
}
-(LWImageLayer*)bgImgLayer{
    if (!_bgImgLayer) {
        _bgImgLayer=[[LWImageLayer alloc]init];
        _bgImgLayer.frame=CGRectMake(UISCREEN_WIDTH-100, minSpec, 40, 40);
    }
    return _bgImgLayer;
}
-(LWImageLayer*)zanImgLayer{
    if (!_zanImgLayer) {
        _zanImgLayer=[[LWImageLayer alloc]init];
        _zanImgLayer.frame=CGRectMake(UISCREEN_WIDTH-kSpec-60, minSpec, 15, 15);
    }
    return _zanImgLayer;
}
-(void)drawImage{
    [self.headrImgLayer setImageUrl:_model.uImage radius:0.5];
     self.headrImgLayer.frame=_model.avatorRect;
    [self addSublayer:_headrImgLayer];
    
    if ([self.model.commentlikestatues integerValue]>0) {
        
        [self.bgImgLayer setContents:(id _Nullable)Image(@"最热评论") .CGImage];
        [self insertSublayer:self.bgImgLayer atIndex:0];
    }
    UIImage *zanImg=[Image(@"like.png") imagebyScalingToSize:CGSizeMake(20, 20) ];
    [self.zanImgLayer setContents:(id _Nullable)zanImg.CGImage];
    self.zanImgLayer.contentsGravity=@"resizeAspect";
    [self addSublayer:_zanImgLayer];

}
-(ContentTextManager *)drawManager{
    if (!_drawManager) {
        _drawManager=[[ContentTextManager alloc]init];
    }
    return _drawManager;
}
-(void)drawText{
    //集成当前的上下文信息
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(UISCREEN_WIDTH, _model.containerHeight), YES, 0);
    CGContextRef context=UIGraphicsGetCurrentContext();
    [[UIColor colorWithRed:0.9307 green:0.9307 blue:0.9307 alpha:1.0] set];
    CGContextFillRect(context, CGRectMake(0,0,UISCREEN_WIDTH,_model.containerHeight));

    [self fillData:context];
    
    //获取当前上下面截图
    UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.contents = (__bridge id _Nullable)(temp.CGImage);
}
-(void)fillData:(CGContextRef)context{
    

    //name;
    [self.drawManager setText:_model.uUsername context:context contentSize:CGSizeMake(WIDTH, _model.nicknameRect.size.height) backgroundColor:[UIColor whiteColor] font:Nickname_Font textColor:[UIColor blackColor] block:nil xOffset:_model.nicknameRect.origin.x yOffset:_model.nicknameRect.origin.y];
    //time
    [self.drawManager setText:_model.createTime context:context contentSize:CGSizeMake(WIDTH, _model.timeRect.size.height) backgroundColor:[UIColor whiteColor] font:Time_Font textColor:[UIColor darkGrayColor] block:nil xOffset:_model.timeRect.origin.x yOffset:_model.timeRect.origin.y];
//    //将配置信息，与该上下文传入
    [self.drawManager setText:_model.comment context:context contentSize:CGSizeMake(_model.contentRect.size.width, _model.contentRect.size.height) backgroundColor:[UIColor whiteColor] font:Content_Font textColor:[UIColor blackColor] block:nil xOffset:_model.contentRect.origin.x yOffset:_model.contentRect.origin.y];
    
    
    [self.drawManager setText:NSStringFromeObj(_model.commentZanner) context:context contentSize:CGSizeMake(_model.zanRect.size.width, _model.zanRect.size.height) backgroundColor:[UIColor whiteColor] font:Time_Font textColor:[UIColor darkGrayColor] block:nil xOffset:_model.zanRect.origin.x yOffset:_model.zanRect.origin.y];


    
    
}
-(void)touchEnd:(CGPoint)point beginPoint:(CGPoint)beginPoint{
    CGPoint convertpoint=[self convertPoint:point fromLayer:self.superlayer];
    CGPoint startPoint=[self convertPoint:beginPoint fromLayer:self.superlayer];

    if (CGRectContainsPoint(self.headrImgLayer.frame, convertpoint)) {
        
    }
    if (CGRectContainsPoint(self.contentsRect, convertpoint)) {
        
    }
    if (CGRectContainsPoint(self.zanImgLayer.frame, convertpoint)) {
        self.model.commentlikestatues=[NSNumber numberWithInt:!self.model.commentlikestatues.integerValue];
        if (self.model.commentlikestatues.integerValue==1) {
            UIImage *zanImg=[Image(@"like.png") imagebyScalingToSize:CGSizeMake(20, 20) ];
            [self.zanImgLayer setContents:(id _Nullable)zanImg.CGImage];
        }else{
            UIImage *zanImg=[Image(@"like_sel.png") imagebyScalingToSize:CGSizeMake(20, 20) ];
            [self.zanImgLayer setContents:(id _Nullable)zanImg.CGImage];
        }
        
    }
    
}
-(void)clearLayer{
    [self.headrImgLayer removeFromSuperlayer];
    [self.zanImgLayer removeFromSuperlayer];
    
    
}
@end
