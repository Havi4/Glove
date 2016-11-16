//
// MineStore.m
// BaseAppStruct
//
// Created by Havi on 2016/11/16
// Copyright 2016 Havi. All right reserved.
//

#import "MineStore.h"
#import "MinePipeline.h"
#import "Minya.h"

@interface MineStore ()

@property (nonatomic, strong) MinePipeline * minePipeline;

@end

@implementation MineStore

- (instancetype)initWithContext:(NSDictionary<NSString *,id> *)context {
    
    self = [super initWithContext:context];
    
    if (self) {
        
    }
    
    return self;
}

- (void)fetchData {
    
}

- (__kindof MIPipeline *)pipeline {
    return self.minePipeline;
}

- (void)addObservers {
    
}

+ (NSArray<NSString *> *)requiredParameters {
    return nil;
}

#pragma mark - Pipeline

- (MinePipeline *)minePipeline {
    if (!_minePipeline) {
        _minePipeline = [[MinePipeline alloc] init];
    }
    return _minePipeline;
}

@end
