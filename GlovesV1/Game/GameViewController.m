//
// GameViewController.m
// BaseAppStruct
//
// Created by Havi on 2016/11/17
// Copyright 2016 Havi. All right reserved.
//

#import "GameViewController.h"
#import "GamePipeline.h"
#import "Minya.h"
#import "AppDelegate.h"

@interface GameViewController ()

@property (nonatomic, strong) GamePipeline *pipeline;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add you own  code
//    WKWebView *web = [];
    self.navigationController.navigationBar.hidden = YES;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; //Get the notification centre for the app
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:nil];
}

- (void)orientationChanged:(NSNotification *)note  {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    switch (o) {
        case UIDeviceOrientationLandscapeLeft:      // Device oriented horizontally, home button on the left
            self.backImageView.frame = CGRectMake(0, 0, kScreenSize.height, kScreenSize.width);
            break;
            
        default:
            break;
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.fd_interactivePopDisabled = YES;
    [super viewDidAppear:animated];
    [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
}

- (void)canRotate
{
    DeBugLog(@"这个没有其他意义，只是在子类实现表明该类可以横屏");
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)addObservers {
    
    @weakify(self)
    [MIObserve(self.pipeline, jsAlertShow) changed:^(id  _Nonnull newValue) {
        @strongify(self)
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"退出游戏" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        }];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            self.navigationController.navigationBar.hidden = NO;
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }];
    /*
     [MIObserve(self.pipeline, mContentOffset) changed:^(id _Nonnull newValue) {
     @strongify(self)
     [self navigationBarGradualChangeWithScrollViewContent:self.pipeline.mContentOffset offset:kScaleLength(190.5) color:KC01_57c2de];
     }];
     */
}


- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
