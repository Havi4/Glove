//
// RadarStore.m
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "RadarStore.h"
#import "RadarPipeline.h"
#import "Minya.h"

@interface RadarStore ()

@property (nonatomic, strong) RadarPipeline * radarPipeline;

@end

@implementation RadarStore

- (instancetype)initWithContext:(NSDictionary<NSString *,id> *)context {
    
    self = [super initWithContext:context];
    
    if (self) {
        self.radarPipeline.radarCalibrationAlert = [context objectForKey:@"alertBlock"];
    }
    
    return self;
}

- (void)fetchData {
    
}

- (__kindof MIPipeline *)pipeline {
    return self.radarPipeline;
}

- (void)addObservers {
    
}

+ (NSArray<NSString *> *)requiredParameters {
    return nil;
}

#pragma mark - Pipeline

- (RadarPipeline *)radarPipeline {
    if (!_radarPipeline) {
        _radarPipeline = [[RadarPipeline alloc] init];
    }
    return _radarPipeline;
}

@end
