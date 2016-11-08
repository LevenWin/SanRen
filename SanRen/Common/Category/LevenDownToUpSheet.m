//
//  LevenDownToUpSheet.m
//  HJMJ
//
//  Created by Leven on 16/4/29.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "LevenDownToUpSheet.h"
#import "UIView+draw.h"
#import "UIView+GaosutongExtension.h"
@interface LevenDownToUpCell:UITableViewCell
@property (nonatomic,retain)UIView *bgView;
@property (nonatomic,copy)NSString *itemTitle;
@property (nonatomic,retain)UILabel *itemLab;

@end
@implementation LevenDownToUpCell
-(void)drawRect:(CGRect)rect{
    [self setup];
}
-(void)setItemTitle:(NSString *)itemTitle{
    _itemTitle=itemTitle;
    [self setup];
}
-(void)setup{
    
    if (!_bgView) {
        _bgView=[[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:_bgView];
        _bgView.backgroundColor=self.backgroundColor;

    }
    if (!_itemLab) {
        _itemLab=[[UILabel alloc]initWithFrame:self.bounds];
        _itemLab.textColor=[UIColor colorWithWhite:0.301 alpha:1.000];
        _itemLab.textAlignment=NSTextAlignmentCenter;
        _itemLab.font=[UIFont systemFontOfSize:18];
        [_bgView addSubview:_itemLab];
        [_bgView addBottomLine];
    }
    
    _itemLab.text=self.itemTitle;
}

@end

@interface LevenDownToUpSheet()<UITableViewDelegate,UITableViewDataSource>{
    UIView *bgView;
    UITableView *tbv;
    CGFloat tbvHeight;
    BOOL isShow;
}
@end
@implementation LevenDownToUpSheet
-(instancetype)init{
    if ((self=[super init])) {
        self.redIndex=1000;

    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ((self=[super initWithFrame:frame])) {
        self.redIndex=1000;
    }
    return self;
}
-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr=titleArr;
    [self setup];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    tbvHeight=44*self.titleArr.count+48;
    tbv.frame=CGRectMake(0, 0, UISCREEN_WIDTH, tbvHeight);
    NSLog(@"222");
}
-(void)setup{
    if (!bgView) {
        bgView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.3;
    }
    __Block(blockself);
    [bgView setTapAction:^(UITapGestureRecognizer *tap) {
        [blockself dismiss];
    }];
    UIWindow *keywindow=[[UIApplication sharedApplication].delegate window];
    [keywindow addSubview:bgView];
    
    if (!tbv) {
        tbv=[[UITableView alloc]initWithFrame:CGRectZero];
        tbv.delegate=self;
        tbv.dataSource=self;
        tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        [tbv registerClass:[LevenDownToUpCell class] forCellReuseIdentifier:@"cell1"];
        tbv.scrollEnabled=NO;
    }
    
    [keywindow addSubview:tbv];
    
    [bgView setSwipeDownAction:^(UISwipeGestureRecognizer *swipe) {
        [blockself dismiss];
    }];
}
-(void)show{
    

    if (isShow) {
        return;
    }
    tbvHeight=44*self.titleArr.count+48;
    tbv.frame=CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, tbvHeight);
    
    isShow=YES;
    bgView.alpha=0;
    tbv.top_gst=UISCREEN_HEIGHT;
    [UIView animateWithDuration:0.3 animations:^{
        bgView.alpha=0.3;
        tbv.top_gst=UISCREEN_HEIGHT-tbvHeight;
    }];
    
}
-(void)dismiss{
   
    if (!isShow) {
        return;
    }
    tbvHeight=44*self.titleArr.count+48;
    tbv.frame=CGRectMake(0, UISCREEN_HEIGHT-tbvHeight, UISCREEN_WIDTH, tbvHeight);

    isShow=NO;
    bgView.alpha=0.3;
    tbv.top_gst=UISCREEN_HEIGHT-tbvHeight;
    [UIView animateWithDuration:0.3 animations:^{
        bgView.alpha=0;
        tbv.top_gst=UISCREEN_HEIGHT;
    }completion:^(BOOL finished) {
        [tbv removeFromSuperview];
        [bgView removeFromSuperview];
    }];

}
#pragma  Tbv
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 48)];
    bg.backgroundColor=[UIColor colorWithWhite:0.909 alpha:1.000];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 4, UISCREEN_WIDTH, 44)];
    lab.text=@"取消";
    lab.backgroundColor=[UIColor whiteColor];
    lab.textColor=[UIColor colorWithWhite:0.301 alpha:1.000];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:18];
    [bg addSubview:lab];
    [lab setTapAction:^(UITapGestureRecognizer *tap) {
        [self dismiss];
    }];
    
    return bg;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 48;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LevenDownToUpCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.itemTitle=self.titleArr[indexPath.row];
    if (indexPath.row==self.redIndex) {
        cell.itemLab.textColor=[UIColor colorWithRed:1.0 green:0.3289 blue:0.0353 alpha:1.0];
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LevenDownToUpCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.bgView.backgroundColor=[UIColor colorWithWhite:0.940 alpha:1.000];
    if (self.itemClick) {
        NSLog(@"点击了%@",cell.itemTitle);
        self.itemClick(indexPath.row);
    }
    [self dismiss];

}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    LevenDownToUpCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.bgView.backgroundColor=cell.backgroundColor;
   
}
@end
