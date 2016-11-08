//
//  CommonFuncation.m
//  SmartSchool
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "CommonFuncation.h"
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
@implementation CommonFuncation
+(void)browsImgs:(NSMutableArray *)imgs positions:(NSMutableArray*)positions selectIndex:(NSInteger)index superView:(UIView *)view vc:(UIViewController *)vc{
    
}
+(void)makeRefrshSound{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"Sound"] isEqualToString:@"YES"]) {
        SystemSoundID myAlertSound;
        NSURL *url = [NSURL URLWithString:@"/System/Library/Audio/UISounds/ReceivedMessage.caf"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &myAlertSound);
        AudioServicesPlaySystemSound(myAlertSound);

    }
}
+(BOOL)imgHasCache:(NSString*)url{
    SDWebImageManager* manager = [SDWebImageManager sharedManager];
    BOOL isImageCached = [manager cachedImageExistsForURL:[NSURL URLWithString:url]];
    return isImageCached;

}
+(void)copyTextClipboard:(NSString *)text{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (text) {
        pasteboard.string = text;
        [MyUIHelper showSuccessMsg:@"已复制至剪切板!"];
    }
   
    
    
}
@end
