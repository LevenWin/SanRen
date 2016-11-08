//
//  MessageModel.h
//  SanRen
//
//  Created by 吴狄 on 16/10/31.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"
#import "VideoModel.h"
@interface MessageModel : NSObject
@property (nonatomic,copy)     NSString *area;
@property (nonatomic,retain)   NSNumber *collectStatus;
@property (nonatomic,retain)   NSNumber *commentcount;
@property (nonatomic,retain)   NSNumber *commentlikestatues;
@property (nonatomic,retain)   NSNumber *commentstampstatues;
@property (nonatomic,retain)   NSDictionary *conmit;
@property (nonatomic,copy)     NSString *content;
@property (nonatomic,copy)     NSString *createTime;
@property (nonatomic,retain)   NSNumber *focus;
@property (nonatomic,retain)   NSNumber *follower;
@property (nonatomic,retain)   NSNumber *grade;
@property (nonatomic,copy)     NSString *image_uri;
@property (nonatomic,copy)     NSString *images;
@property (nonatomic,retain)   NSNumber *intransitcount;
@property (nonatomic,copy)     NSString *intro;
@property (nonatomic,copy)     NSString *latitude;
@property (nonatomic,copy)     NSString *longitude;
@property (nonatomic,copy)     NSString *messageId;
@property (nonatomic,copy)     NSString *messagetypes;
@property (nonatomic,copy)     NSString *nickname;
@property (nonatomic,retain)   NSNumber *popularity;
@property (nonatomic,retain)   NSNumber *reUser;
@property (nonatomic,copy)     NSString *school;
@property (nonatomic,retain)   NSNumber *sex;
@property (nonatomic,retain)   NSNumber *stampcount;
@property (nonatomic,retain)   NSNumber *status;
@property (nonatomic,copy)     NSString *sub_name;
@property (nonatomic,copy)     NSString *timeSlot;
@property (nonatomic,copy)     NSString *title;
@property (nonatomic,copy)     NSString *topic_id;
@property (nonatomic,retain)   NSNumber *types;
@property (nonatomic,copy)     NSString *university;
@property (nonatomic,copy)     NSString *userId;
@property (nonatomic,copy)     NSString *video;
@property (nonatomic,retain)   NSNumber *viewcounts;
@property (nonatomic,retain)   NSNumber *zannercount;

//自定义
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,assign)CGFloat contentImgHeight;

@property (nonatomic,assign)CGSize contentSize;
@property (nonatomic,assign)CGSize nicknameSize;
@property (nonatomic,assign)CGSize schoolSize;
@property (nonatomic,assign)CGSize topicSize;

@property (nonatomic,assign)CGRect contentRect;
@property (nonatomic,assign)CGRect nicknameRect;
@property (nonatomic,assign)CGRect schoolRect;
@property (nonatomic,assign)CGRect videoRect;
@property (nonatomic,assign)CGRect topicRect;

@property (nonatomic,retain)CommentModel* commonModel;
@property (nonatomic,retain)VideoModel* videoModel;

@property (nonatomic,retain)NSMutableArray* Thumb_ImagesArr;
@property (nonatomic,retain)NSMutableArray* High_ImagesArr;
@property (nonatomic,retain)NSMutableArray* imageRectArr;


@property (nonatomic,weak)UIViewController *vc;


-(instancetype)initWithDic:(NSDictionary*)userId;
@end
