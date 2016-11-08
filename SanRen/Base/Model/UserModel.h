//
//  UserModel.h
//  SanRen
//
//  Created by 吴狄 on 16/9/21.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
/*
 creattime = "2016-09-21 17:19:12";
 email = "";
 headImg = "";
 id = 19;
 job = "";
 name = "";
 nickname = "\U83dc\U9e1f";
 phone = 13554179785;
 qq = "";
 sex = 1;
 signature = "";
 skill = "";
 userId = 32fcf6a626992b8279a44e7675e5c397MTM1NTQx;
 wechat = "";

 */
@property (nonatomic,copy)NSString *creattime;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *headImg;
@property (nonatomic,copy)NSString *job;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *qq;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *signature;
@property (nonatomic,copy)NSString *skill;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *wechat;
@property (nonatomic,copy)NSString *phone;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
