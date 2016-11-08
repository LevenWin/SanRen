//
//  EmojiContainerView.m
//  LWInputView
//
//  Created by 吴狄 on 16/9/7.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "EmojiContainerView.h"
@interface EmojiContainerView()<UICollectionViewDataSource,UICollectionViewDelegate>{
    InputType inputType;

}
@property (nonatomic,retain)UICollectionView *collectView;
@end
@implementation EmojiContainerView
+(instancetype)shareInstance{
    static EmojiContainerView *emoji=nil;
    if (!emoji) {
        emoji=[[EmojiContainerView alloc]init];
    }
    return emoji;
}
-(UICollectionView*)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        
        layout.itemSize=CGSizeMake(30, 30);
        _collectView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectView.pagingEnabled=YES;
        _collectView.delegate=self;
        _collectView.dataSource=self;
        _collectView.backgroundColor=[UIColor whiteColor];
        [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectView;
}
-(void)setType:(InputType)type select:(InputBlock)block{
    inputType=type;
    [self setup];
}
#pragma mark UI
-(void)setup{
    [self addSubview:self.collectView];
    [self.collectView reloadData];
}
#pragma mark delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 200;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"cell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(255) / 255.0) green:(arc4random_uniform(255) / 255.0) blue:(arc4random_uniform(255) / 255.0) alpha:1.0f];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(35, 35);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}
@end
