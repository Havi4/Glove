//
// GamePipeline.m
// BaseAppStruct
//
// Created by Havi on 2016/11/17
// Copyright 2016 Havi. All right reserved.
//

#import "GamePipeline.h"

@implementation GamePipeline

- (BabyBluetooth *)babyBluetooth
{
    if (!_babyBluetooth) {
        _babyBluetooth = [BabyBluetooth shareBabyBluetooth];
    }
    return _babyBluetooth;
}

@end
