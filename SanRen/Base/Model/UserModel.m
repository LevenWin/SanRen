//
//  UserModel.m
//  SanRen
//
//  Created by 吴狄 on 16/9/21.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    if (dic) {
        [self setValuesForKeysWithDictionary:dic];

    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
