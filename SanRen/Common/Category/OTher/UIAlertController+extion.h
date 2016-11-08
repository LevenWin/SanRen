//
//  UIAlertController+extion.h
//  SmartSchool
//
//  Created by 吴狄 on 16/8/29.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIAlertController (extion)

+(void)showInVC:(UIViewController*)vc style:(UIAlertControllerStyle)style title:(NSString*)title messages:(NSString *)message items:(NSArray*)items clickIndex:(void(^)(NSInteger index)) clickBlock;
@end
