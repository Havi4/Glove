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

@interface HomeViewController ()

@property (nonatomic, strong) HomePipeline *pipeline;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add you own code
    self.title = @"训练";
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

- (void)addObservers {
    
    @weakify(self)
    [MIObserve(self.pipeline, selectedIndexPath) changed:^(id  _Nonnull newValue) {
        @strongify(self)
        NSIndexPath *indexPath = newValue;
        MIScene *gameScene = [MIScene sceneWithView:@"GameView" controller:@"GameViewController" store:@"GameStore"];
        UIViewController *gameViewController = [[MIMediator sharedMediator] viewControllerWithScene:gameScene context:self.pipeline.controllerSetting];
        [self.navigationController pushViewController:gameViewController animated:YES];
        DeBugLog(@"选中了section %ld ,cell %ld",(long)indexPath.section,(long)indexPath.row);
    }];
    /*
     [MIObserve(self.pipeline, mContentOffset) changed:^(id _Nonnull newValue) {
     @strongify(self)
     [self navigationBarGradualChangeWithScrollViewContent:self.pipeline.mContentOffset offset:kScaleLength(190.5) color:KC01_57c2de];
     }];
     */
}

@end
