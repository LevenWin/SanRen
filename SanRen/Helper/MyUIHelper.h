//
//  MyUIHelper.h
//  PaoPaoYou
//
//  Created by 吴狄 on 15/11/17.
//  Copyright © 2015年 MYMAC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImage+Extension.h"
#import "SVProgressHUD.h"

//#define RONGCLOUD_IM_APPKEY @"3argexb6r9noe"      // 开发请换成您的appkey
#define BUGTAGSAPPKEY @"5dbfee4768edc510f2b6cca9adf64bc9" //bugtags

#define RONGCLOUD_IM_APPKEY @"tdrvipksr9r05"//@"ik1qhw091edtp"        // 发布请换成您的appkey
#define YouMengAppKey @"5763c78fe0f55a90410027a2"   // 苹果专用key

#define QQAPPID     @"1105334468"
#define QQAPPKEY    @"oMaCCtElGoi6RW42"

#define  WeiXinAppID @"wxff423a104f495d58"
#define  WeiXinAppSecret @"bdb299ad97723beb3a737a30326577d0"

#define  WeiBoAppID @"63038286"
#define  WeiBoAppSecret @"be383f088e2c219bbec51a7a970604d6"


#define APP_Delegate                                            (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define SCREEN_WIDTH                                            CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT                                           CGRectGetHeight([[UIScreen mainScreen] bounds])
#define NIB(X)                                                  [[[NSBundle mainBundle] loadNibNamed:X owner:self options:nil] objectAtIndex:0]
#define UINIB(X)                                                [UINib nibWithNibName:X bundle:nil]
#define UISTORYBOARD(X)                                         [UIStoryboard storyboardWithName:X bundle:nil]

#define IMAGE(X)                                                [UIImage imageNamed:X]
#define FONT(X)                                                 [UIFont systemFontOfSize:X]
#define BFONT(X)                                                [UIFont boldSystemFontOfSize:X]
#define COLOR(R, G, B, A)                                       [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define FilePath(fileName)                                      [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName]

#define HeadImagePath                                           FilePath(@"userImage.jpg")  // 头像缓存路径
#define TempHeadImagePath                                           FilePath(@"TempUserImage.jpg")  // 头像缓存路径

//#define FocusPingTaiName    @"关注"
#define FocusPingTaiName    @"关注"
#define ReportPingTaiName   @"举报"

#define FontOrange  COLOR(255, 150, 0, 1.0f)     // 字体橙
#define FontGrey   COLOR(167,167,167,1.0f)       // 字体灰
#define FontBlue   COLOR(0,122,255,1.0f)         // 字体蓝
#define BackGrey   COLOR(239,239,239,1.0f)       // 背景灰
#define FontDeepGreen  COLOR(8, 210, 166, 1.0f)      // 深绿色
#define CellLineColor       COLOR(239, 239, 239, 1.0)       // cell边框灰色
#define BtnGray      COLOR(203, 203, 203, 1.0)  // 常规灰色
#define kNoneBGColor        [UIColor clearColor]            // 无色

#define BtnBlue     COLOR(58, 169, 255, 1.0f)   // 背景蓝色

#define SysUserId       @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjF9.zrfBF6A6crEl1VyFAGPaVWNktvMAE-8pqO1sp95R7N0"
#define BtnBackImge     @"Back_Arrow"                       // 系统默认返回图片
#define BtnLongSize     CGRectMake(0, 0, 60.0f, 40.0f)      // 4字--导航栏按钮常规尺寸
#define BtnNomalSize    CGRectMake(0, 0, 40.0f, 40.0f)      // 2字--导航栏按钮常规尺寸
#define BtnRightNomalSize    CGRectMake(SCREEN_WIDTH - 40.0f, 24.0f, 40.0f, 40.0f)      // 2字--导航栏右边按钮常规尺寸
#define BtnRightLongSize    CGRectMake(SCREEN_WIDTH - 60.0f, 24.0f, 60.0f, 40.0f)      // 2字--导航栏右边按钮常规尺寸
#define kNavHeight                                               64
#define kTabHeight                                               58

#define MaxRowNum           1000           // 留言最大展示条数
#define MaxTextViewRow         5           // 留言评论，文本框最大行数值

#define ROWS                @"20"          // 分页值

#define ChargeHistory       @"1"           // 充值记录
#define TakeMoneyHistory    @"2"           // 提现记录
#define ReleaseTask         @"3"           // 发布任务
#define FinsishTask         @"4"           // 完成任务
#define BackMoney           @"5"           // 退款
#define JoinBussiness       @"6"           // 参与商家活动

#define RegeistId            @"10000"       // 注册事件ID

@interface MyUIHelper : NSObject

+ (void)setSVProgressMaskType:(SVProgressHUDMaskType)maskType;
+ (void)showLoader;
+ (void)showStateMsg:(NSString *)msg;
+ (void)showInfoMsg:(NSString *)msg;
+ (void)showSuccessMsg:(NSString *)successMsg;
+ (void)showErrorMsg:(NSString *)errorMsg;
+ (void)showProgressWithInfo:(NSString *)title;
+ (void)updateProgress:(float)progress status:(NSString *)status;
+ (void)dismissMsg;

+ (void)showLoader:(BOOL)mask;
+ (void)showStateMsg:(NSString *)msg mask:(BOOL)mask;
+ (void)showInfoMsg:(NSString *)msg mask:(BOOL)mask;
+ (void)showSuccessMsg:(NSString *)successMsg mask:(BOOL)mask;
+ (void)showErrorMsg:(NSString *)errorMsg mask:(BOOL)mask;
+ (void)showProgressWithInfo:(NSString *)title mask:(BOOL)mask;

//+ (void)printRect:(NSString *)name rect:(CGRect)rect;
//+ (NSString *)timeFormatWithTimeInterval:(long)time;

@end
