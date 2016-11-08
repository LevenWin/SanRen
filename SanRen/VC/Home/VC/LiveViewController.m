//
//  LiveViewController.m
//  SanRen
//
//  Created by 吴狄 on 16/10/22.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "LiveViewController.h"
#import "DrawTableView.h"
#import "DrawTableViewCell.h"
#import "MessageModel.h"
@interface LiveViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *needLoadArr;
}
@property (nonatomic,assign)NSInteger currentpage;
@property (nonatomic,retain)NSMutableArray *dataArr;
@property (nonatomic,retain)DrawTableView *tbv;
@end

@implementation LiveViewController
#pragma  mark --LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
#pragma mark--UI
-(void)initUI{
    self.title=@"动态";
    
    DrawTableView *tbv=[[DrawTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    tbv.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    tbv.delegate=self;
    tbv.dataSource=self;
    [tbv registerClass:[DrawTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tbv=tbv;
    self.tbv.separatorColor=[UIColor clearColor];
    [self.view addSubview:tbv];
    self.currentpage=0;
    @weakify(self)
    self.tbv.refreshFooter=[self.tbv addRefreshFooterWithHandler:^{
        @strongify(self)
        self.currentpage++;
        [self loadData];
    }];
    self.tbv.refreshHeader=[self.tbv addRefreshHeaderWithHandler:^{
        @strongify(self);
        self.currentpage=1;
        [self loadData];
    }];
    [self.tbv.refreshHeader startRefresh];
}
#pragma mark --Data
-(void)loadData{
//
    
    needLoadArr=[NSMutableArray array];
    NSDictionary*dic=@{@"creattime":@"2016-10-20 11:39:55",@"isVideo":@"0",@"page":[NSString stringWithFormat:@"%lu",self.currentpage],@"rows":@"20",@"userId":@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIyMn0.wgoiwQ5_axQLdt0WdJEG0V_mzRTT2EwoNOD-3HAm0wc"};
    
    [BaseRequest netRequestGETWithRequestURL:@"http://jinyeshenyuan.com:8080/xd/app/allMessageListNew" WithParameter:dic WithSuccessBlock:^(id obj) {
       
        
        NSArray *arr=obj[@"data"][@"rows"];
        if (arr) {
            if (self.currentpage==1) {
                self.dataArr=[NSMutableArray array];
                
            }
        }
        for ( NSDictionary *dic in arr) {
            MessageModel *model=[[MessageModel alloc]initWithDic:dic];
            model.vc=self;
            if (!model.messagetypes) {
                
            }else{
                continue;
            }
            [self.dataArr addObject:model];
        }
        
        
        [self.tbv reloadData];
        [self.tbv.refreshHeader endRefresh];
        [self.tbv.refreshFooter endRefresh];

    } WithErrorBlock:nil WithFailureBlock:nil];
    
    
}
#pragma mark --Action
-(void)processImgs:(NSArray*)imgs{
    
}
- (IBAction)addInfor:(id)sender {
    
    
}
#pragma mark --Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model=self.dataArr[indexPath.row];
   
    
    return model.cellHeight<kSpec+2*minSpec+kAvatar?kSpec+2*minSpec+kAvatar:model.cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageModel *model=self.dataArr[indexPath.row];
    if (model.video&&model.video.length>0) {
        
    }
    
    DrawTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell=[[DrawTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (needLoadArr.count>0&&[needLoadArr indexOfObject:indexPath]==NSNotFound) {
        [cell clearLayer];
        
    }else{
        cell.model=model;
        [cell drawCell];
    }

    
   
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    

}
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    DrawTableViewCell *drawCell=(DrawTableViewCell*)[tableView cellForRowAtIndexPath: indexPath];
    [drawCell clearLayer];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [UIMenuController sharedMenuController].menuVisible = NO;
    
    
}
//按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定5行加载。

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSIndexPath *ip = [self.tbv indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    NSIndexPath *cip = [[self.tbv indexPathsForVisibleRows] firstObject];
    NSInteger skipCount = 8;
    if (labs(cip.row-ip.row)>skipCount) {
        NSArray *temp = [self.tbv indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.tbv.width, self.tbv.height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        if (velocity.y<0) {
            NSIndexPath *indexPath = [temp lastObject];
            if (indexPath.row+5<self.dataArr.count) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+4 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+5 inSection:0]];
              
            }
        } else {
            NSIndexPath *indexPath = [temp firstObject];
            if (indexPath.row>5) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
                 [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-4 inSection:0]];
                 [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-5 inSection:0]];
                
            }
        }
        [needLoadArr addObjectsFromArray:arr];
    }

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [needLoadArr removeAllObjects];
}
@end
