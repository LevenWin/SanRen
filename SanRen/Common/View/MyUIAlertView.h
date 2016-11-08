//
//  MyUIAlertView.h
//  SmartSchool
//
//  Created by 吴狄 on 16/7/28.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^alertBlock)();
@interface MyUIAlertView : UIAlertView
+(void)showWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString*)cancelTitle  otherBtnTitle:(NSString *)otherTitle actionBlock:(alertBlock)block;

@end
