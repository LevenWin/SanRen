//
//  CFuncationHelper.m
//  SmartSchool
//
//  Created by 吴狄 on 16/8/8.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "CFuncationHelper.h"


FOUNDATION_EXPORT NSString *NSStringFromeObj(id obj){
    return [NSString stringWithFormat:@"%@",obj];
}

FOUNDATION_EXPORT NSString *NSStringFromeFloat(CGFloat num){
    return [NSString stringWithFormat:@"%f",num];
}
FOUNDATION_EXPORT NSString *NSStringFromeInt(NSInteger num){
    return [NSString stringWithFormat:@"%lu",num];
}

FOUNDATION_EXPORT id GetUserDefaults(NSString *key){
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}
FOUNDATION_EXPORT void SetUserDefaults(NSString *key,id obj){
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    
}

FOUNDATION_EXPORT  id GetSingleInstance(Class Name){
    static id instace=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace=[[Name alloc]init];
    });
    return instace;
}
FOUNDATION_EXPORT  void PostNotice(NSString* Name ,id obj){
    [[NSNotificationCenter defaultCenter]postNotificationName:Name object:obj];
}
FOUNDATION_EXPORT BOOL ImgHasCache(NSString*url){
    SDWebImageManager* manager = [SDWebImageManager sharedManager];
    BOOL isImageCached = [manager cachedImageExistsForURL:[NSURL URLWithString:url]];
    return isImageCached;
}
@implementation CFuncationHelper

@end
