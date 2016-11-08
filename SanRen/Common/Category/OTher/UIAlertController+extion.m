//
//  UIAlertController+extion.m
//  SmartSchool
//
//  Created by 吴狄 on 16/8/29.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "UIAlertController+extion.h"

@interface UIAlertController()
@property (nonatomic,retain)UIAlertController *alert;

@end
typedef void (^ActionBlock)(UIAlertAction *);

@implementation UIAlertController (extion)
+(void)showInVC:(UIViewController*)vc style:(UIAlertControllerStyle)style title:(NSString *)title messages:(NSString *)message items:(NSArray *)items clickIndex:(void (^)(NSInteger))clickBlock{
    if (items.count==0) {
        return;
    }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    
    for (NSString *text in items) {
        UIAlertAction *action=[UIAlertAction actionWithTitle:text style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSInteger index= [items indexOfObject:action.title];
            if (clickBlock) {
                clickBlock(index);
            }
            
        }];
        [alert addAction:action];
    
    }
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [vc presentViewController:alert animated:YES completion:nil];
    
}

@end
