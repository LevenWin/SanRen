//
//  PicSelectTool.m
//  SmartSchool
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 MYMAC. All rights reserved.
//

#import "PicSelectTool.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+UIImageScale.h"

@interface PicSelectTool()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UIImage *_resultImg;
    UIImagePickerController*_pickVC;
    UIViewController *topVC;
    NSData *_imageData;
}
@property (nonatomic,copy)void(^imgBlock)(UIImage *);
@end
@implementation PicSelectTool
+(instancetype)shareInstance{
   static PicSelectTool *picTool=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picTool=[[PicSelectTool alloc]init];
     
    });
    return picTool;
}
-(void)selectImgForCameraWithVC:(UIViewController *)vc getImg:(void (^)(UIImage *))imageBlock{
    topVC=vc;
    self.imgBlock=imageBlock;
    [self selectImgFromCamera];
}
-(void)selectImgForAlbumWithVC:(UIViewController *)vc getImg:(void (^)(UIImage *))imageBlock{
    topVC=vc;
    self.imgBlock=imageBlock;
    [self selectImgFromAlbum];
}
-(void)selectImgFromAlbum{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            _pickVC = [[UIImagePickerController alloc] init];
            _pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            _pickVC.delegate = self;
            
            //        [_pickVC.navigationController.navigationBar setTintColor:FontOrange];
            //        _pickVC.navigationController.navigationBar.translucent = YES;
            //        _pickVC.edgesForExtendedLayout = UIRectEdgeAll;
            
            
            [topVC presentViewController:_pickVC animated:YES completion:nil];
        }else{
            [MyUIHelper showErrorMsg:@"请检查您的相册是否可用"];
        }
  

}
-(void)selectImgFromCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            [MyUIHelper showInfoMsg:@"亲，请先前往设置-隐私-相机中打开相机权限噢！"];
            return;
            
        }else{
            [self presentCameraView];
        }
        
    }else{
        [MyUIHelper showErrorMsg:@"请检查您的相机是否可用"];
    }

}
- (void)presentCameraView{
    _pickVC = [[UIImagePickerController alloc] init];
    _pickVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    _pickVC.delegate = self;
    _pickVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    _pickVC.allowsEditing = YES;

    dispatch_async(dispatch_get_main_queue(), ^{
        [topVC presentViewController:_pickVC animated:NO completion:nil];
    });
}
#pragma Camera delegate
// 对选择的相片进行再次询问确认
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    
    _resultImg = info[@"UIImagePickerControllerOriginalImage"];
    if (self.imgBlock&&_resultImg) {
        self.imgBlock(_resultImg);
    }
    [_pickVC dismissViewControllerAnimated:YES completion:nil];

}



#pragma Mark--Navi
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    
    if (_pickVC.sourceType == UIImagePickerControllerSourceTypePhotoLibrary && [navigationController.viewControllers count] <= 2) {
        viewController.edgesForExtendedLayout = UIRectEdgeTop;
    }else{
        viewController.edgesForExtendedLayout = UIRectEdgeTop;
    }
    
  
}


@end
