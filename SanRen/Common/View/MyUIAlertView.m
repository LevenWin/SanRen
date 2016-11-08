//
//  MyUIAlertView.m
//  SmartSchool
//
//  Created by 吴狄 on 16/7/28.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "MyUIAlertView.h"
@interface MyUIAlertView()<UIAlertViewDelegate>{
}
@property (nonatomic,copy)alertBlock alertAction;

@end
@implementation MyUIAlertView

+(instancetype)shareInstance{
    static MyUIAlertView *alert=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alert=[[MyUIAlertView alloc]init];
    });
    return alert;
}
+(void)showWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString*)cancelTitle  otherBtnTitle:(NSString *)otherTitle actionBlock:(alertBlock)block{
    MyUIAlertView * alert=[[MyUIAlertView alloc]initWithTitle:title message:message delegate:[MyUIAlertView shareInstance] cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [alert show];
    
    [MyUIAlertView shareInstance].alertAction=block;

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        if ([MyUIAlertView shareInstance].alertAction) {
            [MyUIAlertView shareInstance].alertAction();
        }
    }
}
@end
