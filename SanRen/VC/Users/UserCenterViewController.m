//
//  UserCenterViewController.m
//  SanRen
//
//  Created by 吴狄 on 16/10/7.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "UserCenterViewController.h"
#define MARGIN 35
#define TOP_MARGIN 10
@interface UserCenterViewController ()
@property (strong, nonatomic) IBOutlet UIButton *wc;
@property (strong, nonatomic) IBOutlet UILabel *wcLocal;
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIScrollView *scr;
@property (strong, nonatomic) IBOutlet UIImageView *iconImg;
@property (strong, nonatomic) IBOutlet UILabel *job;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *selfLocal;
@property (strong, nonatomic) IBOutlet UILabel *selfIntroduce;
@property (strong, nonatomic) IBOutlet UILabel *skillLocal;
@property (strong, nonatomic) IBOutlet UILabel *skill;
@property (strong, nonatomic) IBOutlet UILabel *learnLocal;
@property (strong, nonatomic) IBOutlet UILabel *learn;
@property (strong, nonatomic) IBOutlet UIButton *wechat;
@property (strong, nonatomic) IBOutlet UIButton *praise;
@property (strong, nonatomic) IBOutlet UIButton *demote;

@end

@implementation UserCenterViewController
#pragma  mark --LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initUI];
    [self initNavi];
    [self loadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
   
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark--UI
-(void)initNavi{
//    UILabel *navi=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, UISCREEN_WIDTH, 44)];
    self.name.setTextColor([UIColor whiteColor]).settextAlignment(NSTextAlignmentCenter).setFont([UIFont systemFontOfSize:17]).setText(@"iOS开发工程师");
    
    
//    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame=CGRectMake(12,23, 40, 40);
    [self.leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setImage:Image(@"cm2_topbar_icn_back") forState:UIControlStateNormal];
//    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(8, -5, 8, 20)];
//    
//    [self.view addSubview:rightBtn];
//    [self.view addSubview:navi];

}
-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];

   
    self.bgImg.image=Image(@"0bf033a85601fd1616f56e245d429e7a.jpeg");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *img=[self.bgImg.image boxblurImageWithBlur:1];
                if (img) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.bgImg setImgWithFadeAnimationUIImage:img];
        
                    });
                }
        
    });
    
    self.iconImg.image=Image(@"0bf033a85601fd1616f56e245d429e7a.jpeg");
    self.iconImg.drawRadius=@"5";
    self.iconImg.layer.borderWidth=1;
    self.iconImg.layer.borderColor=[UIColor whiteColor].CGColor;
    self.iconImg.frame=CGRectMake((UISCREEN_WIDTH-170)/2,16 , 170, 170);
    [self.iconImg showWithAnimation];
    
    CGFloat introduceHeight=[self.selfIntroduce.text boundingRectWithSize:CGSizeMake(UISCREEN_WIDTH-self.selfIntroduce.left_gst-MARGIN, 200) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    self.selfIntroduce.height_gst=introduceHeight;
    self.selfIntroduce.width_gst=UISCREEN_WIDTH-self.selfIntroduce.left_gst-MARGIN;
    self.selfIntroduce.top_gst=self.selfLocal.top_gst;
    
    self.skillLocal.top_gst=self.selfIntroduce.bottom_gst+TOP_MARGIN;
    self.skill.top_gst=self.selfIntroduce.bottom_gst+TOP_MARGIN;
    
    self.learn.top_gst=self.skill.bottom_gst+TOP_MARGIN;
    self.learnLocal.top_gst=self.skill.bottom_gst+TOP_MARGIN;
 

    self.wcLocal.top_gst=self.learn.bottom_gst+TOP_MARGIN;
    self.wechat.top_gst=self.learn.bottom_gst+TOP_MARGIN;
   
    
    self.scr.height_gst=UISCREEN_HEIGHT-64-50;
     self.scr.contentSize=CGSizeMake(UISCREEN_WIDTH,UISCREEN_HEIGHT-63-50);
    
    
    
    
}
#pragma mark --Data
-(void)loadData{
    
}
#pragma mark --Action

#pragma mark --Delegate

#pragma mark --Other
@end
