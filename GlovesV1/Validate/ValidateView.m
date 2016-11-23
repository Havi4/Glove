//
// ValidateView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/22
// Copyright 2016 Havi. All right reserved.
//

#import "ValidateView.h"
#import "UIView+MIPipeline.h"
#import "ValidatePipeline.h"
#import "GloveBackView.h"
#import "SCLAlertView.h"
#import "FingerSubView.h"
#define channelOnPeropheralView @"peripheralView"

@interface ValidateView ()

@property (nonatomic, strong) ValidatePipeline *pipeline;
@property (nonatomic, strong) GloveBackView *gloveBackView;

@property (nonatomic, strong) FingerSubView *leftView;
@property (nonatomic, strong) FingerSubView *rightView;

@end

@implementation ValidateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.gloveBackView = [[GloveBackView alloc]initWithFrame:(CGRect){15,15,kScreenSize.width -30,(kScreenSize.height-64-50)*0.73}];
    [self addSubview:self.gloveBackView];

    self.leftView = [[FingerSubView alloc]initWithFrame:(CGRect){15,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27}];
    [self addSubview:self.leftView];

    self.rightView = [[FingerSubView alloc]initWithFrame:(CGRect){kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27}];
    [self addSubview:self.rightView];
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert setTitleFontFamily:@"PingFangSC-Regular" withSize:20.0f];
    [alert setBodyTextFontFamily:@"PingFangSC-Regulart" withSize:16.0f];
    [alert setButtonsTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
    [alert addButton:@"开始校验" actionBlock:^(void) {
        [self startValidate];
    }];

    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [NSBundle mainBundle].resourcePath]];

    [alert showNotice:@"提示" subTitle:@"请根据界面提示伸握手指完成手套校验" closeButtonTitle:nil duration:0];
}

- (void)startValidate
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gloveBackView startValidateGloveWithIndex:1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:15 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.leftView.frame = (CGRect){-kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.rightView.frame = (CGRect){15,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.rightView.titleString = @"第二步";
                self.rightView.subTitleString = @"请握紧食指";
            } completion:^(BOOL finished) {
                self.leftView.frame = (CGRect){kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
            }];
        });


    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gloveBackView startValidateGloveWithIndex:2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:15 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.rightView.frame = (CGRect){-kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.leftView.frame = (CGRect){15,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.leftView.titleString = @"第三步";
                self.leftView.subTitleString = @"请握紧中指";
            } completion:^(BOOL finished) {
                self.rightView.frame = (CGRect){kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
            }];
        });

    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gloveBackView startValidateGloveWithIndex:3];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:15 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.leftView.frame = (CGRect){-kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.rightView.frame = (CGRect){15,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.rightView.titleString = @"第四步";
                self.rightView.subTitleString = @"请握紧无名指";
            } completion:^(BOOL finished) {
                self.leftView.frame = (CGRect){kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
            }];
        });

    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gloveBackView startValidateGloveWithIndex:4];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:15 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.rightView.frame = (CGRect){-kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.leftView.frame = (CGRect){15,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.leftView.titleString = @"第五步";
                self.leftView.subTitleString = @"请握紧小拇指";
            } completion:^(BOOL finished) {
                self.rightView.frame = (CGRect){kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
            }];
        });

    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gloveBackView startValidateGloveWithIndex:5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setTitleFontFamily:@"PingFangSC-Regular" withSize:20.0f];
            [alert setBodyTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
            [alert setButtonsTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
            [alert addButton:@"校准手套" actionBlock:^(void) {
                DeBugLog(@"校准手套");

            }];

            alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [NSBundle mainBundle].resourcePath]];

            [alert showSuccess:@"成功" subTitle:@"手套校验完成" closeButtonTitle:@"开始训练" duration:0.0f];
        });
    });
}

- (void)getBlueData
{
    self.pipeline.babyBluetooth.having(currPeripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();

    @weakify(self);
    BabyRhythm *rhythm = [[BabyRhythm alloc]init];
        //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [self.pipeline.babyBluetooth setBlockOnConnectedAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
//        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接成功",peripheral.name]];
    }];

        //设置设备连接失败的委托
    [self.pipeline.babyBluetooth setBlockOnFailToConnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--连接失败",peripheral.name);
//        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接失败",peripheral.name]];
    }];

        //设置设备断开连接的委托
    [self.pipeline.babyBluetooth setBlockOnDisconnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--断开连接",peripheral.name);
//        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--断开失败",peripheral.name]];
    }];

        //设置发现设备的Services的委托
    [self.pipeline.babyBluetooth setBlockOnDiscoverServicesAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, NSError *error) {
        for (CBService *s in peripheral.services) {
                ///插入section到tableview
            NSLog(@"%@",s);
        }

        [rhythm beats];
    }];
        //设置发现设service的Characteristics的委托
    [self.pipeline.babyBluetooth setBlockOnDiscoverCharacteristicsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
            //插入row到tableview
    }];
        //设置读取characteristics的委托
    [self.pipeline.babyBluetooth setBlockOnReadValueForCharacteristicAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
        //设置发现characteristics的descriptors的委托
    [self.pipeline.babyBluetooth setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
        //设置读取Descriptor的委托
    [self.pipeline.babyBluetooth setBlockOnReadValueForDescriptorsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];

        //读取rssi的委托
    [self.pipeline.babyBluetooth setBlockOnDidReadRSSI:^(NSNumber *RSSI, NSError *error) {
        NSLog(@"setBlockOnDidReadRSSI:RSSI:%@",RSSI);
    }];


        //设置beats break委托
    [rhythm setBlockOnBeatsBreak:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsBreak call");

            //如果完成任务，即可停止beat,返回bry可以省去使用weak rhythm的麻烦
            //        if (<#condition#>) {
            //            [bry beatsOver];
            //        }

    }];

        //设置beats over委托
    [rhythm setBlockOnBeatsOver:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsOver call");
    }];

        //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    /*连接选项->
     CBConnectPeripheralOptionNotifyOnConnectionKey :当应用挂起时，如果有一个连接成功时，如果我们想要系统为指定的peripheral显示一个提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnDisconnectionKey :当应用挂起时，如果连接断开时，如果我们想要系统为指定的peripheral显示一个断开连接的提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnNotificationKey:
     当应用挂起时，使用该key值表示只要接收到给定peripheral端的通知就显示一个提
     */
    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnNotificationKey:@YES};

    [self.pipeline.babyBluetooth setBabyOptionsAtChannel:channelOnPeropheralView scanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectOptions scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];



        //

        //设置发现设service的Characteristics的委托
    [self.pipeline.babyBluetooth setBlockOnDiscoverCharacteristicsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        @strongify(self);
        NSLog(@"测试的服务UUIDis %@",service.UUID);
        if ([[NSString stringWithFormat:@"%@",service.UUID] isEqualToString:@"DFB0"]) {
            [self setNotifiy:service];
        }
        
    }];

}

-(void)setNotifiy:(id)service{
    NSLog(@"===服务名词 name:%@",[service characteristics]);
    @weakify(self);
    if(currPeripheral.state != CBPeripheralStateConnected) {
        [SVProgressHUD showErrorWithStatus:@"peripheral已经断开连接，请重新连接"];
        return;
    }
    if (service) {
        CBCharacteristic *characteristic = [[service characteristics]objectAtIndex:0];
        [currPeripheral setNotifyValue:YES forCharacteristic:characteristic];
        [self.pipeline.babyBluetooth
         notify:currPeripheral
         characteristic:characteristic
         block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
             NSString *new = [[NSString alloc] initWithData:characteristics.value encoding:NSUTF8StringEncoding];
             NSString *cuta = [new stringByReplacingOccurrencesOfString:@"\n" withString:@""];
             NSString *cutr = [cuta stringByReplacingOccurrencesOfString:@"\r" withString:@""];
         }];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"这个characteristic没有nofity的权限"];
        return;
    }

}

@end
