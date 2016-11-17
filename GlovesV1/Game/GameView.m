//
// GameView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/17
// Copyright 2016 Havi. All right reserved.
//

#import "GameView.h"
#import "UIView+MIPipeline.h"
#import "GamePipeline.h"

@interface GameView ()

@property (nonatomic, strong) GamePipeline *pipeline;
@property (nonatomic, strong) UIButton *button;

@end

@implementation GameView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; //Get the notification centre for the app
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:nil];
}

- (void)orientationChanged:(NSNotification *)note  {      UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    switch (o) {
        case UIDeviceOrientationLandscapeLeft:      // Device oriented horizontally, home button on the left
            self.frame = CGRectMake(0, 0, kScreenSize.height, kScreenSize.width);
            DeBugLog(@"坐标%f",kScreenSize.height);
            break;
        default:
            break;
    }   
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
