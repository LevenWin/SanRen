//
//  TwoTabCell.h
//  SanRen
//
//  Created by 吴狄 on 16/10/7.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoTabCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *tabTwo;

@property (strong, nonatomic) IBOutlet UIButton *tabOne;
@property (nonatomic,copy)void(^clickAction)(NSInteger tag);
@end
