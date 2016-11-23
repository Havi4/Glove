//
//  AppDelegate.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/14.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "IanAdsStartView.h"
#import "CYLTabBarControllerConfig.h"
#import "TabPlusButtonSubclass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [TabPlusButtonSubclass registerPlusButton];
    #pragma mark 设置tabbar
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    self.window.rootViewController = tabBarControllerConfig.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self setUpNavigationBarAppearance];
    #pragma mark 进行广告位
    [self initAllRequestParams];
    [self setAdvertisement];
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
    return YES;
}

- (void)initAllRequestParams
{
    //设置baseUrl
    [HYBNetworking updateBaseUrl:kAppBaseURL];
    //请求取消时间
    [HYBNetworking setTimeout:30];
    //设置没有网络的时候从本地读取数据
    [HYBNetworking obtainDataFromLocalWhenNetworkUnconnected:YES];
    //缓存get请求，
    [HYBNetworking cacheGetRequest:YES shoulCachePost:NO];
    //debug模式。放心使用，使用debug
    [HYBNetworking enableInterfaceDebug:YES];
    //配置请求和接受格式，json
    [HYBNetworking configRequestType:kHYBRequestTypeJSON responseType:kHYBResponseTypeJSON shouldAutoEncodeUrl:NO callbackOnCancelRequest:YES];
    //配置请求头
    [HYBNetworking configCommonHttpHeaders:@{
                                             @"AccessToken" : kAccessTocken,
                                             @"Accept":@"application/json"
                                             }];
}

#pragma mark 设置广告

- (void)setAdvertisement
{
    NSString *picUrl = @"http://785j3g.com1.z0.glb.clouddn.com/d659db60-f.jpg";
    NSString *userDefaultKey = @"download_key";
    if ([kUserDefaults stringForKey:kAdvertismentTag].length > 0) {
        picUrl = [kUserDefaults stringForKey:kAdvertismentTag];
    }
    if ([[kUserDefaults stringForKey:userDefaultKey] isEqualToString:@"1"]) {
        IanAdsStartView *startView = [IanAdsStartView startAdsViewWithBgImageUrl:picUrl withClickImageAction:^{
            DeBugLog(@"you tap an ad view");
            //            IANWebViewController *VC = [IANWebViewController new];
            //            VC.title = @"这可能是一个广告页面";
            //            [(UINavigationController *)self.window.rootViewController pushViewController:VC animated:YES];
        }];
        
        [startView startAnimationTime:3 WithCompletionBlock:^(IanAdsStartView *startView){
            DeBugLog(@"广告结束后，执行事件");
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [self getADUrlFromServer];
        }];
    } else { // 第一次先下载广告
        [IanAdsStartView downloadStartImage:picUrl];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:userDefaultKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (void)getADUrlFromServer
{
    
}

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"background_image"];
        
        textAttributes = @{
                           NSFontAttributeName : kTitleNumberFont(kTitleNum),
                           NSForegroundColorAttributeName : kBarHightlightedColor,
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : [UIColor blackColor],
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setBarTintColor:kBarNormalColor];
    [navigationBarAppearance setTintColor:kBarNormalColor];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    UIViewController *rootViewController = [self topViewControllerWithRootViewController:window.rootViewController];
    if (rootViewController) {
        if ([rootViewController respondsToSelector:@selector(canRotate)]) {
            // Unlock landscape view orientations for this view controller
            return UIInterfaceOrientationMaskLandscapeRight;
        }
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController
{
    if (rootViewController == nil) { return nil; }
    if ([rootViewController isKindOfClass: [UITabBarController class]]) {
        UIViewController *tab = [(UITabBarController *)rootViewController selectedViewController];
        return [self topViewControllerWithRootViewController:tab];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *tab = [(UINavigationController *)rootViewController visibleViewController];
        return [self topViewControllerWithRootViewController:tab];
    } else if (rootViewController.presentedViewController != nil) {
        return [rootViewController presentedViewController];
    }
    return rootViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
