//
// RadarPipeline.m
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "RadarPipeline.h"

@implementation RadarPipeline

- (BabyBluetooth *)babyBluetooth
{
    if (!_babyBluetooth) {
        _babyBluetooth = [BabyBluetooth shareBabyBluetooth];
    }
    return _babyBluetooth;
}

- (NSMutableArray *)pointArr
{
    if (!_pointArr) {
        _pointArr = [[NSMutableArray alloc]init];
    }
    return _pointArr;
}

@end
