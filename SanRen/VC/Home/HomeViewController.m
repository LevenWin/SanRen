//
//  HomeViewController.m
//  SanRen
//
//  Created by 吴狄 on 16/9/21.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HeaderTabView.h"
#import "TwoTabCell.h"
#import "LWBannerView.h"
#import "UserCenterViewController.h"
#import "LiveViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tbv;
@property (nonatomic,retain)NSMutableArray *dataArr;
@property (nonatomic,retain)LWBannerView *bannerView;
@property (nonatomic,retain)HeaderTabView *headerTabView;

@end

@implementation HomeViewController

#pragma  mark --LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
}
-(void)didReceiveMemoryWarning{
    NSLog(@"memory notice");
}
#pragma mark--UI
-(void)initUI{
    self.title=@"我师";
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:Image(@"icon_设置_2@2x") style:UIBarButtonItemStyleDone target:self action:@selector(menu)];
    self.navigationItem.leftBarButtonItem=left;
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem=right;
    
    self.tbv.setReusedCell(@{@"HomeTableViewCell":@"HomeTableViewCell",@"TwoTabCell":@"TwoTabCell"});
    
    self.tbv.delegate=self;
    self.tbv.dataSource=self;
    self.tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    __Block(blockSelf);
//    self.tbv.refreshFooter=[self.tbv addRefreshFooterWithHandler:^{
//        [blockSelf loadData];
//       
//    }];
    self.tbv.tableHeaderView=self.bannerView;
    
    self.bannerView.itmeArr=(id)@[Image(@"9-140911213629.jpg"),Image(@"0bf033a85601fd1616f56e245d429e7a.jpeg"),Image(@"f7488318367adab450fff51f8dd4b31c8701e414.jpg")];
//    self.tbv.refreshHeader=[self.tbv addRefreshHeaderWithHandler:^{
//        [blockSelf loadData];
//  
//    }];
    
    self.headerTabView=[[HeaderTabView alloc]inits];
    self.headerTabView.itemSelect=^(NSInteger tag){
        [self processTabClick:tag];
    };

    
//    [self.tbv.refreshHeader startRefresh];
    [self.tbv reloadData];

}
#pragma mark --Data
-(LWBannerView*)bannerView{
    if (!_bannerView) {
        _bannerView=[[LWBannerView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 180)];
        
        
    }
    return _bannerView;
}
-(void)loadData{
  
//    [BaseRequest netRequestGETWithRequestURL:@"message/getMessage" WithParameter:@{@"userId":GetUserDefaults(@"userId")} WithSuccessBlock:^(id obj) {
//        if ([obj[@"status"] boolValue]) {
//            self.dataArr=[NSMutableArray array];
//            for (NSDictionary *dic in  obj[@"data"]) {
//                UserModel *model=[[UserModel alloc]initWithDic:dic];
//                [self.dataArr addObject:model];
//            }
//            [self.tbv reloadData];
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"获取失败!"];
//        }
//        [self.tbv.refreshHeader endRefresh];
//        
//    } WithErrorBlock:^(id obj) {
//        
//    } WithFailureBlock:^(id obj) {
//        
//    }];
}
#pragma mark --Action
-(void)search{
    
}
-(void)menu{
    
}
-(void)processTabClick:(NSInteger)index{
    CGFloat offset=self.tbv.contentOffset.y;
    if (offset<240) {
        [self.tbv setContentOffset:CGPointMake(0, 240) animated:YES];

    };
}
-(void)processCellTabAction:(NSInteger)index{
    if (index==0) {
        LiveViewController *vc=[[LiveViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
}
#pragma mark --Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if(section==1){
        return 35;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }else if (section==1){
        return self.headerTabView;
    }
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
    return 10;
    return self.dataArr.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TwoTabCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TwoTabCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.clickAction=^(NSInteger index){
            [self processCellTabAction:index];
        };
        
        return cell;
    }else{
        
        HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
        //    cell.model=self.dataArr[indexPath.row];
        return cell;
    }
    return nil;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
         return 110;
    }else{
         return 260;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        UserCenterViewController *vc=[[UIStoryboard storyboardWithName:@"UserCenterStoryBoard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"UserCenterViewController"];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc  animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark --Other
@end
