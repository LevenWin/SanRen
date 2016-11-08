//
//  NSDate+TimeDetail.m
//  PaoPaoYou
//
//  Created by MYMAC on 16/1/16.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "NSDate+TimeDetail.h"

@implementation NSDate (TimeDetail)

// 输入的日期字符串形如：@"1992-05-21 13:08:08"
+ (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

// 获取当前时间
- (NSDate *)getCurrentDate{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
    NSString *currentTime = [format stringFromDate:NSDate.date];
    NSDate *time = [NSDate dateFromString:currentTime];
    return time;
}


//- (NSString *)prettyDateWithReference:(NSDate *)reference {
- (NSString *)prettyDateWithReference{
    NSString *suffix = @"前";
    
    NSDate *reference = NSDate.date;//[self getCurrentDate];
    
    // 比较两个NSDate的间隔,返回的是一个double值，单位是秒
    float different = [reference timeIntervalSinceDate:self];
    
    
    if (different < 0) {
        return @"";
        
//        different = -different;
//        suffix = @"刚刚";
    }
    
    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);
    
    int days   = (int)dayDifferent;
    int weeks  = (int)ceil(dayDifferent / 7);
    int months = (int)ceil(dayDifferent / 30);
    int years  = (int)ceil(dayDifferent / 365);
    
    // It belongs to today
    if (dayDifferent <= 0) {
        // lower than 60 seconds
        if (different < 60.0f) {   // <1min
            return @"刚刚";
        }
        
        // lower than 120 seconds => one minute and lower than 60 seconds
        if (different < 120.0f) {  // <2min
            return [NSString stringWithFormat:@"1分钟%@", suffix];
        }
        
        // lower than 60 minutes
        if (different < 60.0f * 60.0f) { // <1hour
            return [NSString stringWithFormat:@"%d分钟%@", (int)floor(different / 60), suffix];
        }
        
        // lower than 60 * 2 minutes => one hour and lower than 60 minutes
        if (different < 60.0f * 60.0f * 2) { // <2小时
            return [NSString stringWithFormat:@"%d小时%@", (int)floor(different / 3600), suffix];
        }
        
        // lower than one day
        if (different < 86400.0f) {
            NSString *str = [NSString stringWithFormat:@"%d",(int)floor(different / 3600)];
            if (str.intValue > 12) {
                
                return @"昨天";
//                NSDateFormatter *format = [[NSDateFormatter alloc] init];
//                [format setDateFormat:@"MM/dd/HH:mm"];
//                NSString *currentTime = [format stringFromDate:self];
//                return currentTime;
            }
            return [NSString stringWithFormat:@"%d小时%@", (int)floor(different / 3600), suffix];
        }
    }
    // lower than one week
    else if (days < 7) {
        if (days == 1) {
            return @"昨天";
            
        }else if (days == 2) {
            return @"前天";
       
        }else{
            return [NSString stringWithFormat:@"%d天%@", days, suffix];
        }
    }
    // lager than one week but lower than a month
    else if (weeks < 4) {
        return [NSString stringWithFormat:@"%d周%@", weeks, suffix];
    }
    // lager than a month and lower than a year
    else if (months < 12) {
        return [NSString stringWithFormat:@"%d月%@", months, suffix];
    }
    // lager than a year
    else {
        return [NSString stringWithFormat:@"%d年%@", years, suffix];
    }
    
    return self.description;
}

+ (NSDate *)dateFromTimestamp:(long long )dateValue {
    NSDate *date = nil;
    if (dateValue == 0) {
        date = [NSDate dateWithTimeIntervalSinceNow:0];
    } else {
        date = [NSDate dateWithTimeIntervalSince1970:dateValue/1000.0];
    }
    
    return date;
}


@end
