//
// HomeStore.m
// BaseAppStruct
//
// Created by Havi on 2016/11/14
// Copyright 2016 Havi. All right reserved.
//

#import "HomeStore.h"
#import "HomePipeline.h"
#import "Minya.h"

@interface HomeStore ()

@property (nonatomic, strong) HomePipeline * homePipeline;

@end

@implementation HomeStore

- (instancetype)initWithContext:(NSDictionary<NSString *,id> *)context {
    
    self = [super initWithContext:context];
    
    if (self) {
        
    }
    
    return self;
}

- (void)fetchData {
    
}

- (__kindof MIPipeline *)pipeline {
    return self.homePipeline;
}

- (void)addObservers {
    
}

+ (NSArray<NSString *> *)requiredParameters {
    return nil;
}

#pragma mark - Pipeline

- (HomePipeline *)homePipeline {
    if (!_homePipeline) {
        _homePipeline = [[HomePipeline alloc] init];
    }
    return _homePipeline;
}

@end
