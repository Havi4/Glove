//
//  CardBlueView.h
//  GlovesV1
//
//  Created by HaviLee on 2016/11/22.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "BaseView.h"

@interface CardBlueView : UIView

@property (nonatomic, strong) NSArray *bluetoothList;
@property (nonatomic, copy) void (^cellTaped)(NSIndexPath *path);
@property (nonatomic, copy) void (^tapScanAgain)(NSIndexPath *path);
@end
