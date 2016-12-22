//
// ValidatePipeline.h
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "MIPipeline.h"

@interface ValidatePipeline : MIPipeline

@property (nonatomic, assign) BOOL firstFingerOK;
@property (nonatomic, assign) BOOL twoFingerOK;
@property (nonatomic, assign) BOOL threeFingerOK;
@property (nonatomic, assign) BOOL fourFingerOK;
@property (nonatomic, assign) BOOL fiveFingerOK;
@property (nonatomic, assign) BOOL fingerCheckOK;
@property (nonatomic, strong) NSString *blueCurrentNum;
@property (nonatomic, strong) NSString *oldFingerNum;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataArr1;

@property (nonatomic, strong) BabyBluetooth *babyBluetooth;

@end
