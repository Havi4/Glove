//
//  Definations.h
//  HaviModel
//
//  Created by Havi on 15/12/5.
//  Copyright © 2015年 Havi. All rights reserved.
//

#ifndef Definations_h
#define Definations_h


#endif /* Definations_h */

#define kAppBaseURL @"http://webservice.meddo99.com:9000/"
#define kAppTestBaseURL @"http://webservice.meddo99.com:9001/"


#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kUserDefaults [NSUserDefaults standardUserDefaults]

#define kAccessTocken @"A29#XXFDs1-FDKSD-JGLjx2"
#define kTestUserID @"meddo99.com$13122785292"
#define kAdvertismentTag @"kAdvertismentTag"

#ifdef DEBUG
#define DeBugLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DeBugLog(s, ... )
#endif



#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#define ISIPHON4 [UIScreen mainScreen].bounds.size.height==480 ? YES:NO
#define ISIPHON6 [UIScreen mainScreen].bounds.size.height>568 ? YES:NO

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

//背景色定义
#define kBarNormalColor RGBA(64,62,72,1)
#define kBarHightlightedColor RGBA(239,156,0,1)
#define kContentColor RGBA(64,64,64,1)
//字体定义
#define kTitleNumberFont(_font) [UIFont fontWithName:@"K'aS" size:_font]
#define kTitleNum 30//一级标题
#define kSubTitleNum 25//二级标题
#define kContentNum 18//正文
#define kSubContentNum 14//下标
