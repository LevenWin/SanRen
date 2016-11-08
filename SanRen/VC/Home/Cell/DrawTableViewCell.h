//
//  DrawTableViewCell.h
//  DrawCellTest
//
//  Created by 吴狄 on 16/10/18.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+Additions.h"
#import "UIImage+Filter.h"
#import "MessageModel.h"
#import "UIView+frameAdjust.h"
@interface DrawTableViewCell : UITableViewCell
@property (nonatomic,copy)NSString *content;
@property (nonatomic,retain)NSDictionary *dataDic;
@property (nonatomic,retain)MessageModel *model;

@property (nonatomic,weak)UIViewController *vc;
-(void)clearLayer;
-(void)drawCell;
@end
