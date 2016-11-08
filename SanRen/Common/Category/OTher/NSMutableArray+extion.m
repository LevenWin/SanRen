//
//  NSMutableArray+extion.m
//  SmartSchool
//
//  Created by 吴狄 on 16/8/15.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "NSMutableArray+extion.h"
#import <Foundation/NSObject.h>
#import <objc/runtime.h>
@implementation NSMutableArray (extion)
+(void)load{
    
    
    // 获取imageName:方法的地址
    Method imageNameMethod = class_getClassMethod(self, @selector(addObject:));
    
    // 获取wg_imageWithName:方法的地址
    Method wg_imageWithNameMethod = class_getClassMethod(self, @selector(safty_addObject:));
    
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(imageNameMethod, wg_imageWithNameMethod);

}
-(void)safty_addObject:(id)object{
    if (object&&![object isKindOfClass:[NSNull class]]) {
        [self safty_addObject:object];
    }else{
        NSLog(@" add  nil  obj");
        [self safty_addObject:@"null"];
    }
}
@end
