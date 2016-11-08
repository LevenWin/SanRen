//
//  VideoModel.h
//  SanRen
//
//  Created by 吴狄 on 16/11/1.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMPlayer.h"
typedef NS_OPTIONS(NSUInteger, PlayState) {
    PLAY = 1,
    PAUSE = 2,
    STOP=3
};
@interface VideoModel : NSObject
@property(nonatomic,copy)NSString *videoUrl;
@property (nonatomic,copy)NSString *coverImage;
@property(nonatomic,assign)double seekTime;
@property(nonatomic,weak)UIViewController *vc;
@property(nonatomic,weak)UIView *superView;
@property(nonatomic,assign)WMPlayerState state;



@end
