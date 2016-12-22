//
// ValidatePipeline.m
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "ValidatePipeline.h"

@implementation ValidatePipeline

- (BabyBluetooth *)babyBluetooth
{
    if (!_babyBluetooth) {
        _babyBluetooth = [BabyBluetooth shareBabyBluetooth];
    }
    return _babyBluetooth;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (NSMutableArray *)dataArr1
{
    if (!_dataArr1) {
        _dataArr1 = [[NSMutableArray alloc]init];
    }
    return _dataArr1;
}


@end
