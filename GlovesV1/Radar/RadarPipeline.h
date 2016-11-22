//
// RadarPipeline.h
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "MIPipeline.h"

@interface RadarPipeline : MIPipeline

@property (nonatomic, strong) BabyBluetooth *babyBluetooth;
@property (nonatomic, strong) NSMutableArray *pointArr;

@property (nonatomic, assign) BOOL scanAgain;
@property (nonatomic, assign) BOOL selectedBluetooth;
@property (nonatomic, copy) void (^radarCalibrationAlert)(NSInteger i);


@end
