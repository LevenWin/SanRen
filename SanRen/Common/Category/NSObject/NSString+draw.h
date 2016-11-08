//
//  NSString+draw.h
//  DrawCellTest
//
//  Created by 吴狄 on 16/10/19.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^contentBlock)(UIImage *image);

@interface NSString (draw)
- (CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace textColor:(UIColor*)textColor lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (void)setText:(NSString *)text
        context:(CGContextRef)context
    contentSize:(CGSize)size
backgroundColor:(UIColor *)backgroundColor
           font:(UIFont *)font
      textColor:(UIColor *)textColor
          block:(contentBlock)block
        xOffset:(CGFloat)x
        yOffset:(CGFloat)y;
@end
