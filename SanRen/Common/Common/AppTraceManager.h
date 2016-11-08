//
//  AppTraceManager.h
//  SmartSchool
//
//  Created by 吴狄 on 16/7/21.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "UserModel.h"
typedef enum : NSInteger {
    IsOnlLine = 0,
    IsOffLine,
    
} UserStatus;
@interface AppTraceManager : NSObject
@property (nonatomic,retain)UIViewController *topViewController;
@property (nonatomic,retain)UIViewController *rootViewController;
@property (nonatomic,retain)UserModel *userModel;
@property (nonatomic,weak)UIWindow *window;
@property (assign, nonatomic) NetworkStatus currentNetStatus;
@property (assign, nonatomic) UserStatus currentUserStatus;

@property (assign, nonatomic) BOOL isBackground;
@property (assign, nonatomic) BOOL hasSchoolStation;



+(instancetype)shareInstance;
+(void)getToWork;
+(void)saveUserInfor:(NSDictionary*)dic;
+(void)logout;

@end
