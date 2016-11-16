//
// MineViewController.m
// BaseAppStruct
//
// Created by Havi on 2016/11/16
// Copyright 2016 Havi. All right reserved.
//

#import "MineViewController.h"
#import "MinePipeline.h"
#import "Minya.h"

@interface MineViewController ()

@property (nonatomic, strong) MinePipeline *pipeline;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add you own code 
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
