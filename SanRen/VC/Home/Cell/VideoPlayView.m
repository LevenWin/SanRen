//
//  VideoPlayView.m
//  SanRen
//
//  Created by 吴狄 on 16/11/1.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "VideoPlayView.h"
#import "SlideView.h"
#import "WMPlayer.h"
#import "LWImageLayer.h"
#define WIDTH  UISCREEN_WIDTH-2*kSpec
@interface VideoPlayView()<WMPlayerDelegate>{
    BOOL isSmallScreen;
}
@property (nonatomic,retain)LWImageLayer *videoImg;
@property (nonatomic,retain)LWImageLayer *playImg;

@property (nonatomic,retain)UIButton *playBtn;
@property (nonatomic,retain)UIImageView *bgImage;
//@property (nonatomic,retain)UIButton *fullScreenBtn;
//@property (nonatomic,retain)UIButton *closeBtn;
//@property (nonatomic,retain)UIView *topControlView;
//@property (nonatomic,retain)UIView *bottomControlView;
//@property (nonatomic,retain)SlideView *slideView;
//
@property (nonatomic,retain)UIView *prePlayConatinerView;
@property (nonatomic,retain)WMPlayer *player;
@end

@implementation VideoPlayView
-(LWImageLayer*)videoImg{
    if (!_videoImg) {
        _videoImg=[[LWImageLayer alloc]init];
    }
    return _videoImg;
}
-(LWImageLayer*)playImg{
    if (!_playImg) {
        _playImg=[[LWImageLayer alloc]init];
    }
    return _playImg;
}
-(void)setModel:(VideoModel *)model{
    _model=model;
    self.layer.masksToBounds=YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    
//    self.prePlayConatinerView=[[UIView alloc]initWithFrame:self.bounds];
//    [self addSubviewAtCenter:self.prePlayConatinerView];
    
   //视频图片
    
    [self.videoImg setImageUrl:_model.coverImage];
    self.videoImg.frame=self.bounds;
//    self.bgImage=[[UIImageView alloc]initWithFrame:self.bounds];
//    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_model.coverImage]];
    [self.layer addSublayer:self.videoImg];
   //播放按钮
    UIImage *img=Image(@"video_play_btn_bg.png");
    self.playImg.originImage=img;
    [self.playImg setContents:(id _Nullable)img.CGImage];
    self.playImg.frame=CGRectMake(self.width_gst/2-25, self.height_gst/2-25, 50, 50);
  
    [self.layer addSublayer:self.playImg];
//    self.playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.playBtn setImage:Image(@"video_play_btn_bg.png") forState:UIControlStateNormal];
//    [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.playBtn.frame=CGRectMake(0, 0, 50, 50);
//    [self.prePlayConatinerView addSubviewAtCenter:self.playBtn];
    
    if (self.model.state==WMPlayerStatePlaying||self.model.state==WMPlayerStatusReadyToPlay) {
        self.playBtn.selected=YES;
        [self playVideo];

    }
   

}

//
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (self.player==nil||self.player.superview==nil){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (self.player.isFullscreen) {
                if (isSmallScreen) {
                    //放widow上,小屏显示
//                    [self toSmallScreen];
                }else{
                    [self toCell];
                }
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            self.player.isFullscreen = YES;
//            [UIApplication sharedApplication]
//            [self.model.vc setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            self.player.isFullscreen = YES;
//            [self setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}

#pragma Mark ----Action
-(void)playBtnClick:(UIButton*)sender{
//      sender.selected=!sender.selected;
//    if (sender.selected) {
        [self playVideo];
        
//    }else{
//        [self pauseVideo];
//    }
}
-(void)playVideo{
    if (self.player) {
        [self releaseWMPlayer];
    }
   
    self.player=[[WMPlayer alloc]initWithFrame:self.bounds];
    self.player.delegate = self;
    self.player.closeBtnStyle = CloseBtnStyleClose;
    self.player.URLString = self.model.videoUrl;
//    [self insertSubview:self.player aboveSubview:self.prePlayConatinerView];
    [self addSubview: self.player];
    self.player.seekTime=self.model.seekTime;
    [self.player play];

}
-(void)pauseVideo{
    
}

/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer{
    [self.player.player.currentItem cancelPendingSeeks];
    [self.player.player.currentItem.asset cancelLoading];
    [self.player pause];
    
    
    [self.player removeFromSuperview];
    [self.player.playerLayer removeFromSuperlayer];
    [self.player.player replaceCurrentItemWithPlayerItem:nil];
    self.player.player = nil;
    self.player.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [self.player.autoDismissTimer invalidate];
    self.player.autoDismissTimer = nil;
    
    
    self.player.playOrPauseBtn = nil;
    self.player.playerLayer = nil;
    self.player=nil;
}

#pragma Mark ---delegate

//点击播放暂停按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    if (playOrPauseBtn.isSelected) {
        self.model.state=WMPlayerStateStopped;
    }else{
        self.model.state=WMPlayerStatePlaying;
    }
}
//点击关闭按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
//    [self bringSubviewToFront:self.prePlayConatinerView];
    self.model.state=WMPlayerStateFinished;
    self.model.seekTime=0;
    [self releaseWMPlayer];
    
}
//点击全屏按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (fullScreenBtn.isSelected) {//全屏显示
        self.player.isFullscreen = YES;
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        if (isSmallScreen) {
            //放widow上,小屏显示
//            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }

}
//单击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    
}
//双击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    
}

///播放状态
//播放失败的代理方法
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    
}
//准备播放的代理方法
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    
}
//播放完毕的代理方法
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    self.model.state=WMPlayerStateFinished;
    self.model.seekTime=0;
    [self bringSubviewToFront:self.prePlayConatinerView];
    
    [self releaseWMPlayer];

}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [self.player removeFromSuperview];
    self.player.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        self.player.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        self.player.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.player.frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT);
    self.player.playerLayer.frame =  CGRectMake(0,0, UISCREEN_HEIGHT,UISCREEN_WIDTH);
    [[UIApplication sharedApplication].keyWindow addSubview:self.player];
    
    self.player.fullScreenBtn.selected = YES;
    [self.player bringSubviewToFront:self.player.bottomView];
    
    [self.player.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(UISCREEN_HEIGHT);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(UISCREEN_WIDTH-40);
        make.left.equalTo(self.player).with.offset(0);
    }];
    
    [self.player.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(self.player).with.offset(0);
        make.width.mas_equalTo(UISCREEN_HEIGHT);
    }];
    
    [self.player.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.player).with.offset((-UISCREEN_HEIGHT/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(self.player).with.offset(5);
        
    }];
    
    [self.player.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.player.topView).with.offset(45);
        make.right.equalTo(self.player.topView).with.offset(-45);
        make.center.equalTo(self.player.topView);
        make.top.equalTo(self.player.topView).with.offset(0);
    }];
    
    [self.player.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(UISCREEN_HEIGHT);
        make.center.mas_equalTo(CGPointMake(UISCREEN_WIDTH/2-36, -(UISCREEN_WIDTH/2)));
        make.height.equalTo(@30);
    }];
    
    [self.player.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(UISCREEN_WIDTH/2-37, -(UISCREEN_WIDTH/2-37)));
    }];
    [self.player.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(UISCREEN_HEIGHT);
        make.center.mas_equalTo(CGPointMake(UISCREEN_WIDTH/2-36, -(UISCREEN_WIDTH/2)+36));
        make.height.equalTo(@30);
    }];
    
}
-(void)toCell{
    WMPlayer *wmPlayer=self.player;
    [wmPlayer removeFromSuperview];
   
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = self.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [self addSubview:wmPlayer];
        [self bringSubviewToFront:wmPlayer];
        
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        isSmallScreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[touches.anyObject locationInView:self];
    if (CGRectContainsPoint(self.playImg.frame, point)) {
        [self.playImg hightLightedImage];
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[touches.anyObject locationInView:self];
    if (CGRectContainsPoint(self.playImg.frame, point)) {
        [self.playImg unHightLightedImage];
        [self playVideo];
    }
}
-(void)prepareToDismiss{
    self.model.seekTime=self.player.currentTime;
    self.model.state=self.player.state;
    [self.videoImg cancelLoadImg];
    [self.playImg removeFromSuperlayer];
    [self.videoImg removeFromSuperlayer];
    self.videoImg=nil;
    self.videoImg=nil;
    [self releaseWMPlayer];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}
@end
