//
//  DrawTableView.m
//  DrawCellTest
//
//  Created by 吴狄 on 16/10/18.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "DrawTableView.h"

@implementation DrawTableView
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"tbv begin");
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"tbv cancel");
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"tbv end");
}
@end
