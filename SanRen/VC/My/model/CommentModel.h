//
//  CommentModel.h
//  SanRen
//
//  Created by 吴狄 on 16/10/31.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic,copy)     NSString *comment;
@property (nonatomic,copy)     NSString *commentId;
@property (nonatomic,retain)   NSNumber *commentZanner;
@property (nonatomic,retain)   NSNumber *commentlikestatues;
@property (nonatomic,copy)     NSString *createTime;
@property (nonatomic,retain)   NSNumber *keyId;
@property (nonatomic,copy)     NSString *recomment;
@property (nonatomic,retain)   NSDictionary *reconmit;
@property (nonatomic,copy)     NSString *recreateTime;
@property (nonatomic,copy)     NSString *remImage;
@property (nonatomic,copy)     NSString *remUid;
@property (nonatomic,copy)     NSString *remUsername;
@property (nonatomic,copy)     NSString *remsex;
@property (nonatomic,retain)   NSNumber *restatues;
@property (nonatomic,copy)     NSString *reuImage;
@property (nonatomic,copy)     NSString *reuUid;
@property (nonatomic,copy)     NSString *reuUsername;
@property (nonatomic,retain)   NSNumber *reusex;
@property (nonatomic,retain)   NSNumber *statues;
@property (nonatomic,copy)     NSString *uImage;
@property (nonatomic,copy)     NSString *uUid;
@property (nonatomic,copy)     NSString *uUsername;
@property (nonatomic,retain)   NSNumber *usex;


@property (nonatomic,assign)CGRect contentRect;
@property (nonatomic,assign)CGRect nicknameRect;
@property (nonatomic,assign)CGRect timeRect;
@property (nonatomic,assign)CGRect avatorRect;
@property (nonatomic,assign)CGRect zanRect;

@property (nonatomic,assign)CGFloat containerHeight;

-(instancetype)initWithDic:(NSDictionary*)dic;

@end
