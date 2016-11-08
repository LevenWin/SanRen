//
//  HeaderTabView.m
//  SanRen
//
//  Created by 吴狄 on 16/10/7.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "HeaderTabView.h"

@implementation HeaderTabView
-(void)awakeFromNib{
    [self.workYear addleftLine];
  
    [self.workYear addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.job addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    
}
-(void)click:(UIButton *)btn{
    if (btn.tag==0) {
        self.job.selected=!self.job.selected;
        self.workYear.selected=NO;
    }else{
        self.workYear.selected=!self.workYear.selected;
        self.job.selected=NO;
    }
    
    if (self.itemSelect) {
        self.itemSelect(btn.tag);
    }
}
@end
