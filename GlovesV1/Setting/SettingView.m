//
// SettingView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/14
// Copyright 2016 Havi. All right reserved.
//

#import "SettingView.h"
#import "UIView+MIPipeline.h"
#import "SettingPipeline.h"

@interface SettingView ()

@property (nonatomic, strong) SettingPipeline *pipeline;

@end

@implementation SettingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
