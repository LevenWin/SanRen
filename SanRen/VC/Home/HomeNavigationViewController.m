//
//  HomeNavigationViewController.m
//  SanRen
//
//  Created by 吴狄 on 16/9/21.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "HomeNavigationViewController.h"

@interface HomeNavigationViewController ()

@end

@implementation HomeNavigationViewController
#pragma  mark --LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark--UI
-(void)initUI{
    self.navigationBar.tintColor=[UIColor whiteColor];
   }
#pragma mark --Data
-(void)loadData{
    
}
#pragma mark --Action
-(UIViewController *)
popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.interactivePopGestureRecognizer.enabled=NO;
    [super pushViewController:viewController animated:animated];
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled=YES;
    }

}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self.childViewControllers count]==1) {
        return NO;
    }
    return YES;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}
#pragma mark --Delegate

#pragma mark --Other

@end
