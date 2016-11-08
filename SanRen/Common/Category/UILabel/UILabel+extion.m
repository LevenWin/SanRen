//
//  UILabel+extion.m
//  HJMJ
//
//  Created by Leven on 16/4/30.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "UILabel+extion.h"

@implementation UILabel (extion)
static char *LABELTYPE;
-(void)setLabelType:(ThemeLabeType)labelType{
    objc_setAssociatedObject(self,LABELTYPE, @(labelType), OBJC_ASSOCIATION_ASSIGN);
    switch (labelType) {
        case THEME_COMMENT_NICKNAME:
            
            
            break;
        case THEME_NICKNAME:
            
            break;
        case THEME_TIME:
            
            break;
        case THEME_CONTENT:
            [self setvds];
            break;
        case THEME_SCHOOL:
            break;
        case THEME_COMMENT_TIME:
            break;
        case THEME_COMMENT_TEXT:
            break;
        case THEME_NORMAL_BIG:
            break;
        case THEME_NORMAL_MIDDLE:
            break;
        case THEME_NORMAL_SMALL:
            break;
        case THEME_NORMAL_TINY:
            break;
        default:
            break;
    }
}
-(void)setvds{
    self.font=[UIFont systemFontOfSize:16];
    self.textColor=[UIColor blackColor];
    self.numberOfLines=0;
    NSAttributedString *attribute = [[NSMutableAttributedString alloc] init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10.0];
    self.attributedText=attribute;

}
-(ThemeLabeType)labelType{
    ThemeLabeType type=[objc_getAssociatedObject(self, LABELTYPE) integerValue];
    return type;
}
-(NSDictionary*)attrDic{
    switch (self.labelType) {
        case THEME_COMMENT_NICKNAME:
            
            
            break;
        case THEME_NICKNAME:
            
            break;
        case THEME_TIME:
            
            break;
        case THEME_CONTENT:
        {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:10.0];

            return @{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor,NSParagraphStyleAttributeName:attributedString};
        }
           
            break;
        case THEME_SCHOOL:
            break;
        case THEME_COMMENT_TIME:
            break;
        case THEME_COMMENT_TEXT:
            break;
        case THEME_NORMAL_BIG:
            break;
        case THEME_NORMAL_MIDDLE:
            break;
        case THEME_NORMAL_SMALL:
            break;
        case THEME_NORMAL_TINY:
            break;
        default:
            break;
    }
    return @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
}

-(UILabel *(^)(UIFont *))setFont{
    
    return ^(UIFont *font){
        self.font=font;
        return self;
    };
}
-(UILabel *(^)(NSString *))setText{
    
    return ^(NSString *text){
        self.text=text;
        return self;
    };
}
-(UILabel *(^)(UIColor*))setTextColor{
    
    return ^(UIColor *textcolor){
        self.textColor=textcolor;
        return self;
    };
}
-(UILabel *(^)(CGFloat ))setRadius{
    
    return ^(CGFloat  radius){
        self.layer.cornerRadius=radius;
        self.layer.masksToBounds=YES;
        return self;
    };
}
-(UILabel *(^)(UIColor*))setBackgroundColor{
    
    return ^(UIColor *bgColor){
        self.backgroundColor=bgColor;
        return self;
    };
}
-(UILabel *(^)(NSTextAlignment))settextAlignment{
    
    return ^(NSTextAlignment textAlignment){
        self.textAlignment=textAlignment;
        return self;
    };
}

@end
