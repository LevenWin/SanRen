//
//  ImgTextLayer.h
//  SanRen
//
//  Created by 吴狄 on 16/10/29.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface ImgTextLayer : CALayer
@property (nonatomic,retain)UIImage *normalImg;
@property (nonatomic,retain)UIImage *highLightedImg;
@property (nonatomic,copy)NSString *text;

-(void)setImg:(UIImage*)normalImg selectedImg:(UIImage*)highLightedImg text:(NSString *)text;
-(void)hightLightedImage;
-(void)unHightLightedImage;
-(BOOL)touchBeginPoint:(CGPoint )point;
-(void)touchCancelPoint;
-(BOOL)touchEndPoint:(CGPoint)point action:(ImgResultBlock)block;

@end
