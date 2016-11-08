//
//  QXUIHelper.m
//  qixin
//
//  Created by fwp on 11/20/14.
//  Copyright (c) 2014 yiqihao. All rights reserved.
//

#import "MyUIHelper.h"

@implementation MyUIHelper
/*
 **默认黑色背景、黑色遮罩、菊花型等待条
 */
+(void)initSVProgress{
    [SVProgressHUD dismiss];
    [SVProgressHUD setRingThickness:10];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
}
+(void)setSVProgressMaskType:(SVProgressHUDMaskType)maskType{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD setDefaultMaskType:maskType];
    });
}
/*
 *只有等待条
 **/
+ (void)showLoader {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        [SVProgressHUD show];
    });
}
+ (void)showLoader:(BOOL)mask {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self initSVProgress];
        if(mask){
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        }
        [SVProgressHUD show];
    });
}
/*
 **等待条下加文字提示
 **/
+ (void)showStateMsg:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        [SVProgressHUD showWithStatus:msg];
    });
}
/*
 **等待条下加文字提示
 **/
+ (void)showStateMsg:(NSString *)msg mask:(BOOL)mask{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        if(mask){
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        }
        [SVProgressHUD showWithStatus:msg];
    });
}
/*
 **带感叹号的提示信息
 **/
+ (void)showInfoMsg:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];

        [SVProgressHUD showInfoWithStatus:msg];
    });
}
/*
 **带感叹号的提示信息
 **/
+ (void)showInfoMsg:(NSString *)msg mask:(BOOL)mask{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        if(mask){
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        }
        [SVProgressHUD showInfoWithStatus:msg];
    });
}
/*
 **进度条加文字
 **/
+ (void)showProgressWithInfo:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        [SVProgressHUD showProgress:0 status:title];
    });
    
}
+(void)updateProgress:(float)progress status:(NSString *)status{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showProgress:progress status:status];
    });
}
/*
 **进度条加文字
 **/
+ (void)showProgressWithInfo:(NSString *)title mask:(BOOL)mask{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        if(mask){
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        }
        [SVProgressHUD showProgress:0 status:title];
    });
    
}
+ (void)showSuccessMsg:(NSString *)successMsg{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        [SVProgressHUD showSuccessWithStatus:successMsg];
    });
}
+ (void)showSuccessMsg:(NSString *)successMsg mask:(BOOL)mask{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        if(mask){
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        }
        [SVProgressHUD showSuccessWithStatus:successMsg];
    });
}
+ (void)showErrorMsg:(NSString *)errorMsg{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        [SVProgressHUD showErrorWithStatus:errorMsg];
    });
    
}
+ (void)showErrorMsg:(NSString *)errorMsg mask:(BOOL)mask{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSVProgress];
        if(mask){
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        }
        [SVProgressHUD showErrorWithStatus:errorMsg];
    });
    
}
+ (void)dismissMsg{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
