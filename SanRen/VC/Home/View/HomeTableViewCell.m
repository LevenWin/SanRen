//
//  HomeTableViewCell.m
//  SanRen
//
//  Created by 吴狄 on 16/9/21.
//  Copyright © 2016年 Leven. All rights reserved.
//


#import "HomeTableViewCell.h"
@interface HomeTableViewCell(){
    
}
@property (strong, nonatomic) IBOutlet UILabel *learn;
@property (strong, nonatomic) IBOutlet UILabel *skill;
@property (strong, nonatomic) IBOutlet UILabel *job;
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@end
@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(UserModel *)model{
    _model=model;
    self.job.text=model.job;
    self.skill.text=model.skill;
    self.headImg.image=[self.headImg.image setRadiusImg:50];
    
}
@end
