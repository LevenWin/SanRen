//
//  VideoPlayView.h
//  SanRen
//
//  Created by 吴狄 on 16/11/1.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@interface VideoPlayView : UIView
@property (nonatomic,retain)VideoModel *model;
-(void)releaseWMPlayer;
-(void)prepareToDismiss;
@end
