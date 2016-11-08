//
//  RegisterViewController.m
//  SanRen
//
//  Created by 吴狄 on 16/9/21.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *confirmPWTF;
@property (strong, nonatomic) IBOutlet UILabel *code;
@property (strong, nonatomic) IBOutlet UIScrollView *scr;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;


@end

@implementation RegisterViewController

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
#pragma mark--UI
-(void)initUI{
    self.scr.contentSize=CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT-63);
    self.scr.alwaysBounceHorizontal=NO;
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerAction:)];
    self.navigationItem.rightBarButtonItem=right;
    self.title=@"注册";

    
}
#pragma mark --Data
-(void)loadData{
    
}
#pragma mark --Action
- (IBAction)registerAction:(id)sender {
    [self hideKeyboard];
    if(self.phoneTF.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码!"];
        return;
    }
    
//    if(self.codeTF.text.length==0){
//        [SVProgressHUD showErrorWithStatus:@"请输入手机验证码!"];
//        return;
//    }
    
    if(self.passwordTF.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if(self.confirmPWTF.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"请确认密码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在注册..."];

    [BaseRequest netRequestPOSTWithRequestURL:Url(@"user/register") WithParameter:@{@"phone":self.phoneTF.text,@"password":[self.passwordTF.text md5]} WithSuccessBlock:^(id obj) {
        NSLog(@"%@",obj);

        if([obj[@"status"] boolValue]){
            
            [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:obj[@"message"]];

        }
        
    } WithErrorBlock:^(id obj) {
        NSLog(@"%@",obj);
        [SVProgressHUD showErrorWithStatus:@"注册失败！"];

    } WithFailureBlock:^(id obj) {
         NSLog(@"%@",obj);
        [SVProgressHUD showErrorWithStatus:@"注册失败！"];

    }];
}

#pragma mark --Delegate

#pragma mark --Other
@end
