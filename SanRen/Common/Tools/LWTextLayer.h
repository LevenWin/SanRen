//
//  LWTextLayer.h
//  DrawCellTest
//
//  Created by 吴狄 on 16/10/19.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
typedef void(^TapBlock)(NSString *text,NSRange range);

@interface LWTextLayer : CALayer
/**
 * 两种选择。
    1.直接设置 content，里面的字符自动识别，不过，需识别的字符，前后必须有空格。
    例如  我查过 www:google.com 了。我觉的可以做出来 @Lw 你绝的呢？
    2.自己截取需识别的字符与range，传入本类。则前后不需要空格
    我查过www:google.com了。我觉的可以做出来@Lw你绝的呢？
 */
@property (nonatomic,retain)UIFont *font;
@property (nonatomic,retain)NSMutableDictionary *tagDic;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)TapBlock tagTapBlock;

@end
