//
//  LoginViewController.m
//  SanRen
//
//  Created by 吴狄 on 16/9/20.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "HomeNavigationViewController.h"
#define LAYER_COLOR [UIColor colorWithRed:0.9774 green:0.9774 blue:0.9774 alpha:1.0]

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scr;
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;
@property (strong, nonatomic) IBOutlet UIView *phoneV;
@property (strong, nonatomic) IBOutlet UIView *passwordV;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UIButton *loginLab;
@property (strong, nonatomic) IBOutlet UIButton *forgetPassword;
@property (strong, nonatomic) IBOutlet UIButton *registerLab;

@end

@implementation LoginViewController

#pragma  mark --LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
-(void)viewDidLayoutSubviews{
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.scr];
    
}
#pragma mark--UI
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)initUI{

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.automaticallyAdjustsScrollViewInsets=NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image=[self.bgImg.image boxblurImageWithBlur:0.8];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.bgImg setImgWithFadeAnimationUIImage:image inteval:1
                 ];
            });
        }
    });
    
    self.scr.keyboardDismissMode=UIScrollViewKeyboardDismissModeInteractive;
    self.scr.contentSize=CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT-60);
    
    self.scr.alwaysBounceHorizontal=NO;
}
-(void)otherStyle{
    [self.bgImg addBlurEffect:UIBlurEffectStyleDark alpha:1];
    self.phoneV.drawRadius=@"25";
    self.phoneV.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0];
    self.phoneV.layer.borderColor=LAYER_COLOR.CGColor;
    self.phoneTF.backgroundColor=[UIColor clearColor];
     self.phoneV.layer.borderWidth=1;
    self.phoneTF.tintColor=[UIColor whiteColor];
    self.phoneTF.textColor=[UIColor whiteColor];
    
    self.passwordV.drawRadius=@"25";
    self.passwordV.backgroundColor=[UIColor clearColor] ;
    self.passwordTF.backgroundColor=[UIColor clearColor] ;
    self.passwordV.layer.borderColor=LAYER_COLOR.CGColor;
    self.passwordV.layer.borderWidth=1;
    self.passwordTF.rightView.tintColor=[UIColor whiteColor];
    self.loginLab.drawRadius=@"22";
}
#pragma mark --Data
-(void)loadData{
    
}
#pragma mark --Action
- (IBAction)login:(id)sender {
    if (self.phoneTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号!"];
        return;

    }
    if (self.passwordTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
        return;
        
    }

    
    [SVProgressHUD showWithStatus:@"正在登录..."];
    
    [BaseRequest netRequestPOSTWithRequestURL:Url(@"user/login") WithParameter:@{@"password":[self.passwordTF.text md5],@"phone":self.phoneTF.text} WithSuccessBlock:^(id obj) {
        if ([obj[@"status"] integerValue]==1) {
            [SVProgressHUD dismiss];
            
            
           UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] ;
            
//            HomeNavigationViewController *navi=[storyBoard instantiateViewControllerWithIdentifier:@"HomeNavigationViewController"];
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
            
            img.image=[UIImage getScreenImg];
            [[AppTraceManager shareInstance].window addSubview:img];
           
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    img.alpha=0;
                }completion:^(BOOL finished) {
                    [img removeFromSuperview];
                }];
            });
            
            [self presentViewController:[storyBoard instantiateInitialViewController] animated:YES completion:^{
                UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] ;
                
                //        HomeNavigationViewController *navi=[storyBoard instantiateViewControllerWithIdentifier:@"HomeNavigationViewController"];
                UITabBarController *tabbarController=[storyBoard instantiateInitialViewController];
                
                tabbarController.tabBar.tintColor = [UIColor darkGrayColor];
                [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.6131 green:0.6131 blue:0.6131 alpha:1.0],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateNormal];
                //字体大小，颜色（被选中时）
                [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateSelected];
                
               
                [AppTraceManager shareInstance].window.rootViewController=tabbarController;
                SetUserDefaults(@"hasLogin", @"1");
            }];
            [AppTraceManager saveUserInfor:obj[@"data"]];
            UserModel *model=[[UserModel alloc]initWithDic:obj[@"data"]];
            [AppTraceManager shareInstance].userModel=model;
        }else{
            
            [SVProgressHUD showErrorWithStatus:obj[@"message"]];

            
        }
        
    } WithErrorBlock:^(id obj) {
        NSLog(@"%@",obj);
    } WithFailureBlock:^(id obj) {
        NSLog(@"%@",obj);

    }];
    
    
}
- (IBAction)register:(id)sender {
}
- (IBAction)findPassword:(id)sender {
}

#pragma mark --Delegate

#pragma mark --Other

@end
