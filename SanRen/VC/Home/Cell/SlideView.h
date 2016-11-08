//
//  SlideView.h
//  SanRen
//
//  Created by 吴狄 on 16/11/1.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideView : UIView
@property (nonatomic,assign)CGFloat currentPrecent;
@property (nonatomic,copy)void(^seekDidChange)(CGFloat precent);
@end
