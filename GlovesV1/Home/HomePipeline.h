//
// HomePipeline.h
// BaseAppStruct
//
// Created by Havi on 2016/11/14
// Copyright 2016 Havi. All right reserved.
//

#import "MIPipeline.h"

@interface HomePipeline : MIPipeline

// Normal data

@property(strong,nonatomic)CBPeripheral *currPeripheral;

// Flag data
@property (nonatomic, assign) BOOL flagRequestFinished;
@property (nonatomic, strong) NSString *gameUrl;

// Input data
@property (nonatomic, assign) NSUInteger inputSelectedPhotoIndex;
@property (nonatomic, assign) BOOL inputFetchMoreData;

@property (nonatomic, assign) CGPoint mContentOffset;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

// Context data
// In general, context data is calculate property. They can be calculated
// from other property.
@property (nonatomic, strong, readonly) NSDictionary *controllerSetting;

@property (nonatomic, copy) void (^showCalibrationAlert)(NSInteger i);

@end
