//
//  CustomTabBar.h
//  SanRen
//
//  Created by 吴狄 on 16/10/25.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RoundButtonDelegate <NSObject>

- (void)RoundButtonClicked;

@end
@interface CustomTabBar : UITabBar
@property (nonatomic, weak) id <RoundButtonDelegate>myDelegate;

@property (nonatomic, strong)UIButton *roundButton;
@end
