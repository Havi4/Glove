//
// MineView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/16
// Copyright 2016 Havi. All right reserved.
//

#import "MineView.h"
#import "UIView+MIPipeline.h"
#import "MinePipeline.h"

@interface MineView ()

@property (nonatomic, strong) MinePipeline *pipeline;

@end

@implementation MineView

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
