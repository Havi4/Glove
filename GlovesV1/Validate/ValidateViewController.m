//
// ValidateViewController.m
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "ValidateViewController.h"
#import "ValidatePipeline.h"
#import "Minya.h"

@interface ValidateViewController ()

@property (nonatomic, strong) ValidatePipeline *pipeline;

@end

@implementation ValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add you own code 
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
