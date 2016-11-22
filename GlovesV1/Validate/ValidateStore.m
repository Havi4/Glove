//
// ValidateStore.m
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "ValidateStore.h"
#import "ValidatePipeline.h"
#import "Minya.h"

@interface ValidateStore ()

@property (nonatomic, strong) ValidatePipeline * validatePipeline;

@end

@implementation ValidateStore

- (instancetype)initWithContext:(NSDictionary<NSString *,id> *)context {
    
    self = [super initWithContext:context];
    
    if (self) {
        
    }
    
    return self;
}

- (void)fetchData {
    
}

- (__kindof MIPipeline *)pipeline {
    return self.validatePipeline;
}

- (void)addObservers {
    
}

+ (NSArray<NSString *> *)requiredParameters {
    return nil;
}

#pragma mark - Pipeline

- (ValidatePipeline *)validatePipeline {
    if (!_validatePipeline) {
        _validatePipeline = [[ValidatePipeline alloc] init];
    }
    return _validatePipeline;
}

@end
