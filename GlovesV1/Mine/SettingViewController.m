//
// SettingViewController.m
// BaseAppStruct
//
// Created by Havi on 2016/10/31
// Copyright 2016 Havi. All right reserved.
//

#import "SettingViewController.h"
#import "SettingPipeline.h"
#import "Minya.h"

@interface SettingViewController ()

@property (nonatomic, strong) SettingPipeline *pipeline;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add you own code 
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
