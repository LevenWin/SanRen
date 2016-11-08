//
//  UITableView+leven.h
//  HJMJ
//
//  Created by Leven on 16/4/29.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (leven)
-(UITableView *(^)(CGRect frame))setFrame;
-(UITableView *(^)(NSDictionary *dic))setReusedCell;
-(UITableView *(^)(UITableViewCellSeparatorStyle style))setCellSepartStyle;
-(UITableView *(^)(UIView*header))setHeaderView;
-(UITableView *(^)(UIView*footer))setFooterView;


-(void)setTbvWithFrame:(CGRect)frame WithResusedString:(NSArray*)cellNames;


@end
