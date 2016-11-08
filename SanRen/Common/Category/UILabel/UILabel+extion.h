//
//  UILabel+extion.h
//  HJMJ
//
//  Created by Leven on 16/4/30.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ThemeLabeType) {
    THEME_NICKNAME   =0,
    THEME_TIME       =1,
    THEME_CONTENT    =2,
    THEME_SCHOOL     =3,
    THEME_COMMENT_NICKNAME  =4,
    THEME_COMMENT_TIME  =5,
    THEME_COMMENT_TEXT  =6,
   
    THEME_NORMAL_BIG    =7,
    THEME_NORMAL_MIDDLE =8,
    THEME_NORMAL_SMALL  =9,
    THEME_NORMAL_TINY  =10,
};
@interface UILabel (extion)
@property (nonatomic,assign)ThemeLabeType labelType;
@property (nonatomic,readonly)NSDictionary *attrDic;

-(UILabel *(^)(UIFont *font))setFont;
-(UILabel *(^)(NSString *text))setText;
-(UILabel *(^)(UIColor *textcolor))setTextColor;
-(UILabel *(^)(CGFloat ))setRadius;
-(UILabel *(^)(UIColor*))setBackgroundColor;
-(UILabel *(^)(NSTextAlignment))settextAlignment;


@end
