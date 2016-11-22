//
// ValidateView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "ValidateView.h"
#import "UIView+MIPipeline.h"
#import "ValidatePipeline.h"

@interface ValidateView ()

@property (nonatomic, strong) ValidatePipeline *pipeline;

@end

@implementation ValidateView

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
