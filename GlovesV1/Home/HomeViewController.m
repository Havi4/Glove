//
// HomeViewController.m
// BaseAppStruct
//
// Created by Havi on 2016/11/14
// Copyright 2016 Havi. All right reserved.
//

#import "HomeViewController.h"
#import "HomePipeline.h"
#import "Minya.h"
#import "GameViewController.h"
#import "CYNavigationViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) HomePipeline *pipeline;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add you own code
    self.title = @"训练";
}
    
- (void)viewDidAppear:(BOOL)animated
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkBluetooth];
    });
}
    
- (void)checkBluetooth{
    if (!currPeripheral) {
        self.pipeline.showCalibrationAlert = ^(NSInteger i){
            DeBugLog(@"获取到蓝牙设备");
        };
        MIScene *radarScene = [MIScene sceneWithView:@"RadarView" controller:@"RadarViewController" store:@"RadarStore"];
        UIViewController *radarViewController = [[MIMediator sharedMediator] viewControllerWithScene:radarScene context:self.pipeline.controllerSetting];
        CYNavigationViewController *radarNavigationController = [[CYNavigationViewController alloc]
                                                      initWithRootViewController:radarViewController];
        [self presentViewController:radarNavigationController animated:YES completion:^{
            
        }];
    }
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

- (void)addObservers {
    
    @weakify(self)
    [MIObserve(self.pipeline, selectedIndexPath) changed:^(id  _Nonnull newValue) {
        @strongify(self)
        NSIndexPath *indexPath = newValue;
        MIScene *gameScene = [MIScene sceneWithView:@"GameView" controller:@"GameViewController" store:@"GameStore"];
        UIViewController *gameViewController = [[MIMediator sharedMediator] viewControllerWithScene:gameScene context:self.pipeline.controllerSetting];
        [self.navigationController pushViewController:gameViewController animated:YES];
    }];
    
}

@end
