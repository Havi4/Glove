//
// SettingStore.m
// BaseAppStruct
//
// Created by Havi on 2016/11/14
// Copyright 2016 Havi. All right reserved.
//

#import "SettingStore.h"
#import "SettingPipeline.h"
#import "Minya.h"

@interface SettingStore ()

@property (nonatomic, strong) SettingPipeline * settingPipeline;

@end

@implementation SettingStore

- (instancetype)initWithContext:(NSDictionary<NSString *,id> *)context {
    
    self = [super initWithContext:context];
    
    if (self) {
        
    }
    
    return self;
}

- (void)fetchData {
    
}

- (__kindof MIPipeline *)pipeline {
    return self.settingPipeline;
}

- (void)addObservers {
    
}

+ (NSArray<NSString *> *)requiredParameters {
    return nil;
}

#pragma mark - Pipeline

- (SettingPipeline *)settingPipeline {
    if (!_settingPipeline) {
        _settingPipeline = [[SettingPipeline alloc] init];
    }
    return _settingPipeline;
}

@end
