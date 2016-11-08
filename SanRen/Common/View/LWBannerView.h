//
//  LWBannerView.h
//  LWBanner
//
//  Created by 吴狄 on 16/9/13.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWBannerView : UIView
@property (nonatomic,retain)NSMutableArray *itmeArr;
@property (nonatomic,retain)UIPageControl *pageContro;
@property (nonatomic,copy)void (^itemSelect)(NSInteger index,id obj);
@end
