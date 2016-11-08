//
//  NSString+Helper.h
//  SmartSchool
//
//  Created by 吴狄 on 16/4/27.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Helper)
+  (int)convertToInt:(NSString*)strtemp;
+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string;
- (float) heightWithFont: (UIFont *) font withinWidth: (float) width;
-(NSString *)decodeUTF8String;
-(NSString *)encodeUTF8String;
+ (BOOL)stringContainsEmoji:(NSString *)string;
+(NSString*)getCurrentTime;
-(NSString *)cutSpace;
- (NSString *) md5;
@end
