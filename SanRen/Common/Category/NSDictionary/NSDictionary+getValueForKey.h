//
//  NSDictionary+getStringForKey.h
//  yiqihao
//
//  Created by fwping on 14-3-20.
//  Copyright (c) 2014年 yiqihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (getValueForKey)

// 取key值
- (id)getValueForKey:(NSString *)key;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;;
@end
