//
//  NSDate+TimeDetail.h
//  PaoPaoYou
//
//  Created by MYMAC on 16/1/16.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeDetail)


+ (NSDate *)dateFromString:(NSString *)dateString;
- (NSString *)prettyDateWithReference;


+ (NSDate *)dateFromTimestamp:(long long)dateValue;
@end
