//
//  LWInputView.h
//  LWInputView
//
//  Created by 吴狄 on 16/9/7.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWInputView : UIView
@property (nonatomic,retain)UITextView *textView;
@property (nonatomic,copy)NSString *placeHolder;
@property (nonatomic,copy)NSString *defaultHolder;

@property (nonatomic,copy)void(^backContent)(NSString *);
@property (nonatomic,copy)void(^inputDidHide)(void);

-(instancetype)initWithFrame:(CGRect)frame enableEmogi:(BOOL)emoji enableTagsomeone:(BOOL)tagsomeone enablePic:(BOOL)pic;
@end
