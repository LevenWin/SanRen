//
//  UploadViewController.m
//  Login
//
//  Created by 吴狄 on 16/9/2.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "UploadViewController.h"
#import "PicSelectTool.h"
#import "BaseRequest.h"
#import "MyUIAlertView.h"
#import "LevenDownToUpSheet.h"
@interface UploadViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UIImagePickerController *_pickVC;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scr;
@property (strong, nonatomic) IBOutlet UIImageView *selectImgBtn;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIView *imgContainer;

@property (nonatomic,retain)NSMutableArray *imgArr;
@property (nonatomic,retain)NSMutableArray *imgStrArr;
@property (strong, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation UploadViewController
#pragma  mark --LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark--UI
-(void)initUI{
    self.textView.top_gst=10;
    self.scr.frame=CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT-64);
    self.scr.contentSize=CGSizeMake(UISCREEN_WIDTH, self.scr.height_gst+1);
    
    __Block(blockSelf);
    self.selectImgBtn.userInteractionEnabled=YES;
    [self.selectImgBtn setTapAction:^(UITapGestureRecognizer *tap) {
        [blockSelf selectImgs];
    }];
    
    [self.imgContainer setTapAction:^(UITapGestureRecognizer *tap) {
        [blockSelf selectImgs];
    }];
    [self processImg];
}
-(NSMutableArray*)imgArr{
    if (!_imgArr) {
        _imgArr=[NSMutableArray array];
    }
    return _imgArr;
}
-(NSMutableArray*)imgStrArr{
    if (!_imgStrArr) {
        _imgStrArr=[NSMutableArray array];
    }
    return _imgStrArr;
}
#pragma mark --Data
- (IBAction)upload:(id)sender {
    [self.imgArr removeLastObject];
    for (UIImage *img in self.imgArr) {
        NSData *data=UIImageJPEGRepresentation(img, 1);
        if (!data) {
            data=UIImagePNGRepresentation(img);
        }
        
        NSString *imgStr=[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self.imgStrArr addObject:imgStr];
    }
   
    NSString *imgs=[self.imgStrArr componentsJoinedByString:@","];

    [self hideKeyboard];
    [SVProgressHUD showWithStatus:@"正在发布..."];
    [BaseRequest netRequestPOSTWithRequestURL:Url(@"message/releaseMsgs") WithParameter:@{@"imgs":imgs,@"userId":GetUserDefaults(@"userId"),@"content":self.textView.text} WithSuccessBlock:^(id obj) {
        if (obj&&[obj[@"status"] integerValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"发布成功!"];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            Alert(obj[@"message"]);
            [SVProgressHUD dismiss];
        }

        
        
    } WithErrorBlock:^(id obj) {
            [SVProgressHUD dismiss];
    } WithFailureBlock:^(id obj) {
        
                   [SVProgressHUD dismiss];
        
    }];
    
}

#pragma mark --Action
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)processImg{
    if ([self.imgArr containsObject:self.selectImgBtn.image]) {
        [self.imgArr removeObject:self.selectImgBtn.image];
    }
    
    [self.imgArr addObject:self.selectImgBtn.image];
    
    NSInteger rowNum=4;
    CGFloat space=5;
    CGFloat width=(UISCREEN_WIDTH-space*(rowNum+1))/rowNum;
    
    [self.imgContainer removeAllSubviews];
    CGFloat X=space;
    CGFloat Y=space;
    for (UIImage *img in self.imgArr) {
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(X, Y, width, width)];
        [self.imgContainer addSubview:imageV];
        imageV.image=img;
        NSInteger index =[self.imgArr indexOfObject:img];
        if ((index+1)%rowNum==0) {
            X=space;
            Y+=width+space;
        }else{
            X+=width+space;
        }
    }
    if (X==space) {
        Y-=width-space;
    }
    [UIView animateWithDuration:0.29 animations:^{
        self.imgContainer.height_gst=Y+width+space;
        self.bottomLineView.top_gst=self.imgContainer.bottom_gst;
    }];
   
   
}
#pragma mark --Delegate
-(void)selectImgs{
    [self hideKeyboard];
    LevenDownToUpSheet *sheet=[[LevenDownToUpSheet alloc]init];
    sheet.titleArr=@[@"相机",@"相册"];
    sheet.itemClick=^(NSInteger index){
        if (index==0) {
            [[PicSelectTool shareInstance] selectImgForCameraWithVC:self getImg:^(UIImage *image) {
                [self.imgArr addObject:image];
                [self processImg];

            }];
        }else{
            [[PicSelectTool shareInstance] selectImgForAlbumWithVC:self getImg:^(UIImage *image) {
                [self.imgArr addObject:image];
                [self processImg];

            }];
        }
    };
    [sheet show];
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        _pickVC = [[UIImagePickerController alloc] init];
//        _pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        _pickVC.delegate = self;
////        _pickVC.allowsEditing=YES;
//        
//       
//        
//        [self presentViewController:_pickVC animated:YES completion:nil];
//    }else{
//        
//        
//    }
//    
}


// 对选择的相片进行再次询问确认

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    
//    UIImage *img= info[@"UIImagePickerControllerOriginalImage"];
//    // 获取选择好的相片
//    [self.imgArr addObject:img];
//    [self processImg];
//    [_pickVC dismissViewControllerAnimated:YES completion:nil];
//    
//}
@end

#pragma mark --Other
