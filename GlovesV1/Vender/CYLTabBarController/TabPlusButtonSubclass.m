//
//  TabPlusButtonSubclass.m
//  ZZHTabStruct
//
//  Created by HaviLee on 2016/10/25.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import "TabPlusButtonSubclass.h"
#import "CYLTabBarController.h"
#import "CYNavigationViewController.h"

@interface TabPlusButtonSubclass ()
{
    CGFloat _buttonImageHeight;
}

@end

@implementation TabPlusButtonSubclass

#pragma mark -
#pragma mark - Life Cycle

//+ (void)load {
//    [super registerPlusButton];
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.6;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 1;
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdgeWidth;
    CGFloat const verticalMargin  = verticalMarginT / 2;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeWidth * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeWidth  + verticalMargin * 2 + labelLineHeight * 0.5 ;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    TabPlusButtonSubclass *button = [[TabPlusButtonSubclass alloc] init];
    UIImage *buttonImage = [UIImage imageNamed:@"sleep_normal"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"sleep_hightlight"] forState:UIControlStateSelected];
    [button setTitle:@"睡眠" forState:UIControlStateNormal];
    [button setTitleColor:kIconTintColor forState:UIControlStateNormal];
    
    [button setTitle:@"睡眠" forState:UIControlStateSelected];
    [button setTitleColor:kOrangeColor forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    //    button.frame = CGRectMake(0.0, 0.0, 250, 100);
    //    button.backgroundColor = [UIColor redColor];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
    return nil;
}

#pragma mark - Event Response

- (void)clickPublish {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
    [actionSheet showInView:viewController.view];
}

+ (UIViewController *)plusChildViewController
{
    MIScene *scene = [MIScene sceneWithView:@"HomeView" controller:@"HomeViewController" store:@"HomeStore"];
    UIViewController *homeViewController = [[MIMediator sharedMediator] viewControllerWithScene:scene context:nil];
    UIViewController *homeNavigationController = [[CYNavigationViewController alloc]
                                                  initWithRootViewController:homeViewController];
    return homeNavigationController;
}

+ (NSUInteger)indexOfPlusButtonInTabBar
{
    return 2;
}

@end
