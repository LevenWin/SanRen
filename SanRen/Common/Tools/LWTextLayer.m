//
//  LWTextLayer.m
//  DrawCellTest
//
//  Created by 吴狄 on 16/10/19.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "LWTextLayer.h"
#import "ContentTextManager.h"
#import "NSString+draw.h"
@implementation LWTextLayer
-(void)setContent:(NSString *)content{
    _content=content;
     [self fillContent];
}
-(void)setTagDic:(NSMutableDictionary *)tagDic{
    _tagDic=tagDic;
    [self fillContent];
}
-(void)fillContent{
    CGSize contentSize=[_content sizeWithConstrainedToSize:CGSizeMake(ScreenWidth-2*kSpec, MAXFLOAT) fromFont:[UIFont systemFontOfSize:16] lineSpace:3 textColor:[UIColor darkGrayColor] lineBreakMode:NSLineBreakByWordWrapping];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(contentSize.width+2*kSpec, contentSize.height+2*kSpec), NO, 0);
    CGContextRef context=UIGraphicsGetCurrentContext();
     [UIColorFromRGB(0xffffff) set];
    CGContextFillRect(context, CGRectMake(0, 0,contentSize.width+2*kSpec,contentSize.height+2*kSpec));
    [self fillData:context];
    UIImage *tempImg=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.contents=(__bridge id _Nullable)(tempImg.CGImage);
}
-(void)fillData:(CGContextRef)context{
//    [self.contents ];
}
@end
