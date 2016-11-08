//
//  CommonFuncation.h
//  SmartSchool
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFuncation : NSObject
///浏览图片
//+(void)browsImgs:(NSMutableArray *)imgs positions:(NSMutableArray*)positions selectIndex:(NSInteger)index superView:(UIView *)view vc:(UIViewController *)vc;
+(void)makeRefrshSound;
+(BOOL)imgHasCache:(NSString*)url;
+(void)copyTextClipboard:(NSString *)text;
@end
