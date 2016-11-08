//
//  CmmonMacro.h
//  SevenNote
//
//  Created by URoad on 16/2/12.
//  Copyright © 2016年 Leven. All rights reserved.
//

#ifndef CmmonMacro_h
#define CmmonMacro_h
/**
 *  第三方账号
 *
 *  @return 
 */
//#define BaseUrl @"http://121.40.208.18/index.php?s=/Api/"

//#define DEBUG 1
//#define DEFAULT_IMG     [UIImage imageNamed:@""]
//#define NoNetReach @"NoNetReach"


//--------------------快速Define属性--------------------------------------------------------

#define propertyDef_String(__propertyName)\
@property(nonatomic,copy)NSString*__propertyName;

#define propertyDef_Int(__propertyName)\
@property(nonatomic,assign)int __propertyName;

#define propertyDef_Float(__propertyName)\
@property(nonatomic,assign)float __propertyName;

#define propertyDef_Double(__propertyName)\
@property(nonatomic,assign)double __propertyName;

#define propertyDef_NSMutableArray(__propertyName)\
@property(nonatomic,retain)NSMutableArray*__propertyName;

#define propertyDef_NSArray(__propertyName)\
@property(nonatomic,retain)NSArray*__propertyName;

#define propertyDef_NSMutableDictionary(__propertyName)\
@property(nonatomic,retain)NSMutableDictionary*__propertyName;

#define propertyDef_NSDictionary(__propertyName)\
@property(nonatomic,retain)NSDictionary*__propertyName;

#define propertyDef_id(__propertyName)\
@property(nonatomic,retain)id __propertyName;

#define propertyDef_BlockVoid(__propertyName)\
@property(nonatomic,strong) void(^ __propertyName)(void);

#define propertyDef_BlockObj(__propertyName)\
@property(nonatomic,strong) void(^ __propertyName)(id);

#define propertyDef_BlockIndex(__propertyName)\
@property(nonatomic,copy) void(^ __propertyName)(NSInteger);

#define propertyDef_UIView(__propertyName)\
@property(nonatomic,retain)UIView*__propertyName;

#define propertyDef_UILabel(__propertyName)\
@property(nonatomic,retain)UILabel*__propertyName;

#define propertyDef_UITableView(__propertyName)\
@property(nonatomic,retain)UITableView*__propertyName;


#define propertyDef_BlockCustomClass(__propertyName,__className)\
@property(nonatomic,strong) void(^ __propertyName)(__className*);


//--------------------快速激发block事件--------------------------------------------------------

/** 快速激发voidBlock */
#define raiseBlockVoid(__blockName)\
if(self.__blockName){\
self.__blockName();\
}

/** 快速激发voidBlock(blockSelf) */
#define raiseBlockVoidBlockSelf(__blockName)\
if(blockSelf.__blockName){\
blockSelf.__blockName();\
}


/** 快速激发objectBlock */
#define raiseBlockObj(__blockName,__object)\
if(self.__blockName){\
self.__blockName(__object);\
}

/**
 *  constant
 */
#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define BACK(SuccessBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), SuccessBlock);
#define MAIN(SuccessBlock) dispatch_async(dispatch_get_main_queue(),SuccessBlock);

/** 快速激发获取Image */

#define Image(name)\
[UIImage imageNamed:name]
#define HexColor(color)\
[UIColor colorWithHexString:color];



#ifdef DEBUG
#  define LOG(...) NSLog(__VA_ARGS__)
#  define LOG_CURRENT_METHOD NSLog(@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#else
#  define LOG(...) ;
#  define LOG_CURRENT_METHOD ;
#endif

#define __Block(blockSelf)\
 __block typeof(self) blockSelf=self;

#define PUSH(vc)\
[[AppTraceManager shareInstance].topViewController.navigationController pushViewController:vc animated:YES];
//[self.navigationController pushViewController:vc animated:YES];

#define POP(vc)\
[[AppTraceManager shareInstance].topViewController.navigationController popViewControllerAnimated:YES];

//UIWindow * kewindow =[[UIApplication sharedApplication]keyWindow];\
//UITabBarController * tabbar = (UITabBarController * ) kewindow.rootViewController;\
//UINavigationController *navi=tabbar.selectedViewController;\
//[navi popViewControllerAnimated:YES];


#define PRESENT(vc)\
UIWindow * kewindow =[[UIApplication sharedApplication]keyWindow];\
UITabBarController * tabbar = (UITabBarController * ) kewindow.rootViewController;\
UINavigationController *navigation=tabbar.selectedViewController;\
[navigation presentViewController:vc animated:YES completion:nil];

#define SET_TBVDELEGATE(tbv)\
 tbv.delegate=self;\
 tbv.dataSource=self;

/**
 *  宏定义函数
 *
 *  @return id
 */
typedef void  (^VoidBlock)(void);
typedef void (^SuccessBlock)(id obj);
typedef void (^FailureBlock)(id obj);
typedef void (^ErrorBlock)(id obj);
//typedef void (^TapBlock)(UIView* obj);

//#define TabBarHeight 50
//#define NaviBarHeight 64
//
//#define THEMECOLOR [UIColor colorWithRed:1.000 green:0.596 blue:0.288 alpha:1.000]
//
//#define NormalColor [UIColor colorWithRed:0.248 green:0.237 blue:0.250 alpha:1.000];
//#define DimColor [UIColor colorWithRed:0.6549 green:0.6453 blue:0.6645 alpha:1.0];
#define LineColor [UIColor colorWithRed:0.7915 green:0.78 blue:0.8029 alpha:1.0]
#define ThemeBlue [UIColor colorWithRed:39.6/255.0 green:109.1/255.0 blue:232.2/255.0 alpha:1.0]
#define THEME_COLOR COLOR(254, 232, 101, 1.0)
//#define BottomColor [UIColor colorWithRed:0.9897 green:0.9897 blue:0.9897 alpha:1.0];
//#define BackgroundColor HexColor(@"#AFAFAF");
//#define TextColor [UIColor colorWithRed:0.2794 green:0.278 blue:0.2807 alpha:1.0];
//#define NaviColor [UIColor colorWithRed:0.9706 green:0.9706 blue:0.9706 alpha:1.0];
//#define ClearColor [UIColor clearColor];
//#define  BoardLayerColor [UIColor colorWithWhite:0.815 alpha:1.000]
//#define NaviTitleColor [UIColor colorWithWhite:0.276 alpha:1.000];
//#define RightNaviBtnColor [UIColor colorWithWhite:0.318 alpha:1.000]


#define Theme_ContentFont

//-------------------打印日志-------------------------
//#define DEBUG 1
////DEBUG 模式下打印日志,当前行
//#ifdef DEBUG
//# define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//# define DLog(...)
//#endif

//重写NSLog,Debug模式下打印日志和当前行数
//#if DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, ［NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NSLog(FORMAT, ...) nil
//#endif

/**
 *  clear warning
 */
#define CLEARWARNING_SElECOR 
#pragma clang diagnostic ignored"-Wundeclared-selector"

#define CLEARWARNING_INT
#pragma clang diagnostic ignored"-Wshorten-64-to-32"

#define ENCODE(_className)\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([_className class], &count);\
for (int i = 0; i<count; i++) {\
    Ivar ivar = ivars[i];\
    const char *name = ivar_getName(ivar);\
    NSString *key = [NSString stringWithUTF8String:name];\
    id value = [self valueForKey:key];\
    [aCoder encodeObject:value forKey:key];\
}\
free(ivars);

#define DECODE(_className)\
if (self = [super init]) {\
    unsigned int count = 0;\
    Ivar *ivars = class_copyIvarList([_className class], &count);\
    for (int i = 0; i<count; i++) {\
        Ivar ivar = ivars[i];\
        const char *name = ivar_getName(ivar);\
        NSString *key = [NSString stringWithUTF8String:name];\
        id value = [aDecoder decodeObjectForKey:key];\
        [self setValue:value forKey:key];\
    }\
free(ivars);\
}\
return self;

#define SHOW_ALERT(message)\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title\
message:message\
delegate:nil\
cancelButtonTitle:@"确定"\
otherButtonTitles:nil];\
[alert show];\

#define Alert(str) \
UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:obj[@"message"] preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {\
}];\
[alert addAction:action];\
[self presentViewController:alert animated:YES completion:nil];

#define VideoURL(video)  [NSString stringWithFormat:@"http://7xswdm.com1.z0.glb.clouddn.com/%@",video]

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#endif /* CmmonMacro_h */
