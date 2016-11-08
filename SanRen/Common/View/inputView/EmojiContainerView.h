//
//  EmojiContainerView.h
//  LWInputView
//
//  Created by 吴狄 on 16/9/7.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InputType) {
    InputEmoji,
    InputDefault
   
};

typedef  void (^InputBlock) (id);

@interface EmojiContainerView : UIView
+(instancetype)shareInstance;
-(void)setType:(InputType)type select:(InputBlock)block;
@end
