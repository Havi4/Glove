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
#import "SCLAlertView.h"

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
        [self checkBluetooth:nil];
    });
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"雷达" style:UIBarButtonItemStylePlain target:self action:@selector(checkBluetooth:)];

}

- (void)checkBluetooth:(id)sender{
    if (!currPeripheral || sender) {
        @weakify(self);
        self.pipeline.showCalibrationAlert = ^(NSInteger i){
            DeBugLog(@"获取到蓝牙设备");
            @strongify(self);
            [self showSuccess:nil];
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

- (void)showSuccess:(id)sender
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert setTitleFontFamily:@"PingFangSC-Regular" withSize:20.0f];
    [alert setBodyTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
    [alert setButtonsTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
    [alert addButton:@"校准手套" actionBlock:^(void) {
        DeBugLog(@"校准手套");
        MIScene *validateScene = [MIScene sceneWithView:@"ValidateView" controller:@"ValidateViewController" store:@"ValidateStore"];
        UIViewController *validateViewController = [[MIMediator sharedMediator] viewControllerWithScene:validateScene context:nil];
        CYNavigationViewController *navi = [[CYNavigationViewController alloc]initWithRootViewController:validateViewController];
        [self presentViewController:navi animated:YES completion:^{
            
        }];
    }];

    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [NSBundle mainBundle].resourcePath]];

    [alert showSuccess:@"提示" subTitle:@"蓝牙设备已连接" closeButtonTitle:@"开始训练" duration:0.0f];
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
