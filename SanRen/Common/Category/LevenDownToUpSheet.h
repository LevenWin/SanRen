//
//  LevenDownToUpSheet.h
//  HJMJ
//
//  Created by Leven on 16/4/29.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LevenDownToUpSheet : UIView
@property (nonatomic,copy)void (^itemClick)(NSInteger index);
@property (nonatomic,retain)NSArray *titleArr;
@property (nonatomic,assign)NSInteger redIndex;
-(void)show;
-(void)dismiss;
@end
