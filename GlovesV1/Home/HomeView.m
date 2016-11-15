//
// HomeView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/14
// Copyright 2016 Havi. All right reserved.
//

#import "HomeView.h"
#import "UIView+MIPipeline.h"
#import "HomePipeline.h"
#import "PopListButton.h"

@interface HomeView ()

@property (nonatomic, strong) HomePipeline *pipeline;

@end

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    PopListButton *popButton = [[PopListButton alloc]initWithFrame:CGRectMake(kScreenSize.width-50, kScreenSize.height-50, 30, 30)
                                buttonType:buttonMenuType
                               buttonStyle:buttonRoundedStyle
                     animateToInitialState:YES];
    popButton.roundBackgroundColor = [UIColor whiteColor];
    popButton.lineThickness = 2;
    popButton.lineRadius = 1;
    popButton.tintColor = [UIColor flatPeterRiverColor];
    [self addSubview:popButton];
    popButton.clickBlock = ^(NSInteger integer){
        DeBugLog(@"%zd",integer);
    };
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
