//
// GameView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/17
// Copyright 2016 Havi. All right reserved.
//

#import "GameView.h"
#import "UIView+MIPipeline.h"
#import "GamePipeline.h"
#import <WebKit/WebKit.h>

@interface GameView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) GamePipeline *pipeline;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *naviBarView;
@property (nonatomic, assign) BOOL isShowNavi;

@end

@implementation GameView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; //Get the notification centre for the app
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:nil];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, kScreenSize.height, kScreenSize.width)];
//
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.scrollEnabled = NO;
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"closeMe"];
    [self addSubview:_webView];
    [self configWebView];
    self.naviBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.height, 44)];
    self.naviBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi_lanscpe_back"]];
    [self addSubview:self.naviBarView];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 80, 44);
    [backButton setImage:[[UIImage imageNamed:@"navi_back"] imageByTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:kTitleNumberFont(kSubTitleNum)];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.naviBarView addSubview:backButton];
    [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.naviBarView.alpha = 0;
    } completion:^(BOOL finished) {
        self.isShowNavi = NO;
    }];
}

//OC在JS调用方法做的处理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"JS 调用了 %@ 方法，传回参数 %@",message.name,message.body);
    if (!self.isShowNavi) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.naviBarView.alpha = 1;
        } completion:^(BOOL finished) {
            self.isShowNavi = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.isShowNavi) {
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.naviBarView.alpha = 0;
                    } completion:^(BOOL finished) {
                        self.isShowNavi = NO;
                    }];
                }
            });
        }];

    }else{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.naviBarView.alpha = 0;
        } completion:^(BOOL finished) {
             self.isShowNavi = NO;
        }];
    }
}

- (void)backHome:(UIButton *)button
{
    self.pipeline.jsAlertShow = YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.userInteractionEnabled = YES;
//    button.frame = CGRectMake(0, 0, kScreenSize.height, kScreenSize.width);
//    button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(showNaviBar) forControlEvents:UIControlEventTouchUpOutside];
//    [webView addSubview:button];

}
- (void)showNaviBar
{
    DeBugLog(@"点击了屏幕");
}

- (void)configWebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (void)orientationChanged:(NSNotification *)note  {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    switch (o) {
        case UIDeviceOrientationLandscapeLeft:      // Device oriented horizontally, home button on the left
            self.frame = CGRectMake(0, 0, kScreenSize.height, kScreenSize.width);
            DeBugLog(@"坐标%f",kScreenSize.height);
            break;
        default:
            break;
    }   
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.pipeline.gameUrl]]];
//    @weakify(self)
//    [MIObserve(self.pipeline, gameUrl) changed:^(id  _Nonnull newValue) {
//        @strongify(self)
//    }];
}

@end
