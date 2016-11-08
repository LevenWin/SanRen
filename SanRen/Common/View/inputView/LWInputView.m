//
//  LWInputView.m
//  LWInputView
//
//  Created by 吴狄 on 16/9/7.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "LWInputView.h"
#import "EmojiContainerView.h"
#import "UIView+GaosutongExtension.h"
#define LW_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define LW_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define HEIGHT 80

#define TextContainerHeight 50
#define ToolBarHeight 30

#define ItemWidth 30

#define Margin 8



@interface LWInputView()<UITextViewDelegate>{
    BOOL shouldemoji;
    BOOL shouldTagSomeone;
    BOOL shouldPic;
    CGFloat keyBoardHeight;
    InputType currentInputType;
    

}
@property (nonatomic,retain)UIButton *emojiBtn;
@property (nonatomic,retain)UIButton *tagBtn;
@property (nonatomic,retain)UIButton *picBtn;
@property (nonatomic,retain)UILabel *holder;


@property (nonatomic,retain) UIView *textContainerView;
@property (nonatomic,retain) UIView *toolContainerView;

@property (nonatomic,retain)UIView *coverView;

@end
@implementation LWInputView
-(instancetype)initWithFrame:(CGRect)frame enableEmogi:(BOOL)emoji enableTagsomeone:(BOOL)tagsomeone enablePic:(BOOL)pic{
    
    if (self=[super initWithFrame:frame]) {
       
        
        shouldemoji=emoji;
        shouldPic=pic;
        shouldTagSomeone=tagsomeone;

        [self setup];
        [self addNotice];

    }
    
    return self;
}
-(void)setup{
    
    self.frame=CGRectMake(0, LW_SCREEN_HEIGHT-TextContainerHeight, LW_SCREEN_WIDTH, HEIGHT);
    self.layer.borderColor=[UIColor colorWithRed:0.817 green:0.817 blue:0.817 alpha:1.0].CGColor;
    self.layer.borderWidth=0.7;
    self.backgroundColor=[UIColor colorWithRed:0.9848 green:0.9848 blue:0.9848 alpha:1.0];
    //
    self.textContainerView=[[UIView alloc]initWithFrame:CGRectMake(Margin, Margin, LW_SCREEN_WIDTH-3*Margin-ItemWidth, TextContainerHeight-2*Margin)];
    self.textContainerView.layer.borderColor=[UIColor colorWithRed:0.8684 green:0.8684 blue:0.8684 alpha:1.0].CGColor;
    self.textContainerView.layer.cornerRadius=4;
    self.textContainerView.layer.masksToBounds=YES;
    self.textContainerView.layer.borderWidth=0.5;
    self.textContainerView.backgroundColor=[UIColor whiteColor];
    
    
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(Margin*0.5, 0, self.textContainerView.width_gst-0.5*Margin, self.textContainerView.height_gst)];
    [self.textContainerView addSubview:self.textView];
    self.textView.font=[UIFont systemFontOfSize:16];
    self.textView.returnKeyType=UIReturnKeySend;
    self.textView.delegate=self;
    
    self.emojiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.emojiBtn.frame=CGRectMake(LW_SCREEN_WIDTH-ItemWidth-2*Margin, 0, ItemWidth+2*Margin, ItemWidth+2*Margin);
    [self.emojiBtn setImage:[UIImage imageNamed:@"添加表情-"] forState:UIControlStateNormal];
    [self addSubview:self.textContainerView];
    [self addSubview:self.emojiBtn];

    
    
    self.toolContainerView=[[UIView alloc]initWithFrame:CGRectMake(0, TextContainerHeight, LW_SCREEN_WIDTH-2*Margin, ToolBarHeight)];
    
    
    self.tagBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.tagBtn.frame=CGRectMake(Margin, -0.5*Margin, ItemWidth, ItemWidth);
    
    [self.tagBtn setImage:[UIImage imageNamed:@"添加表情-"] forState:UIControlStateNormal];
    [self.tagBtn addTarget:self action:@selector(addTagPerson) forControlEvents:UIControlEventTouchUpInside];
    
    self.picBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.picBtn.frame=CGRectMake( Margin+ItemWidth+Margin,-0.5*Margin, ItemWidth, ItemWidth);
    [self.picBtn setImage:[UIImage imageNamed:@"添加表情-"] forState:UIControlStateNormal];
    [self.tagBtn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];

//    [self.toolContainerView addSubview:self.tagBtn];
//    [self.toolContainerView addSubview:self.picBtn];

    [self addSubview:self.toolContainerView];
    
    
}
-(void)refreshUIWithRec:(CGRect)frame{
    
    if (!(frame.size.height>self.textView.height_gst)&&self.textView.height_gst<=TextContainerHeight-2*Margin) {
        return;
    }
    if (frame.size.height>=70) {
        frame.size.height=70;
    }
    if (frame.size.height<=TextContainerHeight-2*Margin) {
        frame.size.height=TextContainerHeight-2*Margin;
        
    }

   [UIView animateWithDuration:0.2 animations:^{
        self.frame=CGRectMake(0, LW_SCREEN_HEIGHT-keyBoardHeight-frame.size.height-2*Margin, LW_SCREEN_WIDTH, ToolBarHeight+frame.size.height+2*Margin);
//       self.frame=CGRectMake(0, LW_SCREEN_HEIGHT-keyBoardHeight-ToolBarHeight-frame.size.height-2*Margin, LW_SCREEN_WIDTH, ToolBarHeight+frame.size.height+2*Margin);
       self.textContainerView.frame=CGRectMake(Margin, Margin, LW_SCREEN_WIDTH-3*Margin-ItemWidth, frame.size.height);
       self.textView.frame=CGRectMake(Margin*0.5, 0, self.textContainerView.width_gst-Margin*0.5, self.textContainerView.height_gst);
       self.toolContainerView.frame=CGRectMake(0, self.textContainerView.bottom_gst+Margin, LW_SCREEN_WIDTH, ToolBarHeight);
   }];
  
    

}
#pragma Lazy Load

-(UIView *)coverView{
    if (!_coverView) {
        _coverView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.0];
        __block typeof(self) blockself=self;
        [_coverView setTapAction:^(UIGestureRecognizer *tap) {
            blockself.textView.text=@"";
            [blockself.textView resignFirstResponder];
        }];
        
        
        
    }
    return _coverView;
}
-(UILabel*)holder{
    if (!_holder) {
        _holder=[[UILabel alloc]initWithFrame:CGRectMake(6, 0, 200, self.textView.height_gst)];
        _holder.text=self.placeHolder;
        _holder.textColor=[UIColor lightGrayColor];
        _holder.font=self.textView.font;
        _holder.userInteractionEnabled=NO;
        
    }
    return _holder;
}
#pragma mark Action
-(void)addTagPerson{
    if (currentInputType==InputEmoji) {
        self.textView.inputView=nil;
        [self.textView reloadInputViews];
        currentInputType=InputDefault;
    }else{
    
    currentInputType=InputEmoji;
    EmojiContainerView *input=[[EmojiContainerView alloc]initWithFrame:CGRectMake(0, 0, LW_SCREEN_WIDTH, 270)];
    [input setType:currentInputType select:^(id obj) {
        
    }];
    self.textView.inputView=input;
        [self.textView  resignFirstResponder];
    [self.textView reloadInputViews];
}
}
-(void)processHolder{
    
    if (self.placeHolder&&self.placeHolder.length>0) {
        self.holder.text=self.placeHolder;
    }else{
        self.holder.text=self.defaultHolder;

    }
   
    self.holder.hidden=NO;
    [self.textView addSubview:self.holder];
    
}
-(void)addPic{
    
}
#pragma mark UI
-(void)showAnimation{
    [self.superview insertSubview:self.coverView belowSubview:self];
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.top_gst=LW_SCREEN_HEIGHT-self.textContainerView.bottom_gst-keyBoardHeight-Margin;
        self.coverView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
        
    } completion:^(BOOL finished) {
        
    }];

    
}
-(void)hideAnimation{
     [self.holder removeFromSuperview];
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.top_gst=LW_SCREEN_HEIGHT-self.textContainerView.bottom_gst-Margin;
        self.coverView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0];
        
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        self.coverView=nil;
        self.textView.text=@"";
        self.placeHolder=nil;
        
        if (self.inputDidHide) {
            self.inputDidHide();
        }
        
    }];

}
#pragma TextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        
        if (self.textView.text.length>0) {
            if (self.backContent) {
                self.backContent(self.textView.text);
            }
            self.placeHolder=nil;
        }

        
        [self.textView resignFirstResponder];
       
        
        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    
    
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
     CGRect frame=[self.textView.layoutManager boundingRectForGlyphRange:NSMakeRange(0, textView.text.length) inTextContainer:self.textView.textContainer];
    [self refreshUIWithRec:frame];
    
    if (textView.text.length>0) {
        self.holder.hidden=YES;
    }else{
        self.holder.hidden=NO;
    }
    
}



#pragma mark Notice
-(void)addNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)showKeyboard:(NSNotification *)info{
    keyBoardHeight= [[info.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    [self processHolder];
    [self showAnimation];
  
}
-(void)hideKeyboard:(NSNotification*)info{
    [self hideAnimation];
    
}
@end
