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
#define kOrangeColor [UIColor colorWithRed:1.000 green:0.635 blue:0.333 alpha:1.00]
#define kBackgroundColor [UIColor colorWithRed:0.118 green:0.118 blue:0.118 alpha:1.00]
#define kCellBackColor [UIColor colorWithRed:0.173 green:0.173 blue:0.173 alpha:1.00]
#define kIconTintColor [UIColor colorWithRed:0.980 green:0.980 blue:0.980 alpha:1.00]
#define kContentColor [UIColor colorWithRed:0.600 green:0.600 blue:0.592 alpha:1.00]
//字体定义
#define kTitleFont [UIFont systemFontOfSize:16]
#define kSubTitleFont [UIFont systemFontOfSize:14]
