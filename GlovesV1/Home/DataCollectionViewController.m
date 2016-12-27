//
//  DataCollectionViewController.m
//  GlovesV1
//
//  Created by HaviLee on 2016/12/22.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "DataCollectionViewController.h"
#import "DataFingerableViewCell.h"
#define channelOnPeropheralView @"peripheralView"

@interface DataCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) BabyBluetooth *babyBluetooth;
@property (nonatomic, assign) NSInteger min1FingerData;
@property (nonatomic, assign) NSInteger max1FingerData;
@property (nonatomic, assign) NSInteger min2FingerData;
@property (nonatomic, assign) NSInteger max2FingerData;
@property (nonatomic, assign) NSInteger min3FingerData;
@property (nonatomic, assign) NSInteger max3FingerData;
@property (nonatomic, assign) NSInteger min4FingerData;
@property (nonatomic, assign) NSInteger max4FingerData;
@property (nonatomic, assign) NSInteger min5FingerData;
@property (nonatomic, assign) NSInteger max5FingerData;
@property (nonatomic, strong) NSString *buttonTitile;
@end

@implementation DataCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"background_image"];
    [self.view addSubview:backImageView];
    self.title = @"数据采集";
    [self.view addSubview:self.tableView];
    self.min1FingerData = 1000;
    self.max1FingerData = 0;
    self.min2FingerData = 1000;
    self.max2FingerData = 0;
    self.min3FingerData = 1000;
    self.max3FingerData = 0;
    self.min4FingerData = 1000;
    self.max4FingerData = 0;
    self.min5FingerData = 1000;
    self.max5FingerData = 0;
    self.buttonTitile = @"开始采集数据";

}

- (BabyBluetooth *)babyBluetooth
{
    if (!_babyBluetooth) {
        _babyBluetooth = [BabyBluetooth shareBabyBluetooth];
    }
    return _babyBluetooth;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fingerArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<self.fingerArr.count) {

        DataFingerableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[DataFingerableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSString *title = [self.fingerArr objectAtIndex:indexPath.row];
        cell.fingerDataTitle.text = title;
        if ([title isEqualToString:@"小拇指"]) {
            cell.minDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.min5FingerData];
            cell.maxDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.max5FingerData];
        }else if ([title isEqualToString:@"无名指"]){
            cell.minDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.min4FingerData];
            cell.maxDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.max4FingerData];
        }else if ([title isEqualToString:@"中指"]){
            cell.minDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.min3FingerData];
            cell.maxDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.max4FingerData];
        }else if ([title isEqualToString:@"食指"]){
            cell.minDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.min2FingerData];
            cell.maxDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.max2FingerData];
        }else if ([title isEqualToString:@"大拇指"]){
            cell.minDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.min1FingerData];
            cell.maxDataLabel.text = [NSString stringWithFormat:@"%ld",(long)self.max1FingerData];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"c"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"c"];
        }
        cell.backgroundColor = [UIColor clearColor];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = (CGRect){30,(100-44)/2,kScreenSize.width-60,44};
        [_button setTitle:self.buttonTitile forState:UIControlStateNormal];
        _button.backgroundColor = kBarHightlightedColor;
        _button.layer.cornerRadius = 5;
        _button.layer.masksToBounds = YES;
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setTarget:self action:@selector(startEx:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:_button];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<self.fingerArr.count) {

        return 60;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]init];
    label.frame = (CGRect){15,0,kScreenSize.width-30,60};
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击『开始采集数据』后，\n请尽量的伸开手掌然后握紧手掌";
    return label;
}


- (void)startEx:(UIButton *)sender
{
    DeBugLog(@"测试");
    if ([sender.titleLabel.text isEqualToString:@"开始采集数据"]) {
        self.buttonTitile =@"采集完毕开始训练";
        [self.button setTitle:self.buttonTitile forState:UIControlStateNormal];
        [self getBlueData];
    }else {
        MIScene *gameScene = [MIScene sceneWithView:@"GameView" controller:@"GameViewController" store:@"GameStore"];
        UIViewController *gameViewController = [[MIMediator sharedMediator] viewControllerWithScene:gameScene context:self.settingDic];
        [self.navigationController pushViewController:gameViewController animated:YES];
    }
}

- (void)getBlueData
{
    @weakify(self);
    BabyRhythm *rhythm = [[BabyRhythm alloc]init];
        //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [self.babyBluetooth setBlockOnConnectedAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
            //        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接成功",peripheral.name]];
    }];

        //设置设备连接失败的委托
    [self.babyBluetooth setBlockOnFailToConnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--连接失败",peripheral.name);
            //        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接失败",peripheral.name]];
    }];

        //设置设备断开连接的委托
    [self.babyBluetooth setBlockOnDisconnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--断开连接",peripheral.name);
            //        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--断开失败",peripheral.name]];
    }];

        //设置发现设备的Services的委托
    [self.babyBluetooth setBlockOnDiscoverServicesAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, NSError *error) {
        for (CBService *s in peripheral.services) {
                ///插入section到tableview
            NSLog(@"%@",s);
        }

        [rhythm beats];
    }];
        //设置发现设service的Characteristics的委托
    [self.babyBluetooth setBlockOnDiscoverCharacteristicsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
            //插入row到tableview
    }];
        //设置读取characteristics的委托
    [self.babyBluetooth setBlockOnReadValueForCharacteristicAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
        //设置发现characteristics的descriptors的委托
    [self.babyBluetooth setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
        //设置读取Descriptor的委托
    [self.babyBluetooth setBlockOnReadValueForDescriptorsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];

        //读取rssi的委托
    [self.babyBluetooth setBlockOnDidReadRSSI:^(NSNumber *RSSI, NSError *error) {
        NSLog(@"setBlockOnDidReadRSSI:RSSI:%@",RSSI);
    }];


        //设置beats break委托
    [rhythm setBlockOnBeatsBreak:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsBreak call");


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

    [self.babyBluetooth setBabyOptionsAtChannel:channelOnPeropheralView scanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectOptions scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];



        //

        //设置发现设service的Characteristics的委托
    [self.babyBluetooth setBlockOnDiscoverCharacteristicsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        @strongify(self);
        NSLog(@"测试的服务UUIDis %@",service.UUID);
        if ([[NSString stringWithFormat:@"%@",service.UUID] isEqualToString:@"DFB0"]) {
            [self setNotifiy:service];
        }

    }];

    self.babyBluetooth.having(currPeripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();

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
        [self.babyBluetooth
         notify:currPeripheral
         characteristic:characteristic
         block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {

             NSString *new = [[NSString alloc] initWithData:characteristics.value encoding:NSUTF8StringEncoding];
             NSString *cuta = [new stringByReplacingOccurrencesOfString:@"\n" withString:@""];
             NSString *cutr = [cuta stringByReplacingOccurrencesOfString:@"\r" withString:@""];
             DeBugLog(@"%@",peripheral);
             NSRange rangeA = [new rangeOfString:@"A"];
             NSRange rangeB = [new rangeOfString:@"B"];
             NSRange rangeC = [new rangeOfString:@"C"];
             NSRange rangeD = [new rangeOfString:@"D"];
             NSRange rangeE = [new rangeOfString:@"E"];
             if (rangeA.length != 0 && new.length > 15 && rangeB.length != 0 && rangeC.length != 0 && rangeD.length != 0 && rangeE.length != 0) {
                     //原始值620；
                 int A = [[new substringWithRange:NSMakeRange(rangeA.location+1, rangeB.location-1)]intValue];
                 int B = [[new substringWithRange:NSMakeRange(rangeB.location+1, rangeC.location - rangeB.location)]intValue];
                 int C = [[new substringWithRange:NSMakeRange(rangeC.location+1, rangeD.location - rangeC.location)]intValue];
                 int D = [[new substringWithRange:NSMakeRange(rangeD.location+1, rangeE.location-rangeD.location)]intValue];
                 int E = [[new substringFromIndex:rangeE.location+1]intValue];
                 int all = A + B + C +D +E;
                 if (abs(all)<minFingerData) {
                     minFingerData = abs(all);
                 }else if(abs(all)>maxFingerData){
                     maxFingerData = abs(all);
                 }
                 if (abs(A)<self.min1FingerData) {
                     self.min1FingerData = abs(A);
                 }else if (abs(A)>self.max1FingerData){
                     self.max1FingerData = abs(A);
                 }

                 if (abs(B)<self.min2FingerData) {
                     self.min2FingerData = abs(B);
                 }else if (abs(B)>self.max2FingerData){
                     self.max2FingerData = abs(B);
                 }

                 if (abs(C)<self.min3FingerData) {
                     self.min3FingerData = abs(C);
                 }else if (abs(C)>self.max3FingerData){
                     self.max3FingerData = abs(C);
                 }

                 if (abs(D)<self.min4FingerData) {
                     self.min4FingerData = abs(D);
                 }else if (abs(D)>self.max4FingerData){
                     self.max4FingerData = abs(D);
                 }

                 if (abs(E)<self.min5FingerData) {
                     self.min5FingerData = abs(E);
                 }else if (abs(E)>self.max5FingerData){
                     self.max5FingerData = abs(E);
                 }
                 [self.tableView reloadData];
             }
         }];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"这个characteristic没有nofity的权限"];
        return;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
