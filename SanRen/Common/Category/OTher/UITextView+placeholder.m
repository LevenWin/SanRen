//
//  UITextView+placeholder.m
//  SanRen
//
//  Created by 吴狄 on 16/10/23.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "UITextView+placeholder.h"
#import <objc/runtime.h>
#import "NSString+Additions.h"
@implementation UITextView (placeholder)
@dynamic placeholder;
static char *placeholderChar;
static char *placeholderLabelChar;
-(void)awakeFromNib{
    [super awakeFromNib];
    
    if (self.placeholder) {
        UILabel *placeholder=[[UILabel alloc]init];
        placeholder.font=self.font;
        placeholder.text=self.placeholder;
        placeholder.textColor=[UIColor lightGrayColor];
        
        placeholder.frame=CGRectMake(4, 8, self.frame.size.width,self.font.lineHeight);
        [self insertSubview:placeholder atIndex:0];
        
        objc_setAssociatedObject(self, &placeholderLabelChar, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        
         [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification * _Nonnull note) {
             UILabel *lab=objc_getAssociatedObject(self, &placeholderLabelChar);
             
             if (self.text.length==0) {
                 lab.hidden=NO;
                 
             }else{
                 lab.hidden=YES;
             }
             

         }];
        
    }
}
-(void)setPlaceholder:(NSString *)placeholder{
    objc_setAssociatedObject(self, &placeholderChar, placeholder, OBJC_ASSOCIATION_COPY);
}
-(NSString *)placeholder{
    return objc_getAssociatedObject(self, &placeholderChar);
}
@end
