//
// RadarViewController.m
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "RadarViewController.h"
#import "RadarPipeline.h"
#import "Minya.h"

@interface RadarViewController ()

@property (nonatomic, strong) RadarPipeline *pipeline;

@end

@implementation RadarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add you own code
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismissRadarView)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"重新扫描" style:UIBarButtonItemStylePlain target:self action:@selector(scanBluetooth)];
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

- (void)dismissRadarView
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (currPeripheral) {
            self.pipeline.radarCalibrationAlert(1);
        }
    }];
}

- (void)addObservers {

    @weakify(self)
    [MIObserve(self.pipeline, selectedBluetooth) changed:^(id  _Nonnull newValue) {
        @strongify(self)
        [self dismissRadarView];
    }];

}

- (void)scanBluetooth
{
    self.pipeline.scanAgain = YES;
}

@end
