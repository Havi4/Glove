//
// MineViewController.m
// BaseAppStruct
//
// Created by Havi on 2016/10/25
// Copyright 2016 Havi. All right reserved.
//

#import "MineViewController.h"
#import "MinePipeline.h"
#import "Minya.h"
#import "UIViewController+SQExtension.h"
#define kScaleLength(length) (length) * [UIScreen mainScreen].bounds.size.width / 320.0f

#define KC01_57c2de [UIColor colorWithHexString:@"#57c2de"]

@interface MineViewController ()

@property (nonatomic, strong) MinePipeline *pipeline;

//自定
@property (nonatomic, strong) UIBarButtonItem *leftBarItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;

@end

@implementation MineViewController

- (void)loadView {
    [super loadView];
    /*
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor blackColor]]];
     */
    
    self.leftBarItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navi_message"] imageByTintColor:kBarNormalColor] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarbuttonTaped:)];
    self.rightBarItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navi_setting"] imageByTintColor:kBarNormalColor] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarbuttonTaped:)];
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    self.title = @"我的";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add you own code
    [self.store fetchData];
    
}

- (void)addObservers {
    
    @weakify(self)
    [MIObserve(self.pipeline, selectedIndexPath) changed:^(id  _Nonnull newValue) {
        @strongify(self)
        NSIndexPath *indexPath = newValue;
        
        DeBugLog(@"选中了section %ld ,cell %ld",(long)indexPath.section,(long)indexPath.row);
    }];
    /*
    [MIObserve(self.pipeline, mContentOffset) changed:^(id _Nonnull newValue) {
        @strongify(self)
        [self navigationBarGradualChangeWithScrollViewContent:self.pipeline.mContentOffset offset:kScaleLength(190.5) color:KC01_57c2de];
    }];
     */
}

- (void)rightBarbuttonTaped:(UIBarButtonItem *)barButton
{
    MIScene *settingScen = [MIScene sceneWithView:@"SettingView" controller:@"SettingViewController" store:@"SettingStore"];
    UIViewController *setting = [[MIMediator sharedMediator]viewControllerWithScene:settingScen context:nil];
    setting.title = @"设定";
    [self.navigationController pushViewController:setting animated:YES];
}


- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

@end
