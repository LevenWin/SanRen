//
//  CollectImgModel.h
//  SmartSchool
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectImgModel : NSObject
@property (nonatomic,retain)NSMutableArray *positionArr;
@property (nonatomic,assign)NSInteger selectIndex;
/*
 url
 */
@property (nonatomic,retain)NSMutableArray*thumbImgArr;

@property (nonatomic,retain)NSMutableArray*imgArr;
@property (nonatomic,retain)UIView *superView;


@end
