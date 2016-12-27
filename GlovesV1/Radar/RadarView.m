//
// RadarView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "RadarView.h"
#import "UIView+MIPipeline.h"
#import "RadarPipeline.h"
#import "XHRadarView.h"
#import "BluetoothModel.h"
#import "CardBlueView.h"

@interface RadarView ()<XHRadarViewDataSource, XHRadarViewDelegate>

@property (nonatomic, strong) RadarPipeline *pipeline;
@property (nonatomic, strong) XHRadarView *radarView;
@property (nonatomic, strong) CardBlueView *radarListView;

@end

@implementation RadarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setRadarView];
    }
    return self;
}

- (void)setRadarView
{
    _radarView = [[XHRadarView alloc] initWithFrame:(CGRect){0,-64,kScreenSize.width,kScreenSize.height}];
    _radarView.dataSource = self;
    _radarView.delegate = self;
    _radarView.radius = (kScreenSize.width)/2;
    _radarView.backgroundColor = [UIColor clearColor];
    _radarView.backgroundImage = [UIImage imageNamed:@"background_image"];
    _radarView.indicatorStartColor = kBarHightlightedColor;
    _radarView.labelText = @"正在搜索附近的蓝牙设备";
    [self addSubview:_radarView];
    
    _radarListView = [[CardBlueView alloc]initWithFrame:(CGRect){15,64+kScreenSize.height,kScreenSize.width-30,kScreenSize.height-64-140}];
    _radarListView.alpha = 1;
    @weakify(self);
    _radarListView.cellTaped = ^(NSIndexPath *path){
        @strongify(self);
        self.pipeline.selectedBluetooth = YES;
    };
    _radarListView.tapScanAgain = ^(NSIndexPath *path){
        @strongify(self);
        [self.radarView scan];
        [self.pipeline.babyBluetooth cancelAllPeripheralsConnection];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.radarListView.frame = (CGRect){15,64+kScreenSize.height,kScreenSize.width-30,kScreenSize.height-64-140};
        } completion:^(BOOL finished) {
            self.pipeline.babyBluetooth.scanForPeripherals().begin().stop(kRadarScanTime);
        }];
    };
    [self addSubview:_radarListView];

}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {

    self.pipeline = pipeline;
    [self.radarView scan];
    [self babyDelegate];
    self.pipeline.babyBluetooth.scanForPeripherals().begin().stop(kRadarScanTime);
    @weakify(self);
    [MIObserve(self.pipeline, scanAgain) changed:^(id  _Nonnull newValue) {
        @strongify(self);
        DeBugLog(@"重新扫描");
        [self.radarView scan];
        [self.pipeline.babyBluetooth cancelAllPeripheralsConnection];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.radarListView.frame = (CGRect){15,64+kScreenSize.height,kScreenSize.width-30,kScreenSize.height-64-140};
        } completion:^(BOOL finished) {
            self.pipeline.babyBluetooth.scanForPeripherals().begin().stop(kRadarScanTime);
        }];
    }];
}

#pragma mark - XHRadarViewDataSource
- (NSInteger)numberOfSectionsInRadarView:(XHRadarView *)radarView {
    return 4;
}
- (NSInteger)numberOfPointsInRadarView:(XHRadarView *)radarView {
    return [self.pipeline.pointArr count];
}
- (UIView *)radarView:(XHRadarView *)radarView viewForIndex:(NSUInteger)index {
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 25)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [imageView setImage:[UIImage imageNamed:@"radar_device"]];
    [pointView addSubview:imageView];
    return pointView;
}
- (CGPoint)radarView:(XHRadarView *)radarView positionForIndex:(NSUInteger)index {
    BluetoothModel *model = [self.pipeline.pointArr objectAtIndex:index];
    DeBugLog(@"坐标是%@,%@",model.minNum,model.maxNum);
    return CGPointMake([model.minNum floatValue], [model.maxNum floatValue]);
}
    
#pragma mark - XHRadarViewDelegate
    
- (void)radarView:(XHRadarView *)radarView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"didSelectItemAtIndex:%lu", (unsigned long)index);
    
}

#pragma mark 雷达

        //设置蓝牙委托
-(void)babyDelegate{
    @weakify(self);
    [self.pipeline.babyBluetooth setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
        
        }
    }];
        //设置扫描到设备的委托
    [self.pipeline.babyBluetooth setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
        @strongify(self);
        BluetoothModel *model = [[BluetoothModel alloc]init];
        model.currentPeripheral = peripheral;
        model.bluetoothName = peripheral.name;
        model.minNum = [NSNumber random:0 max:150];
        model.maxNum = [NSNumber random:0 max:150];
        BOOL isIn = NO;
        for (BluetoothModel *model in self.pipeline.pointArr) {
            if ([model.bluetoothName isEqualToString:peripheral.name]) {
                isIn = YES;
            }
        }
        if (!isIn) {
            [self.pipeline.pointArr addObject:model];
            [self.radarView show];
        }
        dispatch_async_on_main_queue(^{
            self.radarView.labelText = [NSString stringWithFormat:@"正在搜索附近的蓝牙设备\n已搜索到%lu个目标", (unsigned long)self.pipeline.pointArr.count];
        });
       
    }];

        //设置查找设备的过滤器
    [self.pipeline.babyBluetooth setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
            //最常用的场景是查找某一个前缀开头的设备 most common usage is discover for peripheral that name has common prefix
        if ([peripheralName hasPrefix:@"Bluno"] ) {
            return YES;
        }
//        return NO;
//            设置查找规则是名称大于1 ， the search rule is peripheral.name length > 1
//        if (peripheralName.length >1) {
//            return YES;
//        }
        return NO;
    }];

    [self.pipeline.babyBluetooth setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
        @strongify(self);
        dispatch_async_on_main_queue(^{
            self.radarView.labelText = [NSString stringWithFormat:@"搜索已完成，共找到%lu个目标", (unsigned long)self.pipeline.pointArr.count];
            [self.radarView stop];
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:15 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                    self.radarListView.frame = (CGRect){15,64,kScreenSize.width-30,kScreenSize.height-64-140};
            } completion:^(BOOL finished) {
                self.radarListView.bluetoothList = self.pipeline.pointArr;
            }];
        });
    }];

}
    
@end
