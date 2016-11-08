//
//  CFuncationHelper.h
//  SmartSchool
//
//  Created by 吴狄 on 16/8/8.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark NSString

FOUNDATION_EXPORT NSString *NSStringFromeObj(id obj);
FOUNDATION_EXPORT NSString *NSStringFromeFloat(CGFloat num);
FOUNDATION_EXPORT NSString *NSStringFromeInt(NSInteger num);

#pragma mark    iOS
FOUNDATION_EXPORT id GetUserDefaults(NSString *key);
FOUNDATION_EXPORT void SetUserDefaults(NSString *key,id obj);

FOUNDATION_EXPORT  id GetSingleInstance(Class Name);

FOUNDATION_EXPORT  void PostNotice(NSString* Name ,id obj);

FOUNDATION_EXPORT BOOL ImgHasCache(NSString*url);
@interface CFuncationHelper : NSObject

@end
