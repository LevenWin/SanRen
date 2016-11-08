//
//  StringAttributes.m
//  UU
//
//  Created by 陈浩 on 16/6/9.
//  Copyright © 2016年 陈浩. All rights reserved.
//

#import "StringAttributes.h"
#import <CoreText/CoreText.h>

@implementation StringAttributes

+ (NSMutableDictionary *)attributeFont:(UIFont *)font andTextColor:(UIColor *)color lineBreakMode:(CTLineBreakMode)lineBreakMode {
    
    //Determine default text color
    UIColor* textColor = color;
    //Set line height, font, color and break mode
    CTFontRef font1 = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize,NULL);
    //Apply paragraph settings
    CGFloat minimumLineHeight = font.pointSize,maximumLineHeight = minimumLineHeight+10;
    CTTextAlignment alignment = kCTLeftTextAlignment;
    CGFloat linespace = 3;
    
    //Apply paragraph settings
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[3]){
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},

        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &linespace },
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(CTLineBreakMode),&lineBreakMode}
    },3);
    
    
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    attributes[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    attributes[(id)kCTFontAttributeName] = (__bridge id)font1;
    attributes[(id)kCTParagraphStyleAttributeName] = (__bridge id)style;
    
    CFRelease(font1);
    CFRelease(style);
    
    
    return attributes;
    
//    UIColor*textColor=color;
//    
//    CTFontRef font1=CTFontCreateWithName((__bridge CFStringRef)font.fontName,font.pointSize, NULL);
//    
//    CGFloat minmumLineHeight=font.pointSize;
//    CGFloat maximumLineHeight=font.pointSize+10;
//    
//    CTTextAlignment aligment=kCTLeftTextAlignment;
//    CGFloat linespacce=3;
//    
//    CTParagraphStyleRef style=CTParagraphStyleCreate((CTParagraphStyleSetting[3]){
//        {kCTParagraphStyleSpecifierAlignment,sizeof(aligment),&aligment},
//        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat)},
//        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(CTLineBreakMode),&lineBreakMode}
//    }, 3);
//    
//    NSMutableDictionary *attibutes=[NSMutableDictionary dictionary];
//    attibutes[(id)kCTForegroundColorAttributeName]=(id)textColor.CGColor;
//    attibutes[(id)kCTFontAttributeName]=(__bridge id)font1;
//    attibutes[(id)kCTParagraphStyleAttributeName]=(__bridge id)style;
//    
//    CFRelease(font1);
//    CFRelease(style);
//    return attibutes;
//    
}

@end
