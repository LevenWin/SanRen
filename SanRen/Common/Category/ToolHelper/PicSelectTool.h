//
//  PicSelectTool.h
//  SmartSchool
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PicSelectTool : NSObject
+(instancetype)shareInstance;
-(void)selectImgForCameraWithVC:(UIViewController *)vc getImg:(void (^)(UIImage *)) imageBlock;
-(void)selectImgForAlbumWithVC:(UIViewController *)vc getImg:(void (^)(UIImage *)) imageBlock;
@end
