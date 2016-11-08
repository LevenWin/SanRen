//
//  DrawLayer.h
//  SanRen
//
//  Created by 吴狄 on 16/10/22.
//  Copyright © 2016年 Leven. All rights reserved.
//

#ifndef DrawLayer_h
#define DrawLayer_h
#import <UIKit/UIKit.h>
#import "EXTADT.h"
#import "EXTScope.h"
#import "SDWebImageManager.h"
#import "UIView+GaosutongExtension.h"
#define RGB(A, B, C)    [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenHeight ScreenBounds.size.height
#define ScreenWidth ScreenBounds.size.width


#define FontWithSize1(s) [UIFont fontWithName:@"STHeitiSC-Light" size:s]
#define FontWithSize(s) [UIFont systemFontOfSize:s]
#define BoldFontWithSize(s) [UIFont fontWithName:@"STHeitiSC-Medium" size:s]

#define kNicknameFont FontWithSize(17)
#define kContentTextFont FontWithSize(17)
#define kUniversityFont FontWithSize(12)

#define kMaxContentImageSide 300.0
#define kAvatar 43
#define kSpec 10
#define minSpec 5

#define kTextGap 15
#define kImageGap 2
#define kTextXOffset kAvatar + 2 * kSpec
#define kContentTextWidth (ScreenWidth - kAvatar - kSpec * 2 - kTextGap)
#define kContentImageWidth (ScreenWidth - kAvatar - kSpec * 2 - 30 - kImageGap * 2) / 3.0

typedef void (^VoidResultBlock)();
typedef void (^ImgResultBlock)(UIImage *image,CGRect frame);

typedef void(^VideoPerDataBlock)(CGImageRef imageData, NSString *filePath);
typedef void(^VideoStopDecodeBlock)(NSString *filePath);


#endif /* DrawLayer_h */
