//
//  ImgTextLayer.m
//  SanRen
//
//  Created by 吴狄 on 16/10/29.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "ImgTextLayer.h"
#import "LWImageLayer.h"
#import "ContentTextManager.h"
#import "LWTextLayer.h"
@interface ImgTextLayer(){
    
}
@property(nonatomic,retain)LWImageLayer *imgLayer;
@property(nonatomic,retain)LWTextLayer *textLayer;
@property (nonatomic,retain)ContentTextManager *drawManager;

@end
@implementation ImgTextLayer
-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}
-(LWImageLayer*)imgLayer{
    if (!_imgLayer) {
        _imgLayer=[[LWImageLayer alloc] init];
        _imgLayer.frame=CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
    }
    return _imgLayer;
}
-(LWTextLayer*)textLayer{
    if (_textLayer) {
        _textLayer=[[LWTextLayer alloc]init];
        _textLayer.frame=CGRectMake(self.frame.size.width/2, 0, self.frame.size.width, self.frame.size.height);
    }
    return _textLayer;
}
-(ContentTextManager *)drawManager{
    if (!_drawManager) {
        _drawManager=[[ContentTextManager alloc]init];
    }
    return _drawManager;
}
-(void)setImg:(UIImage*)normalImg selectedImg:(UIImage*)highLightedImg text:(NSString *)text{
    _normalImg=normalImg;
    _highLightedImg=highLightedImg;
    _text=text;
    self.imgLayer.contents=(__bridge id _Nullable)normalImg.CGImage;
    self.textLayer.content=text;
    
    
}
-(void)hightLightedImage{
    
}
-(void)unHightLightedImage{
    
}
-(BOOL)touchBeginPoint:(CGPoint )point{
    return YES;
}
-(void)touchCancelPoint{
    
}
-(BOOL)touchEndPoint:(CGPoint)point action:(ImgResultBlock)block{
    return YES;
}
@end
