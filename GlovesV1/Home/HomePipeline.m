//
// HomePipeline.m
// BaseAppStruct
//
// Created by Havi on 2016/11/14
// Copyright 2016 Havi. All right reserved.
//

#import "HomePipeline.h"

@implementation HomePipeline

- (NSDictionary *)controllerSetting
{
    return @{@"gameUrl": self.gameUrl ?: @""};
}

@end
