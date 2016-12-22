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
#import "GetFingerDataViewController.h"

@interface ValidateViewController ()

@property (nonatomic, strong) ValidatePipeline *pipeline;

@end

@implementation ValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add you own code
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"停止" style:UIBarButtonItemStylePlain target:self action:@selector(dismissValidateView)];

}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
}

- (void)addObservers {

    @weakify(self)
    [MIObserve(self.pipeline, fingerCheckOK) changed:^(id  _Nonnull newValue) {
        @strongify(self)
        if (self.pipeline.fingerCheckOK) {
            UIViewController *gameViewController = [[GetFingerDataViewController alloc]init];
            [self.navigationController pushViewController:gameViewController animated:YES];
        }
    }];

}

- (void)dismissValidateView
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
