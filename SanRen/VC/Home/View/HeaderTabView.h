//
//  HeaderTabView.h
//  SanRen
//
//  Created by 吴狄 on 16/10/7.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTabView : UIView
@property (strong, nonatomic) IBOutlet UIButton *workYear;
@property (strong, nonatomic) IBOutlet UIButton *job;
@property (nonatomic,copy)void (^itemSelect)(NSInteger tag);
@end
