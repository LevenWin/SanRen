//
//  NSObject+util.m
//  SevenNote
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "NSObject+util.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@implementation NSObject (util)
-(instancetype)inits{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
}
-(void)hideKeyboard{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

static char *attach;
-(void)setAttachObj:(id)attachObj{
    objc_setAssociatedObject(self, attach, attachObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)attachObj{
    if (!objc_getAssociatedObject(self, attach)) {
        self.attachObj=@"0";

    }else{
        return objc_getAssociatedObject(self, attach);
    }
    
    return objc_getAssociatedObject(self, attach);

}
-(void)eachDic:(void (^)(NSDictionary *))block{
    NSArray *arr=(id)self;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block) {
            block(obj);
        }
    }];
}
@end
