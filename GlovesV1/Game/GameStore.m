//
// GameStore.m
// BaseAppStruct
//
// Created by Havi on 2016/11/17
// Copyright 2016 Havi. All right reserved.
//

#import "GameStore.h"
#import "GamePipeline.h"
#import "Minya.h"

@interface GameStore ()

@property (nonatomic, strong) GamePipeline * gamePipeline;

@end

@implementation GameStore

- (instancetype)initWithContext:(NSDictionary<NSString *,id> *)context {
    
    self = [super initWithContext:context];
    
    if (self) {
        
    }
    
    return self;
}

- (void)fetchData {
    
}

- (__kindof MIPipeline *)pipeline {
    return self.gamePipeline;
}

- (void)addObservers {
    
}

+ (NSArray<NSString *> *)requiredParameters {
    return nil;
}

#pragma mark - Pipeline

- (GamePipeline *)gamePipeline {
    if (!_gamePipeline) {
        _gamePipeline = [[GamePipeline alloc] init];
    }
    return _gamePipeline;
}

@end
