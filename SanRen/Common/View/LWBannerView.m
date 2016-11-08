//
//  LWBannerView.m
//  LWBanner
//
//  Created by 吴狄 on 16/9/13.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "LWBannerView.h"

#define LW_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define LW_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LWCollectViewCell : UICollectionViewCell
@property (nonatomic,retain)NSString *imgUrl;
@property (nonatomic,retain)UIImageView *img;
@end
@implementation LWCollectViewCell
-(UIImageView *)img{
    if (!_img) {
        _img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, self.height_gst)];
        _img.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_img];
    }
    return _img;
}
-(void)setImgUrl:(NSString *)imgUrl{
    if ([imgUrl isKindOfClass:[NSString class]]) {
        _imgUrl=imgUrl;
        [self.img setImgWithFadeAnimationNSString:imgUrl];

    }else if([imgUrl isKindOfClass:[UIImage class]]){
       // [self.img setImgWithFadeAnimationUIImage:(id)imgUrl];
        self.img.image=(id)imgUrl;
    }
    
    
}


@end

/**
 *  <#Description#>
 */
@interface LWBannerView ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>{
    
    
}

@property (nonatomic,retain)UICollectionView *collectView;
@property (nonatomic,retain)NSTimer *timer;

@end
@implementation LWBannerView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}
-(UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        layout.itemSize=CGSizeMake(LW_SCREEN_WIDTH, self.frame.size.height);
        layout.minimumLineSpacing=0;
        layout.headerReferenceSize=CGSizeMake(0, 0);
        layout.footerReferenceSize=CGSizeMake(0, 0);

        layout.minimumInteritemSpacing=0;
        layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        _collectView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectView.pagingEnabled=YES;
        _collectView.delegate=self;
        _collectView.dataSource=self;
        [_collectView registerClass:[LWCollectViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectView.backgroundColor=[UIColor whiteColor];
        _collectView.showsHorizontalScrollIndicator=NO;
    }
    return _collectView;
}
-(UIPageControl*)pageContro{
    if (!_pageContro) {
        _pageContro=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, LW_SCREEN_WIDTH, 20)];
        _pageContro.numberOfPages=self.itmeArr.count;
        _pageContro.currentPageIndicatorTintColor=[UIColor orangeColor];
        _pageContro.pageIndicatorTintColor=[UIColor whiteColor];

        
    }
    return _pageContro;
}
-(void)fireTime{
    CADisplayLink *link=[CADisplayLink displayLinkWithTarget:self selector:@selector(scrollCollect)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    link.frameInterval=300;

}
//-(NSTimer*)timer{
//    if (!_timer) {
      //        _timer=[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(test) userInfo:nil repeats:YES];
        
//    }
//    return _timer;
//}

-(void)setItmeArr:(NSMutableArray *)itmeArr{
    
    _itmeArr=[NSMutableArray arrayWithArray:itmeArr];
    [_itmeArr insertObject:itmeArr.lastObject atIndex:0];
    [self setup];
}
-(void)setup{
    [self addSubview:self.collectView];
    [self addSubview:self.pageContro];
    self.pageContro.numberOfPages=self.itmeArr.count-1;
    [self.collectView reloadData];
    [self.collectView setContentOffset:CGPointMake(UISCREEN_WIDTH, 0) animated:NO];
    [self fireTime];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//    [self.timer fire];

}
-(void)scrollCollect{
    
    [self.collectView setContentOffset:CGPointMake(self.collectView.contentOffset.x+UISCREEN_WIDTH, 0) animated:YES];
    
}
#pragma mark ColloectDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itmeArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LWCollectViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imgUrl=self.itmeArr[indexPath.row];
    cell.backgroundColor=[UIColor lightGrayColor];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(LW_SCREEN_WIDTH, self.frame.size.height);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWCollectViewCell*cell=(id)[collectionView cellForItemAtIndexPath:indexPath];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.itemSelect) {
        if (indexPath.row==0) {
            self.itemSelect(self.itmeArr.count-2 ,cell.img.image);
        }else{
            self.itemSelect(indexPath.row-1 ,cell.img.image);
        }
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x/UISCREEN_WIDTH==self.itmeArr.count-1) {
        [self.collectView setContentOffset:CGPointMake(0, 0) animated:NO];
        
    }
       self.pageContro.currentPage=scrollView.contentOffset.x==0?self.itmeArr.count-1:(scrollView.contentOffset.x/UISCREEN_WIDTH-1);
}
@end
