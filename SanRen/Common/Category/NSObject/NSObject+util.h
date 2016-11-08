//
//  NSObject+util.h
//  SevenNote
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (util)
@property (nonatomic,retain)id attachObj;
-(instancetype)inits;
-(void)hideKeyboard;
-(void)eachDic:(void(^)(NSDictionary *)) block;
@end
