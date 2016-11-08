//
//  FollowLab.h
//  FollowBtn
//
//  Created by 吴狄 on 16/8/9.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowLab : UILabel
@property (nonatomic,copy)void (^followBlock)(BOOL);
@property (nonatomic,assign)BOOL hasFollowed;
@end
