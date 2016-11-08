//
//  MyViewController.m
//  SanRen
//
//  Created by 吴狄 on 16/10/9.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "MyViewController.h"
#import "myHeaderView.h"
#import "UploadViewController.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>{
    myHeaderView*headerView;
}
@property (nonatomic,retain)UITableView *tbv;
@end

@implementation MyViewController

#pragma  mark --LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
#pragma mark--UI
-(void)initUI{
    self.navigationItem.leftBarButtonItem=nil;
      
    self.tbv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT-64)];
    headerView=[[myHeaderView alloc]inits];
    self.tbv.tableHeaderView=headerView;
    [self.view addSubview:self.tbv];
    SET_TBVDELEGATE(_tbv);

}
#pragma mark --Data
-(void)loadData{
//    [BaseRequest netRequestGETWithRequestURL:Url(@"user/userInfor") WithParameter:@{@"userId":GetUserDefaults(@"userId")} WithSuccessBlock:^(id obj) {
//        if ([obj[@"status"] integerValue]==1) {
//            headerView.dataDic=obj[@"data"];
// 
//        }
//    } WithErrorBlock:^(id obj) {
//        
//    } WithFailureBlock:^(id obj) {
//        
//    }];
}
-(void)menu{
    UploadViewController*vc=[[UploadViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --Action
- (IBAction)logout:(id)sender {
    [AppTraceManager logout];
}

#pragma mark --Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark --Other

@end
