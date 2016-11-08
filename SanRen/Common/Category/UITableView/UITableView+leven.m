//
//  UITableView+leven.m
//  HJMJ
//
//  Created by Leven on 16/4/29.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "UITableView+leven.h"

@implementation UITableView (leven)

+(void)load{
   
}
-(UITableView *(^)(CGRect frame))setFrame{
    return ^(CGRect frame){
        self.frame=frame;
        return self;
    };
}
-(UITableView *(^)(NSDictionary *dic))setReusedCell{
    return ^(NSDictionary *dic){
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self registerNib:[UINib nibWithNibName:obj bundle:[NSBundle mainBundle]] forCellReuseIdentifier:key];
        
        }];
        
        
        return self;
    };
}
-(UITableView *(^)(UITableViewCellSeparatorStyle style))setCellSepartStyle{
    return ^(UITableViewCellSeparatorStyle style){
        self.separatorStyle=style;
        return self;
    };
}
-(UITableView *(^)(UIView*header))setHeaderView{
    return ^(UIView *header){
        self.tableHeaderView=header;
        return self;
    };
}
-(UITableView *(^)(UIView*footer))setFooterView{
    return ^(UIView *footer){
        self.tableFooterView=footer;
        return self;
    };
}
-(void)setTbvWithFrame:(CGRect)frame WithResusedString:(NSArray*)cellNames{
   
}
@end
