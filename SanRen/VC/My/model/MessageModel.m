//
//  MessageModel.m
//  SanRen
//
//  Created by 吴狄 on 16/10/31.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "MessageModel.h"
@implementation MessageModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    [self setValuesForKeysWithDictionary:dic];
    //随机插入视频
    
//    if (arc4random_uniform(100)%2==1) {
//        [self setValue:@"http://flv2.bn.netease.com/videolib3/1611/02/iCmRk9652/SD/iCmRk9652-mobile.mp4" forKey:@"video"];
//        self.images=@"";
//        VideoModel *model=[[VideoModel alloc]init];
//        model.videoUrl=self.video;
//        model.coverImage=@"http://vimg2.ws.126.net/image/snapshot/2016/11/N/V/VC3U520NV.jpg";
//        model.seekTime=0;
//        self.videoModel=model;
//
//    }

    
    self.imageRectArr=[NSMutableArray array];
    self.High_ImagesArr=[NSMutableArray array];
    self.Thumb_ImagesArr=[NSMutableArray array];

    [self processData];
    return self;
    
}
-(void)processData{
    self.cellHeight=0;
    
    
    CGFloat cellHeight=minSpec;
    //content;
    self.contentSize=[self.content sizeWithConstrainedToWidth:ScreenWidth-kSpec fromFont:kContentTextFont lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
   
    //nickname
    self.nicknameSize=[self.nickname sizeWithConstrainedToWidth:ScreenWidth-2*kSpec fromFont:kNicknameFont lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
   
    
    //university
    self.schoolSize=[self.school sizeWithConstrainedToWidth:ScreenWidth-2*kSpec fromFont:kUniversityFont lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
    

    
    //topic
     self.topicSize=[self.topic_id sizeWithConstrainedToWidth:ScreenWidth-2*kSpec fromFont:kContentTextFont lineSpace:0 lineBreakMode:kCTLineBreakByWordWrapping];
    
    
    
    if (self.topic_id&&self.topic_id.length>0) {
        cellHeight=kAvatar+2*kSpec+self.contentSize.height+kSpec+self.topicSize.height+minSpec+minSpec;
    }else{
        cellHeight=kAvatar+2*kSpec+self.contentSize.height+kSpec;
    }
    
    //底部评论
    NSDictionary *dic=self.conmit;
    if (dic&&[dic isKindOfClass:[NSDictionary class]]&&dic.allKeys.count>0) {
        CommentModel *model=[[CommentModel alloc]initWithDic:dic];
        self.commonModel=model;
        
//        self.cellHeight+=model.containerHeight+minSpec;
        cellHeight+=model.containerHeight+minSpec;
        
    }

    
    
    self.nicknameRect=CGRectMake(kSpec*2+kAvatar, minSpec, self.nicknameSize.width, self.nicknameSize.height);
    self.schoolRect=CGRectMake(kSpec*2+kAvatar, self.nicknameSize.height+2*minSpec, self.schoolSize.width, self.schoolSize.height);
    self.contentRect=CGRectMake(kSpec, kSpec+kAvatar+kSpec, UISCREEN_WIDTH-2*kSpec, self.contentSize.height);
    self.topicRect=CGRectMake(kSpec, kSpec+kAvatar+kSpec+minSpec+self.contentSize.height, UISCREEN_WIDTH-2*kSpec, self.topicSize.height);
    //是否有视频
    
    if (self.video&&self.video.length>0) {
        self.videoRect=CGRectMake(kSpec, kSpec+kAvatar+kSpec+self.contentSize.height+kSpec, UISCREEN_WIDTH-2*kSpec, UISCREEN_WIDTH/2);
        cellHeight+=self.videoRect.size.height+minSpec;
        
        
        self.topicRect=CGRectMake(kSpec,kSpec+kAvatar+kSpec+minSpec+self.contentSize.height+self.videoRect.size.height+kSpec , UISCREEN_WIDTH-2*kSpec, self.topicSize.height);
        
        self.cellHeight=cellHeight+kSpec+40;
       
        
        return;
        
    }else{
        //contentImage
        NSString *imagesStr=self.images;
        if (imagesStr&&[imagesStr isKindOfClass:[NSNull class]]) {
            imagesStr=@"";
        }
        
        NSArray *imgArr=[[imagesStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@","];
        
        if (imgArr.count>0&&[imgArr.firstObject length]>0) {
            CGFloat height;
            if (imgArr.count==1) {
                cellHeight+=ScreenWidth;
                height=ScreenWidth;
            }else if (imgArr.count==2){
                cellHeight+=(ScreenWidth-kImageGap)/2;
                height=(ScreenWidth-kImageGap)/2;
            }else if (imgArr.count==4){
                cellHeight+=(ScreenWidth-kImageGap)/2*2+kImageGap;
                height=(ScreenWidth-kImageGap)/2*2+kImageGap;
            }else if (imgArr.count==3){
                cellHeight+=(ScreenWidth-2*kImageGap)/3;
                height=(ScreenWidth-2*kImageGap)/3;
            }else if (imgArr.count==5||imgArr.count==6){
                cellHeight+=(ScreenWidth-2*kImageGap)/3+kImageGap+(ScreenWidth-2*kImageGap)/3;
                height=(ScreenWidth-2*kImageGap)/3+kImageGap+(ScreenWidth-2*kImageGap)/3;
                
            }else{
                cellHeight+=(ScreenWidth-2*kImageGap)/3*3+2*kImageGap;
                height=(ScreenWidth-2*kImageGap)/3*3+2*kImageGap;
                
            }
           
            //话筒在图片下面
            self.topicRect=CGRectMake(kSpec,kSpec+kAvatar+kSpec+minSpec+self.contentSize.height+height+kSpec , UISCREEN_WIDTH-2*kSpec, self.topicSize.height);
            self.cellHeight=cellHeight+kSpec+40;
        }else{
             self.cellHeight=cellHeight+kSpec+40;
        }
        
       
       
            
        
        
        
        CGFloat imgWidth;
        if (imgArr.count==1) {
            imgWidth=ScreenWidth;
        }else if (imgArr.count==2||imgArr.count==4){
            imgWidth=(ScreenWidth-kImageGap)/2.0;
        }else {
            imgWidth=(ScreenWidth-2*kImageGap)/3.0;
        }
       

        
        
        
        CGFloat X=0;
        CGFloat Y=2*kSpec+2*minSpec+self.nicknameSize.height+self.schoolSize.height+self.contentSize.height;
        NSString *appendStr=nil;
        
        if (imgArr.count>0&&[imgArr.firstObject length]>0) {
            for (NSInteger i=0;i<imgArr.count;i++) {
                NSString *url=imgArr[i];
                
                [self.imageRectArr addObject:[NSValue valueWithCGRect:CGRectMake(X, Y, imgWidth, imgWidth)]];
                
                if (imgArr.count==2) {
                    X=X+imgWidth+kImageGap;
                    appendStr=[NSString stringWithFormat:@"?imageMogr2/thumbnail/%fx",ScreenWidth];
                }else if (imgArr.count==1){
                    appendStr=[NSString stringWithFormat:@"?imageMogr2/thumbnail/%fx",ScreenWidth*2];
                }else if (imgArr.count==4){
                    if ((i+1)%2==0) {
                        X=0;
                        Y+=kImageGap+imgWidth;
                    }else{
                        X+=kImageGap+imgWidth;
                        
                    }
                    appendStr=[NSString stringWithFormat:@"?imageMogr2/thumbnail/%fx",ScreenWidth];
                }else{
                    if ((i+1)%3==0) {
                        X=0;
                        Y+=kImageGap+imgWidth;
                    }else{
                        X+=kImageGap+imgWidth;
                    }
                    appendStr=[NSString stringWithFormat:@"?imageMogr2/thumbnail/%fx",ScreenWidth/2];
                }
                
                
                NSString *thumb_img=[NSString stringWithFormat:@"http://7xswdm.com1.z0.glb.clouddn.com/%@%@",url,appendStr];
                NSString *Hud_img=[NSString stringWithFormat:@"http://7xswdm.com1.z0.glb.clouddn.com/%@",url];
                
                [self.High_ImagesArr addObject:Hud_img];
                [self.Thumb_ImagesArr addObject:thumb_img];
                
                
            }
            
        }

    }
 
    

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
   
}
@end
