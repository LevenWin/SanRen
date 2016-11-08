//
//  CommentLayer.h
//  SanRen
//
//  Created by 吴狄 on 16/10/31.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CommentModel.h"
@interface CommentLayer : CALayer
@property (nonatomic,retain)CommentModel *model;
-(void)touchEnd:(CGPoint)point beginPoint:(CGPoint)beginPoint;
-(void)clearLayer;
@end
