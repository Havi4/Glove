//
//  MIViewController.m
//  MinyaDemo
//
//  Created by Konka on 2016/9/27.
//  Copyright © 2016年 Minya. All rights reserved.
//

#import "MIViewController.h"
#import "MIStore.h"
#import "UIView+MIPipeline.h"

#pragma mark - MIViewController Extension

@interface MIViewController ()

@property (nonatomic, assign) Class viewClass;
//!< Container view class

@end

#pragma mark - MIViewController implementation

@implementation MIViewController

#pragma mark - Life Cycle

- (instancetype)initWithStore:(id<MIStore>)store viewClass:(Class)viewClass {
    
    NSParameterAssert(store);
    NSAssert([viewClass isSubclassOfClass:[UIView class]], @"viewClass should be subclass of UIView");
    
    self = [super init];
    
    if (self) {
        
        _store = store;
        _viewClass = viewClass;
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view = [[self.viewClass alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up pipeline
    [self setupPipeline:self.store.pipeline];
    [self.view setupPipeline:self.store.pipeline];
//    self.view.backgroundColor = [UIColor whiteColor];
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
    _backImageView.image = [UIImage imageNamed:@"background_image"];
    [self.view addSubview:_backImageView];
    [self.view sendSubviewToBack:_backImageView];
    // Add observers of the pipeline data.
    [self addObservers];
    
}



#pragma mark - Public Methods

- (void)addObservers {
    
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline { }

@end
