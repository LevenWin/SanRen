//
//  AppTraceManager.m
//  SmartSchool
//
//  Created by 吴狄 on 16/7/21.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "AppTraceManager.h"
#import "AppDelegate.h"
#import "MyUIAlertView.h"
#import "HomeNavigationViewController.h"
@interface AppTraceManager(){
    
}
@property (strong, nonatomic) Reachability *hostReach;

@end
@implementation AppTraceManager
+(void)getToWork{
    [AppTraceManager shareInstance];

}
+(instancetype)shareInstance{
    static AppTraceManager*manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[AppTraceManager alloc]init];
        [manager registNetObserver];
        [manager initApp];
    });
    return manager;
}
-(void)initApp{
//    if (GetUserDefaults(@"hasLogin")&&[GetUserDefaults(@"hasLogin") boolValue]) {
        self.currentUserStatus=IsOnlLine;
        
        UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] ;
        
//        HomeNavigationViewController *navi=[storyBoard instantiateViewControllerWithIdentifier:@"HomeNavigationViewController"];
    UITabBarController *tabbarController=[storyBoard instantiateInitialViewController];
    
    tabbarController.tabBar.tintColor = [UIColor darkGrayColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.6131 green:0.6131 blue:0.6131 alpha:1.0],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateNormal];
    //字体大小，颜色（被选中时）
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateSelected];
        
    tabbarController.tabBar.translucent=NO;
    self.rootViewController=tabbarController;
//
//    }else{
//        self.currentUserStatus=IsOffLine;
//
//         UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] ;
//        self.rootViewController=[storyBoard instantiateViewControllerWithIdentifier:@"LoginNavigationViewController"];
//
//
//    }
}

-(void)registNetObserver{
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.hostReach startNotifier];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
}
-(UIWindow*)window{
    AppDelegate *dele=(AppDelegate *)[UIApplication sharedApplication].delegate;
    return dele.window;
}
-(UIViewController *)topViewController{
    UITabBarController *tab= (UITabBarController*)[[UIApplication sharedApplication].delegate window].rootViewController;
    UINavigationController *navi= tab.selectedViewController;
    return navi.topViewController;

  
}

+(void)saveUserInfor:(NSDictionary*)dic{
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        SetUserDefaults(key, obj);
    }];
    
}
+(void)logout{
        [MyUIAlertView showWithTitle:@"温馨提示" message:@"是否确定退出？" cancelTitle:@"取消" otherBtnTitle:@"确定" actionBlock:^{
            UINavigationController *navi=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationViewController"];
            [[AppTraceManager shareInstance].topViewController presentViewController:navi animated:YES completion:^{
                [AppTraceManager shareInstance].window.rootViewController=navi;
                [AppTraceManager clearUserData];
            }];
            
            
        }];
}
+(void)clearUserData{
    [NSUserDefaults resetStandardUserDefaults];
}
#pragma mark Net
#pragma mark - 网络变化
- (void) reachabilityChanged: (NSNotification* )noti {
    Reachability *reachability = [noti object];
    if ([reachability isKindOfClass:[Reachability class]]) {
        [self updateInterfaceWithReachability:reachability];
    }
}
- (void) updateInterfaceWithReachability: (Reachability*) reachability {
    NetworkStatus status = [reachability currentReachabilityStatus];
    NSString *string = @"HasNetwork";
    if (status == NotReachable) {
        string = @"HasNoNetwork";
        NSLog(@"没有网络");
    }
    self.currentNetStatus=status;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NetworkChange" object:string];
}

@end
