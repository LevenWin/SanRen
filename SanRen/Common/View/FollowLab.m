//
//  FollowLab.m
//  FollowBtn
//
//  Created by 吴狄 on 16/8/9.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "FollowLab.h"
#define NORAML_TITLE_COLOR      [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]

#define NORAML_BG_COLOR      [UIColor colorWithRed:0.9231 green:0.6544 blue:0.2192 alpha:1.0]
#define FOLLOW_BG_COLOR      [UIColor colorWithRed:0.9548 green:0.9548 blue:0.9548 alpha:1.0]
#define FOLLOW_TITLE_COLOR      [UIColor colorWithRed:0.6685 green:0.6685 blue:0.6685 alpha:1.0]
#define FONT [UIFont systemFontOfSize:14]


@interface FollowLab(){
    BOOL isTouchAnimation;
    BOOL isOutside;
}
@property (nonatomic,retain)NSOperationQueue *queue;

@property (nonatomic,retain)NSBlockOperation *touchOp;
@property (nonatomic,retain)NSBlockOperation *untouchOp;

@end
@implementation FollowLab
-(void)awakeFromNib{
    
    self.hasFollowed=NO;
    [self processLayer];
    
}
-(void)processLayer{
    self.layer.cornerRadius=4;
    self.layer.masksToBounds=YES;
    
    self.userInteractionEnabled=YES;
    [self becomeFirstResponder];
    
    self.queue=[NSOperationQueue mainQueue];
    
   
    

}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.hasFollowed=YES;
        [self processLayer];
    }
    return self;
}
-(void)setup{
    if (self.hasFollowed) {
        self.text=@"已经关注";
        self.textColor=FOLLOW_TITLE_COLOR;
        [UIView animateWithDuration:0.2 animations:^{
            self.layer.backgroundColor=FOLLOW_BG_COLOR.CGColor;

        }];
        
    }else{
        self.text=@"+ 关注";
        self.textColor=NORAML_TITLE_COLOR;
        [UIView animateWithDuration:0.2 animations:^{
            self.layer.backgroundColor=NORAML_BG_COLOR.CGColor;
            
        }];

    }
    self.layoutMargins=UIEdgeInsetsMake(5, 5, 5, 5);
    self.font=FONT;
    self.textAlignment=NSTextAlignmentCenter;

}
-(void)setHasFollowed:(BOOL)hasFollowed{
    _hasFollowed=hasFollowed;
    [self setup];
}
#pragma mark Animation
-(void)handleAnimation{
    
}
/**
 *  怎么做到上个动画执行完，下个动画在执行？
 */
-(void)touchAnimation{
    

    isOutside=NO;
    
        [UIView animateWithDuration:0.29 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            isTouchAnimation=YES;
            self.userInteractionEnabled=NO;
            
            self.transform=CGAffineTransformMakeScale(0.7, 0.7);
        } completion:^(BOOL finished) {
            isTouchAnimation=NO;
            self.userInteractionEnabled=YES;
            NSLog(@"我执行完了");
        }];

  
    

}
-(void)untouchAnimation{
    


    if (!isOutside) {
                  [UIView animateWithDuration:0.29 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.userInteractionEnabled=NO;
                
                self.transform=CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                self.hasFollowed=!self.hasFollowed;
                self.userInteractionEnabled=YES;
                
                if (self.followBlock) {
                    self.followBlock(self.hasFollowed);
                }
                
            }];
            

        }

}
#pragma mark Touch Action
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.touchOp=[NSBlockOperation blockOperationWithBlock:^{
        [self touchAnimation];
    }];
    [self.queue addOperation:self.touchOp];
//    [self touchAnimation];
    NSLog(@"点击了");
    
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.untouchOp=[NSBlockOperation blockOperationWithBlock:^{
        [self untouchAnimation];
    }];
    [self.queue addOperation:self.untouchOp];
    [self.untouchOp addDependency:self.touchOp];

    NSLog(@"s松开了了");

}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.untouchOp=[NSBlockOperation blockOperationWithBlock:^{
        [self untouchAnimation];
    }];
    [self.queue addOperation:self.untouchOp];
    [self.untouchOp addDependency:self.touchOp];
//    [self untouchAnimation];

    NSLog(@"松开了");

}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    CGPoint point=[touch locationInView:self];
    if ((self.frame.size.width>point.x&&point.x>=0)&&(self.frame.size.height>point.y&&point.y>=0)) {
        
    }else{
        if (!isOutside) {
//            [self untouchAnimation];
            self.untouchOp=[NSBlockOperation blockOperationWithBlock:^{
                [self untouchAnimation];
            }];
            [self.queue addOperation:self.untouchOp];
            [self.untouchOp addDependency:self.touchOp];

            
            isOutside=YES;

        }

    }
    
    
}
@end

