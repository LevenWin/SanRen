//
//  CommentModel.m
//  SanRen
//
//  Created by 吴狄 on 16/10/31.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "CommentModel.h"
#define Avator_Width 30
#define Nickname_Font [UIFont systemFontOfSize:14]
#define Content_Font  [UIFont systemFontOfSize:14]
#define Time_Font  [UIFont systemFontOfSize:12]

#define WIDTH ScreenWidth-2*kSpec-minSpec*3-Avator_Width
@implementation CommentModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    [self setValuesForKeysWithDictionary:dic];
    [self processData];
    return self;
}

-(void)processData{
    CGFloat cellHeight=minSpec;
    //content;
    
    CGSize contentSize=[self.comment sizeWithConstrainedToWidth:WIDTH fromFont:Content_Font lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
        //nickname
    CGSize nicknameSize=[self.uUsername sizeWithConstrainedToWidth:WIDTH fromFont:Nickname_Font lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
   
    
    //time
    CGSize timeSize=[self.createTime sizeWithConstrainedToWidth:ScreenWidth-2*kSpec fromFont:Time_Font lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
    //time
    CGSize zanSize=[NSStringFromeObj(self.commentZanner) sizeWithConstrainedToWidth:ScreenWidth-2*kSpec fromFont:Time_Font lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
    
    cellHeight=minSpec+Avator_Width+minSpec+contentSize.height+kSpec;
    self.nicknameRect=CGRectMake(minSpec*2+Avator_Width, 0, nicknameSize.width, nicknameSize.height);
    self.contentRect=CGRectMake(Avator_Width+2*minSpec, Avator_Width+2*minSpec, contentSize.width, contentSize.height);
    self.timeRect=CGRectMake(Avator_Width+2*minSpec, timeSize.height+kSpec, timeSize.width, timeSize.height);
    self.avatorRect=CGRectMake(minSpec, minSpec, Avator_Width, Avator_Width);
    
    self.zanRect=CGRectMake(UISCREEN_WIDTH-30, 7, zanSize.width, zanSize.height);

    self.containerHeight=cellHeight;
}

@end
