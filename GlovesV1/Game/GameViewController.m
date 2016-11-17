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
    // Add you own code
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; //Get the notification centre for the app
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:nil];
}

- (void)orientationChanged:(NSNotification *)note  {      UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    switch (o) {
        case UIDeviceOrientationLandscapeLeft:      // Device oriented horizontally, home button on the left
            self.backImageView.frame = CGRectMake(0, 0, kScreenSize.height, kScreenSize.width);
            break;
            
        default:
            break;
    }
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

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
