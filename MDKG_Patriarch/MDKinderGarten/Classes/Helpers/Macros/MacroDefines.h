//
//  MacroDefines.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/1/22.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//
#ifndef MacroDefines_h
#define MacroDefines_h

#define kDeviceHeight                           ([UIScreen mainScreen].bounds.size.height)
#define kDeviceWidth                            ([UIScreen mainScreen].bounds.size.width)
#define IS_LOGIN                                (@"isLogined")

#define ratio                                   1
#define KGRatio                                 750.0/720.0
#define KGScreenRatio                           kDeviceWidth / 375.00

#define Color_RGB(r, g, b, a)                   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]
#define NavBarColor                             Color_RGB(41, 94, 155, 1)
#define TableViewColor                          Color_RGB(230, 230, 230, 1)
#define ColorYellow                             Color_RGB(250, 138, 55, 1)

//全局颜色
#define HomePageBottomColor                     Color_RGB(235, 250, 255, 1)
#define GlobalColor_MAN                         Color_RGB(70, 192, 251, 1)
#define GlobalColor_Female                      Color_RGB(222, 222, 222, 1)
//按钮底色
#define UIButtonBottomColor                     Color_RGB(252, 129, 141, 1)
//全局用到图片
#define GlobalImage_MAN                         [UIImage imageNamed:@"cloud_top"]
#define GlobalImage_Female                      [UIImage imageNamed:@"cloud_top"]

/**
 *  输出size或者Rect
 */
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)

#ifdef DEBUG
# define DLog(fmt, ...)                         NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define DLog(...);
#endif

//单例
#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    IMP_SINGLETON
#define IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

//释放YTKRequest专用
#define HTTPMSG_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF stop];\
TT_RELEASE_SAFELY(__REF);\
}\
}

#undef TT_RELEASE_SAFELY
#define TT_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
__REF = nil;\
}\
}


#endif /* MacroDefines_h */
