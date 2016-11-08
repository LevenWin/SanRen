//
//  LWImageLayer.m
//  DrawCellTest
//
//  Created by 吴狄 on 16/10/20.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "LWImageLayer.h"
#include <ImageIO/ImageIO.h>
//static const CFIndex CATransactionCommitRunLoopOrder = 2000000;
//static const CFIndex POPAnimationApplyRunLoopOrder = CATransactionCommitRunLoopOrder - 1;
@interface LWImageLayer(){
    CFRunLoopObserverRef _oserver;
    CGPoint startLocation;
    
}

@end

@implementation LWImageLayer
-(void)setImageUrl:(NSString *)urlString{
    [self setImageUrl:urlString radius:0];
}
-(void)setImageUrl:(NSString *)urlString radius:(CGFloat)radius{
    _imgUrl=urlString;
     self.contents = (__bridge id _Nullable)([UIImage imageNamed:@"placeholder"].CGImage);

    @weakify(self)
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
   self.operation= [manager downloadImageWithURL:[NSURL URLWithString:urlString]
                          options:SDWebImageCacheMemoryOnly
                         progress:nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                @strongify(self)
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if (radius>0) {
                                        //保证 切圆角处理每张图进行了一次
                                        if (cacheType==SDImageCacheTypeNone) {
                                            self.originImage = [self radiusResizeImage:image radius:0.5];
                                            [[SDImageCache sharedImageCache]storeImage:self.originImage forKey:urlString];
                                        
                                        }else{
                                            self.originImage=[[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:urlString];
                                        }
                                    }else{
                                        //判断gif
                                        if (image.images&&image.images.count>0) {
                                            ;
                                            NSData *data=[NSData dataWithContentsOfURL:imageURL];
                                            
                                            [self showGIFImage:data];
                                            return ;
                                            
                                        }else{
                                             self.originImage = image;
                                            
                                        }
                                    }
                                   self.contents = (__bridge id _Nullable)(self.originImage.CGImage);
                                    
                                });
                            }
                        }];
    
    
}
-(void)cancelLoadImg{
    [self.operation cancel];
}
-(void)showGIFImage:(NSData *)data{
    NSMutableArray *frames=[NSMutableArray array];
    NSMutableArray *delayTimes=[NSMutableArray array];
    CGFloat totalTime=0;

    CGImageSourceRef gifSource =CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    
    
    // get frame count
    size_t frameCount = CGImageSourceGetCount(gifSource);
    
    if (frameCount==1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.contents = (__bridge id _Nullable)(self.originImage.CGImage);
            
        });
        return;
    }
    for (size_t i = 0; i < frameCount; ++i) {
        // get each frame
        CGImageRef frame = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        [frames addObject:(__bridge id)frame];
        CGImageRelease(frame);
        
        // get gif info with each frame
        NSDictionary *dict = (NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL));
        // kCGImagePropertyGIFDictionary中kCGImagePropertyGIFDelayTime，kCGImagePropertyGIFUnclampedDelayTime值是一样的
        NSDictionary *gifDict = [dict valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
        [delayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime]];
        
        
        totalTime = totalTime + [[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime] doubleValue];
        
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    NSMutableArray *times = [NSMutableArray arrayWithCapacity:delayTimes.count];
    CGFloat currentTime = 0;
    NSUInteger count = delayTimes.count;
    for (int i = 0; i < count; ++i) {
        currentTime = [[delayTimes objectAtIndex:i] doubleValue];
        [times addObject:[NSNumber numberWithDouble:currentTime/totalTime]];
    }
    [animation setKeyTimes:times];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:delayTimes.count];
    for (int i = 0; i < count; ++i) {
        [images addObject:[frames objectAtIndex:i]];
    }
    
    [animation setValues:images];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = totalTime;
    animation.delegate = self;
    animation.repeatCount = MAXFLOAT;
    [self removeAnimationForKey:@"gifAnimation"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addAnimation:animation forKey:@"gifAnimation"];
    });
}
#pragma mark Touch
-(BOOL)touchBeginPoint:(CGPoint )point{
    if (!self.originImage) return NO;

    startLocation=point;
    if (CGRectContainsPoint(self.frame, point)) {
        [self hightLightedImage];
        return YES;
    }
    return NO;
}
-(void)touchCancelPoint{
    if (!self.originImage) {
        return;
    }
    [self unHightLightedImage];
}
-(BOOL)touchEndPoint:(CGPoint)point action:(ImgResultBlock)block{
    if (!self.originImage) {
        return NO;
    }
    [self unHightLightedImage];
    if (CGRectContainsPoint(self.frame, point)&&CGRectContainsPoint(self.frame, startLocation)) {
        if (block) {
            block(self.originImage,self.frame);
            return YES;
        }
    }
    return NO;
}
-(void)hightLightedImage{
    if (!self.highlightImage) {
        self.highlightImage=[self colorizeImage:self.originImage WithColor:[UIColor darkGrayColor]];
    }
    self.contents=(__bridge id )(self.highlightImage.CGImage);
}
-(void)unHightLightedImage{
    self.contents = (__bridge id _Nullable)(self.originImage.CGImage);
}
#pragma mark other
-(UIImage*)radiusResizeImage:(UIImage*)image radius:(CGFloat)radius{
    CGRect rect = CGRectMake(0, 0, kAvatar, kAvatar);
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    //根据image 的width  切
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(kAvatar*2*radius, kAvatar*2*radius)];
    CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [image drawInRect:rect];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage* output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"********");
    return output;
    

}
- (UIImage *)colorizeImage:(UIImage*)image WithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    
    CGContextSaveGState(context);
    CGContextClipToMask(context, area, image.CGImage);
    
    [color set];
    CGContextFillRect(context, area);
    
    CGContextRestoreGState(context);
    
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    
    CGContextDrawImage(context, area, image.CGImage);
    
    UIImage *colorizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return colorizedImage;
}
-(void)setImgAnimation{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.4f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self addAnimation:transition forKey:nil];

}
-(void)clearPrendingListObserver{
    if (_oserver) {
        CFRunLoopRemoveObserver(CFRunLoopGetMain(), _oserver, kCFRunLoopCommonModes);
        CFRelease(_oserver);
        _oserver=NULL;
    }
}
@end
