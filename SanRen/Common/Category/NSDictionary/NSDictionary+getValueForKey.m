//
//  NSDictionary+getStringForKey.m
//  yiqihao
//
//  Created by fwping on 14-3-20.
//  Copyright (c) 2014年 yiqihao. All rights reserved.
//

#import "NSDictionary+getValueForKey.h"

@implementation NSDictionary (getValueForKey)

- (id)getValueForKey:(NSString *)key{

    // 如果字段不在该字典中
    if (![self isInDic:key]) {
        return nil;
        //return @"";
    }
    
    
    // 如果在字典中，则判断该数据类型
    id result = [self valueForKey:key];
    
    if ([NSNull null] == result || nil == result) {
        return [NSString stringWithFormat:@"    "];   // 空值
        
    }else if([result isKindOfClass:[NSNumber class]]){
        return [result stringValue];    // int
        
    }else{
        return result;  // string
    }
}


// 单纯判断某个键是否在这个字典中
- (BOOL)isInDic:(NSString *)key{
    for (NSString *indef in self.allKeys) {
        if ([key isEqualToString:indef]) {
            return YES;
        }
    }
    
    return NO;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
