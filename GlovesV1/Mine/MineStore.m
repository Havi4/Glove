//
// MineStore.m
// BaseAppStruct
//
// Created by Havi on 2016/10/25
// Copyright 2016 Havi. All right reserved.
//

#import "MineStore.h"
#import "MinePipeline.h"
#import "Minya.h"

@interface MineStore ()

@property (nonatomic, strong) MinePipeline * minePipeline;//数据

@property (nonatomic, strong) id<MIService> mineService;


@end

@implementation MineStore

- (instancetype)initWithContext:(NSDictionary<NSString *,id> *)context {
    
    self = [super initWithContext:context];
    
    if (self) {
        
    }
    
    return self;
}

- (void)fetchData {
    [self _requiredMethod];
}

- (__kindof MIPipeline *)pipeline {
    return self.minePipeline;
}

- (void)addObservers {
    
}

+ (NSArray<NSString *> *)requiredParameters {
    return nil;
}

#pragma mark - Private Method

- (void)_requiredMethod
{
    NSDictionary *userInfo = @{
                               @"UserID": kTestUserID, //手机号码
                               };
    [self.mineService requestWithParameters:userInfo success:^(id  _Nullable data) {
        // Store the photo data
        self.minePipeline.userInfo = (UserInfoDetailModel *)data;
        self.minePipeline.flagRequestFinished = YES;
    } fail:^(id  _Nullable data, NSError * _Nullable error) {
        
    }];
}

#pragma mark - Pipeline

- (MinePipeline *)minePipeline {
    if (!_minePipeline) {
        _minePipeline = [[MinePipeline alloc] init];
    }
    return _minePipeline;
}

- (id<MIService>)mineService
{
    if (!_mineService) {
        _mineService = [MIService serviceWithName:@"MineService"];
    }
    return _mineService;
}

- (void)dealloc {
    DeBugLog(@"%s", __FUNCTION__);
}

@end
