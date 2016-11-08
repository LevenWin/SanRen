//
//  LWImageLayer.h
//  DrawCellTest
//
//  Created by 吴狄 on 16/10/20.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@interface LWImageLayer : CALayer
@property (nonatomic,retain)UIImage *originImage;
@property (nonatomic,retain)NSString *imgUrl;
@property (nonatomic,retain)id <SDWebImageOperation> operation;
@property (nonatomic,retain)UIImage *highlightImage;
-(void)cancelLoadImg;
-(void)hightLightedImage;
-(void)unHightLightedImage;
-(void)setImageUrl:(NSString *)urlString;
-(void)setImageUrl:(NSString *)urlString radius:(CGFloat)radius;
-(BOOL)touchBeginPoint:(CGPoint )point;
-(void)touchCancelPoint;
-(BOOL)touchEndPoint:(CGPoint)point action:(ImgResultBlock)block;
@end
