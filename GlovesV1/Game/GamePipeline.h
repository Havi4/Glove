//
// GamePipeline.h
// BaseAppStruct
//
// Created by Havi on 2016/11/17
// Copyright 2016 Havi. All right reserved.
//

#import "MIPipeline.h"

@interface GamePipeline : MIPipeline

// Flag data
@property (nonatomic, assign) BOOL jsAlertShow;
    
@property (nonatomic, strong) BabyBluetooth *babyBluetooth;

@property(strong,nonatomic)CBPeripheral *currPeripheral;

@property (nonatomic, strong) NSString *gameUrl;

@property (nonatomic, assign) BOOL isUrlDone;

@end
