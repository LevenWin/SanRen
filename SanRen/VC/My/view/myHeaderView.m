//
//  myHeaderView.m
//  SanRen
//
//  Created by 吴狄 on 16/10/22.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "myHeaderView.h"
#import "LevenDownToUpSheet.h"
@interface myHeaderView(){
    
    IBOutlet UIImageView *headerImg;
    IBOutlet UILabel *name;
    
    IBOutlet UILabel *locatePlace;
}
@end
@implementation myHeaderView
-(void)awakeFromNib{
    headerImg.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    headerImg.drawRadius=@"65";
    headerImg.layer.borderWidth=1;
    headerImg.layer.borderColor=[UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1.0].CGColor;
    __Block(blockSelf);
    [headerImg setTapAction:^(UITapGestureRecognizer *tap) {
        [blockSelf selectHaderImg];
    }];
    [headerImg sd_setImageWithURL:[NSURL URLWithString:@"http://7xswdm.com1.z0.glb.clouddn.com/2016-08-11_N73d14SR.png"]];
}
-(void)selectHaderImg{
    LevenDownToUpSheet *sheet=[[LevenDownToUpSheet alloc]init];
    sheet.titleArr=@[@"相机",@"相册"];
    sheet.itemClick=^(NSInteger index){
        if (index==0) {
            [[PicSelectTool shareInstance] selectImgForCameraWithVC:[AppTraceManager shareInstance].topViewController getImg:^(UIImage *image) {
                [self upload:image];
            }];
        }else{
            [[PicSelectTool shareInstance] selectImgForAlbumWithVC:[AppTraceManager shareInstance].topViewController getImg:^(UIImage *image) {
                [self upload:image];
            }];
        }
    };
    [sheet show];

}
-(void)upload:(UIImage*)img{
    NSData *data=UIImageJPEGRepresentation(img, 1);
    if (!data) {
        data=UIImagePNGRepresentation(img);
    }
    
    NSString *imgStr=[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [SVProgressHUD showWithStatus:@"正在上传..."];
    [BaseRequest netRequestPOSTWithRequestURL:Url(@"user/modify") WithParameter:@{@"userId":GetUserDefaults(@"userId"),@"headImg":imgStr} WithSuccessBlock:^(id obj) {
        if (obj&&[obj[@"status"] integerValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功!"];
            [headerImg sd_setImageWithURL:[NSURL URLWithString:obj[@"data"][@"headImg"]]];
            
        }else{
            
            
        }
    } WithErrorBlock:^(id obj) {
        [SVProgressHUD dismiss];
    } WithFailureBlock:^(id obj) {
        
        [SVProgressHUD dismiss];
        
    }];
    

}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic=dataDic;
    [headerImg sd_setImageWithURL:[NSURL URLWithString:_dataDic[@"headImg"]]];
}

@end
