//
//  TwoTabCell.m
//  SanRen
//
//  Created by 吴狄 on 16/10/7.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "TwoTabCell.h"

@implementation TwoTabCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)click:(id)sender {
    if (self.clickAction) {
        self.clickAction(((UIButton*)sender).tag);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
