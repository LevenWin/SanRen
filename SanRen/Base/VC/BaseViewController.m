//
//  BaseViewController.m
//  SanRen
//
//  Created by 吴狄 on 16/9/20.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

#pragma  mark --LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"2   %@",self);

    [self initSuperUI];
}
#pragma mark--UI
-(void)initSuperUI{
    [self.view setTapAction:^(UITapGestureRecognizer *tap) {
        [tap.view hideKeyboard];
    }];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:Image(@"cm2_topbar_icn_back") forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(8, -5, 8, 20)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate=self;
        self.navigationController.interactivePopGestureRecognizer.enabled=YES;
        
    }
    
}
#pragma mark --Data
-(void)loadData{
    
}
#pragma mark --Action
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --Delegate

#pragma mark --Other
-(void)didReceiveMemoryWarning{
    NSLog(@"memory notice");
}
@end
