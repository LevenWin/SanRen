//
//  NSString+draw.m
//  DrawCellTest
//
//  Created by 吴狄 on 16/10/19.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "NSString+draw.h"
#import <CoreText/CoreText.h>
@implementation NSString (draw)
-(CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace textColor:(UIColor *)textColor lineBreakMode:(NSLineBreakMode)lineBreakMode{
    NSDictionary *attrbutes=[self attrbuteFont:font1 textColor:textColor lineBreakModel:(CTLineBreakMode)lineBreakMode];
    NSMutableAttributedString *string=[[NSMutableAttributedString alloc]initWithString:self attributes:attrbutes];
    
//    Core Foundation &&NSfoundation
    
    CFAttributedStringRef attrbutesRef=(__bridge CFAttributedStringRef)string;
    CTFramesetterRef frameset=CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrbutesRef);
    
    CGSize rec=CTFramesetterSuggestFrameSizeWithConstraints(frameset, CFRangeMake(0, [self length]), NULL, size, NULL);
    CFRelease(frameset);
    
    return rec;
    
    
    
   
}
-(NSMutableDictionary *)attrbuteFont:(UIFont*)font textColor:(UIColor*)color lineBreakModel:(CTLineBreakMode)lineBreakModel{
    CTFontRef font1=CTFontCreateWithName((__bridge CFStringRef)font.fontName,font.pointSize,NULL);
    CGFloat lineSpacec=3;
    CTTextAlignment aligment=kCTTextAlignmentLeft;
    CTParagraphStyleRef style=CTParagraphStyleCreate((CTParagraphStyleSetting[3]){
        {kCTParagraphStyleSpecifierAlignment,sizeof(aligment),&aligment},
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpacec},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(CTLineBreakMode),&lineBreakModel}
    }, 3);
    
    NSMutableDictionary *attrbutes=[NSMutableDictionary dictionary];
    attrbutes[(id)kCTForegroundColorAttributeName]=(__bridge id)color.CGColor;
    attrbutes[(id)kCTFontAttributeName]=(__bridge id )font1;
    attrbutes[(id)kCTParagraphStyleAttributeName]=(__bridge id )style;

    CFRelease(font1);
    CFRelease(style);
    
    return attrbutes;


    
}

@end
