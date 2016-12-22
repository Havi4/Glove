//
// GameView.m
// BaseAppStruct
//
// Created by Havi on 2016/11/17
// Copyright 2016 Havi. All right reserved.
//

#import "GameView.h"
#import "UIView+MIPipeline.h"
#import "GamePipeline.h"
#import <WebKit/WebKit.h>
#define channelOnPeropheralView @"peripheralView"


@interface GameView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) GamePipeline *pipeline;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *naviBarView;
@property (nonatomic, assign) BOOL isShowNavi;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSString *dataString;
@property (nonatomic, assign) int oldValue;
@property (nonatomic, assign) int currentValue;
@end

@implementation GameView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; //Get the notification centre for the app
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:nil];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, kScreenSize.height, kScreenSize.width)];
//
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.scrollEnabled = NO;
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"closeMe"];
    [self addSubview:_webView];
    [self configWebView];
    self.naviBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.height, 44)];
    self.naviBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi_lanscpe_back"]];
    [self addSubview:self.naviBarView];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 80, 44);
    [backButton setImage:[[UIImage imageNamed:@"navi_back"] imageByTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:kTitleNumberFont(kSubTitleNum)];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.naviBarView addSubview:backButton];
    [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.naviBarView.alpha = 0;
    } completion:^(BOOL finished) {
        self.isShowNavi = NO;
    }];
    //测试
    self.textView = [[UITextView alloc]init];
    self.textView.text = @"实时数据展示";
    self.textView.frame =(CGRect){100,0,250,30};
    self.textView.textColor = [UIColor whiteColor];
    self.textView.backgroundColor = [UIColor clearColor];
    [self.webView addSubview:self.textView];
}

//OC在JS调用方法做的处理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"JS 调用了 %@ 方法，传回参数 %@",message.name,message.body);
    if (!self.isShowNavi) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.naviBarView.alpha = 1;
        } completion:^(BOOL finished) {
            self.isShowNavi = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.isShowNavi) {
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.naviBarView.alpha = 0;
                    } completion:^(BOOL finished) {
                        self.isShowNavi = NO;
                    }];
                }
            });
        }];

    }else{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.naviBarView.alpha = 0;
        } completion:^(BOOL finished) {
             self.isShowNavi = NO;
        }];
    }
}

- (void)backHome:(UIButton *)button
{
    self.pipeline.jsAlertShow = YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{

}
- (void)showNaviBar
{
    DeBugLog(@"点击了屏幕");
}

- (void)configWebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (void)orientationChanged:(NSNotification *)note  {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    switch (o) {
        case UIDeviceOrientationLandscapeLeft:      // Device oriented horizontally, home button on the left
            self.frame = CGRectMake(0, 0, kScreenSize.height, kScreenSize.width);
            DeBugLog(@"坐标%f",kScreenSize.height);
            break;
        default:
            break;
    }   
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [self.pipeline.babyBluetooth cancelAllPeripheralsConnection];
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline {
    self.pipeline = pipeline;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.pipeline.gameUrl]]];
    [self babyDelegate];
    
    //开始扫描设备
    [self performSelector:@selector(loadData) withObject:nil afterDelay:2];
    [SVProgressHUD showInfoWithStatus:@"准备连接设备"];
//    [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        int y = [self getRandomNumber:0 to:370];
//        [self setJSData:[NSString stringWithFormat:@"%d",y]];
//    }];

}

#pragma mark bluetooth

//babyDelegate
-(void)babyDelegate{
    @weakify(self);
    BabyRhythm *rhythm = [[BabyRhythm alloc]init];
    //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [self.pipeline.babyBluetooth setBlockOnConnectedAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接成功",peripheral.name]];
    }];
    
    //设置设备连接失败的委托
    [self.pipeline.babyBluetooth setBlockOnFailToConnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--连接失败",peripheral.name);
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接失败",peripheral.name]];
    }];

    //设置设备断开连接的委托
    [self.pipeline.babyBluetooth setBlockOnDisconnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--断开连接",peripheral.name);
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--断开失败",peripheral.name]];
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

-(int)getRandomNumber:(int)from to:(int)to
{
  return (int)(from + (arc4random() % (to - from + 1)));
}

//订阅一个值
-(void)setNotifiy:(id)service{
    NSLog(@"===服务名词 name:%@",[service characteristics]);
    @weakify(self);
    if(currPeripheral.state != CBPeripheralStateConnected) {
        [SVProgressHUD showErrorWithStatus:@"peripheral已经断开连接，请重新连接"];
        return;
    }
    if (service) {
        CBCharacteristic *characteristic = [[service characteristics]objectAtIndex:0];
        [self.pipeline.currPeripheral setNotifyValue:YES forCharacteristic:characteristic];
        [self.pipeline.babyBluetooth
                  notify:currPeripheral
          characteristic:characteristic
                   block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
                   NSString *new = [[NSString alloc] initWithData:characteristics.value encoding:NSUTF8StringEncoding];
                   NSString *cuta = [new stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                   NSString *cutr = [cuta stringByReplacingOccurrencesOfString:@"\r" withString:@""];

                   @synchronized (self) {
                       self.dataString = new;
                       NSRange rangeA = [new rangeOfString:@"A"];
                       NSRange rangeB = [new rangeOfString:@"B"];
                       NSRange rangeC = [new rangeOfString:@"C"];
                       NSRange rangeD = [new rangeOfString:@"D"];
                       NSRange rangeE = [new rangeOfString:@"E"];
                       if (rangeA.length != 0 && new.length > 15 && rangeB.length != 0 && rangeC.length != 0 && rangeD.length != 0 && rangeE.length != 0) {
                           int A = [[new substringWithRange:NSMakeRange(rangeA.location+1, rangeB.location-1)]intValue];
                           int B = [[new substringWithRange:NSMakeRange(rangeB.location+1, rangeC.location - rangeB.location)]intValue];
                           int C = [[new substringWithRange:NSMakeRange(rangeC.location+1, rangeD.location - rangeC.location)]intValue];
                           int D = [[new substringWithRange:NSMakeRange(rangeD.location+1, rangeE.location-rangeD.location)]intValue];
                           int E = [[new substringFromIndex:rangeE.location+1]intValue];
                           int all = A + B + C +D +E;
                           self.textView.text = [NSString stringWithFormat:@"%d：%d,%d,%d,%d,%d",all,A,B,C,D,E];
                           self.currentValue = all;
                           int a = self.currentValue - self.oldValue;
                           DeBugLog(@"差值是%d",a);
                           //原始值620；
                           if (abs(a) > 10 && self.oldValue != 0) {
                               [self setJSData:[NSString stringWithFormat:@"%f",(self.currentValue-minFingerData)*(375.0/(maxFingerData-minFingerData))]];
                           }
                           self.oldValue = self.currentValue;
                       }
                   };
        }];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"这个characteristic没有nofity的权限"];
        return;
    }
    
}

- (void)setJSData:(NSString *)value
{
    NSString *jsMethod = [NSString stringWithFormat:@"getBluetoothValue(%@)",value];
    [self.webView evaluateJavaScript:jsMethod completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (error) {
            DeBugLog(@"js错误%@ %@",response,error);
        }
    }];
}

-(void)loadData{
    [SVProgressHUD showInfoWithStatus:@"开始连接设备"];
    self.pipeline.babyBluetooth.having(currPeripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
}

@end
