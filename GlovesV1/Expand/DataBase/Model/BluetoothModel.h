//
//  BluetoothModel.h
//  GlovesV1
//
//  Created by HaviLee on 2016/11/22.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BluetoothModel : NSObject

@property (nonatomic, strong) NSString *bluetoothName;
@property (nonatomic, strong) NSArray *position;
@property (nonatomic, strong) CBPeripheral *currentPeripheral;
@property (nonatomic, assign) NSNumber *minNum;
@property (nonatomic, assign) NSNumber *maxNum;

@end
