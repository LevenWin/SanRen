//
//  DrawTableViewCell.m
//  DrawCellTest
//
//  Created by 吴狄 on 16/10/18.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "DrawTableViewCell.h"
#import "ContentTextManager.h"
#import "LWImageLayer.h"
#import "LWImageBrowser.h"
#import "CollectImgModel.h"
#import "CQView.h"
#import "UIImage+UIImageScale.h"
#import "CommentLayer.h"
#import "VideoPlayView.h"
#import "VideoModel.h"
//http://7xswdm.com1.z0.glb.clouddn.com/FgReIyj_76BVpSYQM7TqmX6BWuQb?imageView2/1/w/400/h/400

#define  TipsHeight 40
@interface DrawTableViewCell()<LWImageBrowserDelegate>{

    CGPoint startLocation;
    //按content的开始 结束时间
    NSInteger touchBegin_time;
    NSInteger touchEnd_time;
    //长按复制
    BOOL hasTouchContent;
    NSInteger drawColorFlag;
    BOOL drawed;
}
@property (nonatomic,retain)CQView *copyV;
@property (nonatomic,retain)LWImageLayer *headrImgLayer;
@property (nonatomic,retain)NSMutableArray *imgsLayerArr;
@property (nonatomic,retain)VideoPlayView *playerView;
@property (nonatomic,retain)NSMutableArray *tagRectArr;
@property (nonatomic,retain)NSMutableArray *tagTitleArr;


@property (nonatomic,retain)CALayer *lineLayer;
@property (nonatomic,retain)CALayer *minLineLayer;


@property (nonatomic,retain)ContentTextManager *drawManager;
@property(nonatomic,retain)CommentLayer *commentLayer;
@end
@implementation DrawTableViewCell
-(void)setModel:(MessageModel *)model{
    
    drawed=NO;
    _model=model;
    drawColorFlag = arc4random();
  
  
}
-(void)drawCell{
    [self processImgs:nil];
    [self fillContent:nil];
    [self fillVideo];
    //    [self fillTags:nil];
    [self fillComment];
}
-(void)setContent:(NSString *)content{
    _content=content;
    
}
-(LWImageLayer*)headrImgLayer{
    if (!_headrImgLayer) {
         _headrImgLayer=[[LWImageLayer alloc]init];
        _headrImgLayer.frame=CGRectMake(kSpec, kSpec, kAvatar, kAvatar);
    }
    return _headrImgLayer;
}
-(CALayer*)lineLayer{
    if (!_lineLayer) {
        _lineLayer=[[CALayer alloc]init];
        _lineLayer.backgroundColor=[UIColor colorWithRed:0.913 green:0.913 blue:0.913 alpha:1.0].CGColor;
        
    }
   return  _lineLayer;
}
-(CommentLayer*)commentLayer{
    if (!_commentLayer) {
        _commentLayer=[[CommentLayer alloc]init];
       
            }
    return _commentLayer;
}
-(CALayer*)minLineLayer{
    if (!_minLineLayer) {
        _minLineLayer=[[CALayer alloc]init];
        _minLineLayer.backgroundColor=[UIColor colorWithRed:0.8726 green:0.8726 blue:0.8726 alpha:1.0].CGColor;
        
    }
    return  _minLineLayer;
}
-(CQView*)copyV{
    if (!_copyV) {
        _copyV=[[CQView alloc]initWithFrame:CGRectMake(startLocation.x, startLocation.y, 80, 80)];
        
        [_copyV initWithCQLayerFrame:CGRectMake(startLocation.x, startLocation.y, 80, 80)];
        
        _copyV.progress=0.3;
    }
    _copyV.hidden=NO;
    _copyV.alpha=1;
    return _copyV;
}
-(void)fillComment{
    if (_model.commonModel.uUsername.length>0) {
        self.commentLayer.model=self.model.commonModel;
        self.commentLayer.frame=CGRectMake(kSpec, _model.cellHeight-kSpec-TipsHeight-_model.commonModel.containerHeight, UISCREEN_WIDTH-2*kSpec, _model.commonModel.containerHeight);
        
        [self.contentView.layer addSublayer:self.commentLayer];

    }
   
}
-(void)fillContent:(NSArray*)rectArr{
    
     NSInteger flag = drawColorFlag;
    if (drawed) {
        return;
    }
    drawed=YES;
    self.tagRectArr=[NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"***************开始绘制拉************");
        //集成当前的上下文信息
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(ScreenWidth, _model.cellHeight), YES, 0);
        CGContextRef context=UIGraphicsGetCurrentContext();
        [UIColorFromRGB(0xffffff) set];
        CGContextFillRect(context, CGRectMake(0,0,ScreenWidth,_model.cellHeight));
        
        // 获取需要高亮的链接CGRect，并填充背景色
        if (rectArr) {
            for (NSString *string in rectArr) {
                CGRect rect = CGRectFromString(string);
                [UIColorFromRGB(0xe5e5e5) set];
                CGContextFillRect(context, rect);
            }
        }
        [self.drawManager setText:_model.nickname context:context contentSize:CGSizeMake(ScreenWidth-2*kSpec,_model.nicknameSize.height) backgroundColor:[UIColor whiteColor] font:kNicknameFont textColor:[UIColor blackColor] block:nil xOffset:kSpec*2+kAvatar yOffset:1.5*minSpec];
        [self.drawManager setText:_model.school context:context contentSize:CGSizeMake(ScreenWidth-2*kSpec, _model.schoolSize.height) backgroundColor:[UIColor whiteColor] font:kUniversityFont textColor:[UIColor darkGrayColor] block:nil xOffset:kSpec*2+kAvatar yOffset:_model.nicknameSize.height+2.5*minSpec];
        //将配置信息，与该上下文传入
        
        if (self.model.content&&self.model.content.length>0) {
            [self.drawManager setText:_model.content context:context contentSize:CGSizeMake(UISCREEN_WIDTH-kSpec, _model.contentSize.height) backgroundColor:[UIColor whiteColor] font:kContentTextFont textColor:[UIColor blackColor] block:nil xOffset:kSpec yOffset:_model.contentRect.origin.y];
        }
        
        
        if (self.model.topic_id&&self.model.topic_id.length>0) {
            [self.drawManager setText:_model.topic_id context:context contentSize:CGSizeMake(_model.topicSize.width, _model.topicSize.height) backgroundColor:[UIColor whiteColor] font:kContentTextFont textColor:[UIColor blackColor] block:nil xOffset:kSpec yOffset:_model.topicRect.origin.y];
        }
        
        //小图标
        
        NSArray *imgArr=@[Image(@"icon_view") ,Image(@"icon_点赞_1"),Image(@"icon_comments"),Image(@"icon_zhuanfa")];
        CGFloat Xoffset=kSpec;
        CGFloat Yoffset=_model.cellHeight-kSpec-30;
        
        for (NSInteger i=0; i<imgArr.count; i++) {
            UIImage*image=imgArr[i];
            
            if ([_model.commentlikestatues boolValue]&&i==1) {
                [[Image(@"icon_点赞_2") imagebyScalingToSize:CGSizeMake(image.size.width/2, image.size.height/2)] drawInRect:CGRectMake(Xoffset,Yoffset, 20, 20) blendMode:kCGBlendModeNormal alpha:1];
            }else{
                [[image imagebyScalingToSize:CGSizeMake(image.size.width/2, image.size.height/2)] drawInRect:CGRectMake(Xoffset,Yoffset, 20, 20) blendMode:kCGBlendModeNormal alpha:1];
            }
            [self.tagRectArr addObject:NSStringFromCGRect(CGRectMake(Xoffset, Yoffset, 20, 20))];
            Xoffset=Xoffset+70;
           
        }
        //浏览数 赞 评论数
        NSArray *textArr=@[NSStringFromeObj(_model.viewcounts),NSStringFromeObj(_model.zannercount),NSStringFromeObj(_model.commentcount)];

        Xoffset=kSpec+40;
        Yoffset=_model.cellHeight-kSpec-40+13;
        for (NSInteger i=0; i<textArr.count; i++) {
        
            CGSize size=[textArr[i] sizeWithConstrainedToWidth:ScreenWidth-2*kSpec fromFont:kUniversityFont lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
            
            [self.drawManager setText:textArr[i] context:context contentSize:size backgroundColor:[UIColor whiteColor] font:kUniversityFont textColor:[UIColor lightGrayColor] block:nil xOffset:Xoffset yOffset:Yoffset];
            Xoffset=Xoffset+70;

            
        }
        

        
        //middle separt line
        [[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0] set];
        CGContextFillRect(context, CGRectMake(kSpec,_model.cellHeight-kSpec-40, UISCREEN_WIDTH-2*kSpec, 0.3));
        //bottom Line
        [[UIColor colorWithRed:233.8/255.0 green:233.8/255.0 blue:233.8/255.0 alpha:1.0] set];
        CGContextFillRect(context, CGRectMake(0,_model.cellHeight-kSpec, UISCREEN_WIDTH, kSpec));
        
        
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            if (flag==drawColorFlag) {
                self.contentView.layer.contents = (__bridge id _Nullable)(temp.CGImage);
                drawed=NO;
            }
        });

    });
  
}
-(void)fillTags:(CGContextRef)context{
    
  
//    self.tagImgArr=[NSMutableArray array];
//    
//    NSArray *imgArr=@[Image(@"icon_view") ,Image(@"icon_点赞_1"),Image(@"icon_comments"),Image(@"icon_zhuanfa")];
//    NSArray *imgArr_Highlited=@[Image(@"icon_view") ,Image(@"icon_点赞_2"),Image(@"icon_comments"),Image(@"icon_zhuanfa")];
//
//     NSArray *textArr=@[NSStringFromeObj(_model.viewcounts),NSStringFromeObj(_model.zannercount),NSStringFromeObj(_model.commentcount)];
//    CGFloat Xoffset=kSpec;
//    CGFloat Yoffset=_model.cellHeight-kSpec-40;
//    for (NSInteger i=0; i<imgArr.count; i++) {
//        UIImage*image=imgArr[i];
//        UIImageView *img=[[UIImageView alloc]initWithImage:[image imagebyScalingToSize:CGSizeMake(image.size.width/1, image.size.height/1)]];
//        img.highlightedImage=imgArr_Highlited[i];
//        img.contentMode=UIViewContentModeCenter;
//        
//         [[image imagebyScalingToSize:CGSizeMake(image.size.width/1, image.size.height/1)] drawInRect:CGRectMake(Xoffset,Yoffset, 40, 40) blendMode:kCGBlendModeNormal alpha:1];
    
//        [self.contentView addSubview:img];
//        img.frame=CGRectMake(Xoffset, Yoffset, 40,40);
//         ;
//        img.highlighted=_model.commentlikestatues.boolValue;
//        [self.tagImgArr addObject:img];
//        if (i==imgArr.count-1) {
//            img.frame=CGRectMake(UISCREEN_WIDTH-40-kSpec, Yoffset, 40,40);
//        }
        
        
        
//        Xoffset=Xoffset+70;
    
        
//    }
//        Xoffset=kSpec+40;
//        Yoffset=_model.cellHeight-kSpec-40+13;
//    for (NSInteger i=0; i<3; i++) {
//        CGSize size=[textArr[i] sizeWithConstrainedToWidth:ScreenWidth-2*kSpec fromFont:kUniversityFont lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
//        UILabel *textLab=[[UILabel alloc]initWithFrame:CGRectMake(Xoffset, Yoffset, size.width, size.height)];
//        textLab.textColor=[UIColor lightGrayColor];
//        textLab.font=kUniversityFont;
//        textLab.text=NSStringFromeObj(textArr[i]);
//        [self.contentView addSubview:textLab];
//    
//        Xoffset=Xoffset+70;
//        [self.tagTitleArr addObject:textLab];
//        
//    }
    
  
}
-(void)processImgs:(CGContextRef)context{
    [self.headrImgLayer setImageUrl:_model.image_uri radius:0.5];
    
    [self.contentView.layer addSublayer:_headrImgLayer];
    
    
    self.imgsLayerArr=[NSMutableArray array];
  
    for (NSInteger i=0;i<_model.Thumb_ImagesArr.count;i++) {
        LWImageLayer *layer=[[LWImageLayer alloc]init];
        layer.frame=[_model.imageRectArr[i] CGRectValue];
        [self.contentView.layer addSublayer:layer];
//        if (i==0) {
//            [layer setImageUrl:@"http://7xswdm.com1.z0.glb.clouddn.com/2016-08-11_N73d14SR.png"];
//        }else{
            if (ImgHasCache(_model.High_ImagesArr[i])) {
                [layer setImageUrl:_model.High_ImagesArr[i]];
            }else{
                [layer setImageUrl:_model.Thumb_ImagesArr[i]];
            }

//        }
    
        layer.masksToBounds=YES;
        layer.contentsGravity=kCAGravityResizeAspectFill;
        [self.imgsLayerArr addObject:layer];
        
    }
    
   
    
}
-(void)fillVideo{
    if (self.model.video&&[self.model.video isKindOfClass:[NSString class]]&&self.model.video.length>5) {
        
        self.playerView=[[VideoPlayView alloc]init];
        self.playerView.frame=self.model.videoRect;
        self.playerView.backgroundColor=[UIColor blackColor];
        self.model.videoModel.vc=self.vc;
        self.model.videoModel.superView=self;
        [self.contentView addSubview:self.playerView];
        self.playerView.model=self.model.videoModel;
    }
    /*
     
     设置视频的相关信息
     
     */
   
    
    
}
-(ContentTextManager *)drawManager{
    if (!_drawManager) {
        _drawManager=[[ContentTextManager alloc]init];
    }
    return _drawManager;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject]locationInView:self.contentView];
    startLocation=point;
    if ([self.headrImgLayer touchBeginPoint:point]) {
        hasTouchContent=NO;
        return;
    }
    for (LWImageLayer *layer in self.imgsLayerArr) {
        if ([layer touchBeginPoint:point]) {
            hasTouchContent=NO;
            return;
        }
    }
    for (NSString *key in self.drawManager.framesDict) {
        CGRect frame = [[self.drawManager.framesDict valueForKey:key] CGRectValue];
        if (CGRectContainsPoint(frame, startLocation)) {
            NSRange tapRange = NSRangeFromString(key);
            for (NSString *rangeString in self.drawManager.ranges) {
                NSRange myRange = NSRangeFromString(rangeString);
                if (NSLocationInRange(tapRange.location, myRange)) {
                    NSArray *rects = self.drawManager.relationDict[rangeString];
                    [self fillContent:rects];
                    hasTouchContent=NO;
                    //            self.linkString = [self.contentString substringWithRange:myRange];
                    return;
                }
            }
        }
    }

    
    if (CGRectContainsPoint(_model.topicRect, point)) {
        [self fillContent:@[NSStringFromCGRect(_model.topicRect)]];
        return;
    }
    
    if (CGRectContainsPoint(_model.nicknameRect, point)) {
        [self fillContent:@[NSStringFromCGRect(_model.nicknameRect)]];
        hasTouchContent=NO;
        return;
    }
    if (CGRectContainsPoint(_model.contentRect, point)) {
            hasTouchContent=YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (hasTouchContent) {
                [self fillContent:@[NSStringFromCGRect(_model.contentRect)]];
                [self becomeFirstResponder];
                UIMenuItem * item = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyText)];
                [[UIMenuController sharedMenuController] setTargetRect:CGRectMake(point.x-20,point.y-10 ,0 , 0) inView:self.contentView];
                [UIMenuController sharedMenuController].menuItems = @[item];
                [UIMenuController sharedMenuController].menuVisible = YES;
            }
           
        });
        
    }

    
   
     NSLog(@"begin  %@",NSStringFromCGPoint(point));
}
-(void)copyText{
    [CommonFuncation copyTextClipboard:_model.content];
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
-(BOOL) canPerformAction:(SEL)action withSender:(id)sender{
    
    if (action == @selector(copyText)) {
        
        return YES;
        
    }
    
    return NO; //隐藏系统默认的菜单项
    
}


-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.headrImgLayer touchCancelPoint];
    for (LWImageLayer *layer in self.imgsLayerArr) {
        [layer touchCancelPoint];
    }
    [self fillContent:nil];
    hasTouchContent=NO;
    [self.copyV hideWithAnimation];
    NSLog(@"cancel");

}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"move");
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject]locationInView:self];
    [self.headrImgLayer touchEndPoint:point action:^(UIImage *image, CGRect frame) {
        NSLog(@"点击头像");
    }];
    for (LWImageLayer *layer in self.imgsLayerArr) {
        [layer touchEndPoint:point action:^(UIImage *image, CGRect frame) {
            NSLog(@"点击图片 %@",image);
            CollectImgModel*model=[[CollectImgModel alloc]init];
            model.imgArr=_model.High_ImagesArr;
            model.thumbImgArr=_model.Thumb_ImagesArr;
            model.selectIndex=[_model.imageRectArr indexOfObject:[NSValue valueWithCGRect:frame]];
            model.positionArr=_model.imageRectArr;
            model.superView=self;
           
            [self browsImgsWithModel:model];
        }];
    }
    for (NSString *rectStr in self.tagRectArr) {
        CGRect frame=CGRectFromString(rectStr);
        if (CGRectContainsPoint(frame, point)) {
            NSInteger index=[self.tagRectArr indexOfObject:rectStr];
            [self processTagToglle:index];
            
        }
        
    }
    [self.commentLayer touchEnd:point beginPoint:startLocation];
    
    
  
   
    
    for (NSString *key in self.drawManager.framesDict) {
        CGRect frame = [[self.drawManager.framesDict valueForKey:key] CGRectValue];
        NSRange tapRange = NSRangeFromString(key);
        if (CGRectContainsPoint(frame, startLocation)) {
            if (CGRectContainsRect(self.model.contentRect, frame)) {
                NSString *substring=[self.model.content substringWithRange:tapRange];
                NSLog(@"%@",substring);
                           }
            if (CGRectContainsRect(self.model.topicRect, frame)) {
                 NSString *substring=[self.model.topic_id substringWithRange:tapRange];
                NSLog(@"%@",substring);

               
            }
            
        }
    }
    
  
    

    [self fillContent:nil];
    hasTouchContent=NO;
    [self.copyV hideWithAnimation];
    
}

-(void)processTagToglle:(NSInteger)index{
    if (index==1) {
        _model.commentlikestatues=[NSNumber numberWithBool:![_model.commentlikestatues boolValue]];
        if (_model.commentlikestatues.boolValue) {
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectFromString(self.tagRectArr[1])];
            image.image=Image(@"icon_点赞_2");
            [self.contentView addSubview:image];
            
           [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
               image.transform=CGAffineTransformMakeScale(1.5, 1.5);
           } completion:^(BOOL finished) {
               [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                   image.transform=CGAffineTransformMakeScale(1, 1);
               } completion:^(BOOL finished) {
                   [image removeFromSuperview];
                  
               }];
           }];
        }
        
    }else if (index==2){
        
    }else if (index==3){
        
    }
   
}
-(void)clearLayer{
    [self.headrImgLayer removeFromSuperlayer];
    [self.headrImgLayer cancelLoadImg];
    for (LWImageLayer *layer in self.imgsLayerArr) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
        [layer cancelLoadImg];

    }
    for (UIView *v in self.contentView.subviews ) {
        [v removeFromSuperview];
    }
    [self.commentLayer clearLayer];
    [self.commentLayer removeFromSuperlayer];
    [self.minLineLayer removeFromSuperlayer];
    [self.lineLayer removeFromSuperlayer];
    [self.playerView removeFromSuperview];
    self.drawManager.framesDict=nil;
    self.drawManager.relationDict=nil;
    self.drawManager.ranges=nil;
    self.drawManager=nil;
    
    [self.playerView prepareToDismiss];
    self.playerView=nil;
    self.commentLayer=nil;
}
-(void)browsImgsWithModel:(CollectImgModel*)model;{
    dispatch_async(dispatch_get_main_queue(), ^{
        

    NSMutableArray* tmp = [NSMutableArray array];
    for (NSInteger i = 0; i < model.imgArr.count; i ++) {
        NSValue *rec=model.positionArr[i];
        LWImageBrowserModel* imageModel = [[LWImageBrowserModel alloc] initWithplaceholder:nil
                                                                              thumbnailURL:[NSURL URLWithString:model.thumbImgArr[i]]
                                                                                     HDURL:[NSURL URLWithString:[model.imgArr objectAtIndex:i]]
                                                                        imageViewSuperView:model.superView
                                                                       positionAtSuperView:rec.CGRectValue
                                                                                     index:i];
        [tmp addObject:imageModel];
    }
    LWImageBrowser* imageBrowser = [[LWImageBrowser alloc] initWithParentViewController:_model.vc
                                                                                  style:LWImageBrowserAnimationStyleScale
                                                                            imageModels:tmp
                                                                           currentIndex:model.selectIndex];
    imageBrowser.delegate=self;
           [imageBrowser show];
    });
   
    
}
-(void)imageBrowserDidFinish{
    
    for (CALayer *layer in self.imgsLayerArr) {
        [layer removeFromSuperlayer];
    }
    
    [self processImgs:nil];
   
}
@end
