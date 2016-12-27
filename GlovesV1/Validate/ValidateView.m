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
#import "FingerDataView.h"
#define channelOnPeropheralView @"peripheralView"

@interface ValidateView ()

@property (nonatomic, strong) ValidatePipeline *pipeline;
@property (nonatomic, strong) GloveBackView *gloveBackView;
@property (nonatomic, strong) FingerDataView *dataView;

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

    self.dataView = [[FingerDataView alloc]initWithFrame:(CGRect){kScreenSize.width,15,kScreenSize.width -30,(kScreenSize.height-64-50)*0.73}];
    [self addSubview:self.dataView];
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
    [self getBlueData];
    @weakify(self)
    __block BOOL isDone = YES;
    [MIObserve(self.pipeline, blueCurrentNum) changed:^(id  _Nonnull newValue) {
        @strongify(self)
        if (isDone && self.pipeline.blueCurrentNum.length > 15) {

            isDone = NO;
        }
    }];
}

- (void)startValidate
{

    self.leftView.titleString = @"第一步";
    self.leftView.subTitleString = @"请尽量握紧拳头5秒钟";
    __block NSTimer *timer1;
    __block NSTimer *timer2;
    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.pipeline.blueCurrentNum.length>0) {
            [self.pipeline.dataArr addObject:self.pipeline.blueCurrentNum];
        }
        DeBugLog(@"数组%@",self.pipeline.dataArr);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timer1 invalidate];
        timer2 = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (self.pipeline.blueCurrentNum.length>0) {
                [self.pipeline.dataArr1 addObject:self.pipeline.blueCurrentNum];
            }
            DeBugLog(@"数组1%@",self.pipeline.dataArr1);
        }];
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:15 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.leftView.frame = (CGRect){-kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
            self.rightView.frame = (CGRect){15,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
            self.rightView.titleString = @"第二步";
            self.rightView.subTitleString = @"请尽量伸开手掌5秒钟";
        } completion:^(BOOL finished) {
            self.leftView.frame = (CGRect){kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
        }];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timer2 invalidate];
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:15 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.rightView.frame = (CGRect){-kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
            self.leftView.frame = (CGRect){15,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
            self.leftView.titleString = @"数据处理中";
            self.leftView.subTitleString = @"请稍等";
        } completion:^(BOOL finished) {
            self.rightView.frame = (CGRect){kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
        }];
        int maxTotal = 0, minTotal = 4000, maxOne = 0, minOne = 1000;
        int maxTwo = 0, minTwo = 1000,maxThree = 0,minThree = 1000,maxFour = 0,minFour = 1000;
        int maxFive = 0,minFive = 1000;

        for (NSString *data in self.pipeline.dataArr) {
            if (data.length > 0) {
                NSString *dataA = data;
                NSRange A = [dataA rangeOfString:@"A"];
                NSRange B = [dataA rangeOfString:@"B"];
                int one = [[dataA substringWithRange:NSMakeRange(A.location+1, B.location)] intValue];
                NSString *bSub = [dataA substringFromIndex:B.location+1];
                NSRange C = [bSub rangeOfString:@"C"];
                int two = [[bSub substringWithRange:NSMakeRange(0, C.location)] intValue];
                NSString *cSub = [bSub substringFromIndex:C.location+1];
                NSRange D = [cSub rangeOfString:@"D"];
                int three = [[cSub substringWithRange:NSMakeRange(0, D.location)] intValue];
                NSString *dSub = [cSub substringFromIndex:D.location+1];
                NSRange E = [dSub rangeOfString:@"E"];
                int four = [[dSub substringWithRange:NSMakeRange(0, E.location)] intValue];
                NSString *eSub = [dSub substringFromIndex:E.location+1];
                NSRange F = [eSub rangeOfString:@"F"];
                int five = [[eSub substringWithRange:NSMakeRange(0, F.location)] intValue];

                if (one > maxOne) {
                    maxOne = one;
                }
                if (two > maxTwo) {
                    maxTwo = two;
                }
                if (three > maxThree) {
                    maxThree = three;
                }
                if (four > maxFour) {
                    maxFour = four;
                }
                if (five > maxFive) {
                    maxFive = five;
                }
            }
        }


        for (NSString *data1 in self.pipeline.dataArr1) {
            if (data1.length > 0) {
                NSString *dataA = data1;
                NSRange A = [dataA rangeOfString:@"A"];
                NSRange B = [dataA rangeOfString:@"B"];
                int one = [[dataA substringWithRange:NSMakeRange(A.location+1, B.location)] intValue];
                NSString *bSub = [dataA substringFromIndex:B.location+1];
                NSRange C = [bSub rangeOfString:@"C"];
                int two = [[bSub substringWithRange:NSMakeRange(0, C.location)] intValue];
                NSString *cSub = [bSub substringFromIndex:C.location+1];
                NSRange D = [cSub rangeOfString:@"D"];
                int three = [[cSub substringWithRange:NSMakeRange(0, D.location)] intValue];
                NSString *dSub = [cSub substringFromIndex:D.location+1];
                NSRange E = [dSub rangeOfString:@"E"];
                int four = [[dSub substringWithRange:NSMakeRange(0, E.location)] intValue];
                NSString *eSub = [dSub substringFromIndex:E.location+1];
                NSRange F = [eSub rangeOfString:@"F"];
                int five = [[eSub substringWithRange:NSMakeRange(0, F.location)] intValue];
                if (one < minOne) {
                    minOne = one;
                }
                if (two < minTwo) {
                    minTwo = two;
                }
                if (three < minThree) {
                    minThree = three;
                }
                if (four < minFour) {
                    minFour = four;
                }
                if (five < minFive) {
                    minFive = five;
                }
            }

        }

        if ((minOne != maxOne)&&minOne != 0) {
            self.pipeline.firstFingerOK = YES;
        }else {
            self.pipeline.firstFingerOK = NO;
        }

        if ((minTwo != maxTwo) && minTwo != 0) {
            self.pipeline.twoFingerOK = YES;
        }else {
            self.pipeline.twoFingerOK = NO;
        }

        if ((minThree != maxThree) && minThree != 0) {
            self.pipeline.threeFingerOK = YES;
        }else {
            self.pipeline.threeFingerOK = NO;
        }

        if ((minFour != maxFour) && minFour != 0) {
            self.pipeline.fourFingerOK = YES;
        }else {
            self.pipeline.fourFingerOK = NO;
        }

        if ((minFive != maxFive )&& minFive != 0) {
            self.pipeline.fiveFingerOK = YES;
        }else {
            self.pipeline.fiveFingerOK = NO;
        }
        if (self.pipeline.firstFingerOK) {
            [self.gloveBackView startValidateGloveWithIndex:1 isOK:YES];
        }else{
            [self.gloveBackView startValidateGloveWithIndex:1 isOK:NO];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.pipeline.twoFingerOK) {
                [self.gloveBackView startValidateGloveWithIndex:2 isOK:YES];
            }else{
                [self.gloveBackView startValidateGloveWithIndex:2 isOK:NO];
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.pipeline.threeFingerOK) {
                [self.gloveBackView startValidateGloveWithIndex:3 isOK:YES];
            }else{
                [self.gloveBackView startValidateGloveWithIndex:3 isOK:NO];
            }

        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.pipeline.fourFingerOK) {
                [self.gloveBackView startValidateGloveWithIndex:4 isOK:YES];
            }else{
                [self.gloveBackView startValidateGloveWithIndex:4 isOK:NO];
            }

        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.pipeline.fiveFingerOK) {
                [self.gloveBackView startValidateGloveWithIndex:5 isOK:YES];
            }else{
                [self.gloveBackView startValidateGloveWithIndex:5 isOK:NO];
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            self.leftView.titleString = @"处理完成";
            self.leftView.subTitleString = @"";
            if (self.pipeline.fiveFingerOK && self.pipeline.twoFingerOK && self.pipeline.threeFingerOK && self.pipeline.fourFingerOK && self.pipeline.fiveFingerOK) {
                minFingerData = minTotal;
                maxFingerData = maxTotal;
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setTitleFontFamily:@"PingFangSC-Regular" withSize:20.0f];
                [alert setBodyTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
                [alert setButtonsTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
                [alert addButton:@"开始训练" actionBlock:^(void) {
                    DeBugLog(@"开始训练");
                    self.pipeline.checkDone = YES;
                }];

                alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [NSBundle mainBundle].resourcePath]];

                [alert showSuccess:@"成功" subTitle:@"手套校验完成" closeButtonTitle:nil duration:0.0f];
            }else{
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert setTitleFontFamily:@"PingFangSC-Regular" withSize:20.0f];
                [alert setBodyTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
                [alert setButtonsTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
                [alert addButton:@"重新校验" actionBlock:^(void) {
                    DeBugLog(@"重新训练");
                    [self.gloveBackView reLoadView];
                    [self startValidate];
                }];

                alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [NSBundle mainBundle].resourcePath]];
                [alert showError:@"失败" subTitle:@"手套校验失败" closeButtonTitle:nil duration:0];
            }
        });


    });
    /*
    self.leftView.titleString = @"第一步";
    self.leftView.subTitleString = @"请握紧大拇指";
    __block NSTimer *timer1;
    __block NSTimer *timer2;
    __block NSTimer *timer3;
    __block NSTimer *timer4;
    __block NSTimer *timer5;
    __block int old = 0;

    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        DeBugLog(@"手指1%@",self.pipeline.blueCurrentNum);
        NSRange rangeA = [self.pipeline.blueCurrentNum rangeOfString:@"A"];
        NSRange rangeB = [self.pipeline.blueCurrentNum rangeOfString:@"B"];
        int A = [[self.pipeline.blueCurrentNum substringWithRange:NSMakeRange(rangeA.location+1, rangeB.location-1)]intValue];
        if (old == 0) {
            old = A;
        }else{
            if (old != A) {
                self.pipeline.firstFingerOK = YES;
            }
        }
        old = A;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timer1 invalidate];
        old = 0;
        if (self.pipeline.firstFingerOK) {
            [self.gloveBackView startValidateGloveWithIndex:1 isOK:YES];
        }else{
            [self.gloveBackView startValidateGloveWithIndex:1 isOK:NO];
        }
        //第二根指头
        DeBugLog(@"手指2%@",self.pipeline.blueCurrentNum);
        timer2 = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSRange rangeB = [self.pipeline.blueCurrentNum rangeOfString:@"B"];
            NSRange rangeC = [self.pipeline.blueCurrentNum rangeOfString:@"C"];
            int B = [[self.pipeline.blueCurrentNum substringWithRange:NSMakeRange(rangeB.location+1, rangeC.location-1)]intValue];
            if (old == 0) {
                old = B;
            }else{
                if (old != B) {
                    self.pipeline.twoFingerOK = YES;
                }

            }
            old = B;
        }];
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
        [timer2 invalidate];
        old = 0;
        if (self.pipeline.twoFingerOK) {
            [self.gloveBackView startValidateGloveWithIndex:2 isOK:YES];
        }else{
            [self.gloveBackView startValidateGloveWithIndex:2 isOK:NO];
        }
            //第三根指头
        DeBugLog(@"手指3%@",self.pipeline.blueCurrentNum);
        timer3 = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSRange rangeC = [self.pipeline.blueCurrentNum rangeOfString:@"C"];
            NSRange rangeD = [self.pipeline.blueCurrentNum rangeOfString:@"D"];
            int C = [[self.pipeline.blueCurrentNum substringWithRange:NSMakeRange(rangeC.location+1, rangeD.location-1)]intValue];
            if (old == 0) {
                old = C;
            }else{
                if (old != C) {
                    self.pipeline.threeFingerOK = YES;
                }
            }
            old = C;
        }];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timer3 invalidate];
        old = 0;
        if (self.pipeline.threeFingerOK) {
            [self.gloveBackView startValidateGloveWithIndex:3 isOK:YES];
        }else{
            [self.gloveBackView startValidateGloveWithIndex:3 isOK:NO];
        }
            //第四根指头
        DeBugLog(@"手指4%@",self.pipeline.blueCurrentNum);
        timer4 = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSRange rangeD = [self.pipeline.blueCurrentNum rangeOfString:@"D"];
//            NSRange rangeE = [self.pipeline.blueCurrentNum rangeOfString:@"E"];
//            int D = [[self.pipeline.blueCurrentNum substringWithRange:NSMakeRange(rangeD.location+1, rangeE.location-1)]intValue];
//            if (old == 0) {
//                old = D;
//            }else{
//                if (old != D) {
//                    self.pipeline.fourFingerOK = YES;
//                }
//            }
//            old = D;
        }];
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
        [timer4 invalidate];
        if (self.pipeline.fourFingerOK) {
            [self.gloveBackView startValidateGloveWithIndex:4 isOK:YES];
        }else{
            [self.gloveBackView startValidateGloveWithIndex:4 isOK:NO];
        }
        old = 0;
            //第五根指头
        DeBugLog(@"手指5%@",self.pipeline.blueCurrentNum);
        timer5 = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSRange rangeE = [self.pipeline.blueCurrentNum rangeOfString:@"E"];
            int E = [[self.pipeline.blueCurrentNum substringFromIndex:rangeE.location+1]intValue];
            if (old == 0) {
                old = E;
            }else{
                if (old != E) {
                    self.pipeline.fiveFingerOK = YES;
                }
            }
            old = E;
        }];

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
        [timer5 invalidate];
        old = 0;
        if (self.pipeline.fiveFingerOK) {
            [self.gloveBackView startValidateGloveWithIndex:5 isOK:YES];
        }else{
            [self.gloveBackView startValidateGloveWithIndex:5 isOK:NO];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:15 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.leftView.frame = (CGRect){-kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.rightView.frame = (CGRect){15,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
                self.rightView.titleString = @"第六步";
                self.rightView.subTitleString = @"请握紧拳头";
                self.dataView.frame = (CGRect){15,15,kScreenSize.width -30,(kScreenSize.height-64-50)*0.73};
                self.gloveBackView.frame = (CGRect){-kScreenSize.width,15,kScreenSize.width -30,(kScreenSize.height-64-50)*0.73};
            } completion:^(BOOL finished) {
                self.leftView.frame = (CGRect){kScreenSize.width,(kScreenSize.height-64-50)*0.73 + 35,kScreenSize.width -30,(kScreenSize.height-64-50)*0.27};
            }];
        });

    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(18 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        self.dataView.minCheckOK = @"最小握力检测完成";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:15 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.rightView.titleString = @"第六步";
                self.rightView.subTitleString = @"请伸开手掌";
            } completion:^(BOOL finished) {

            }];
        });

    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(21 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataView.minCheckOK = @"最大握力检测完成";
        if (self.pipeline.fiveFingerOK && self.pipeline.twoFingerOK && self.pipeline.threeFingerOK && self.pipeline.fourFingerOK && self.pipeline.fiveFingerOK) {
                //                isDeviceOK = YES;
            self.pipeline.fingerCheckOK = YES;
                //                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                //                [alert setTitleFontFamily:@"PingFangSC-Regular" withSize:20.0f];
                //                [alert setBodyTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
                //                [alert setButtonsTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
                //                [alert addButton:@"开始训练" actionBlock:^(void) {
                //                    DeBugLog(@"开始训练");
                //
                //                }];
                //
                //                alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [NSBundle mainBundle].resourcePath]];
                //
                //                [alert showSuccess:@"成功" subTitle:@"手套校验完成" closeButtonTitle:nil duration:0.0f];
        }else{
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setTitleFontFamily:@"PingFangSC-Regular" withSize:20.0f];
            [alert setBodyTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
            [alert setButtonsTextFontFamily:@"PingFangSC-Regular" withSize:16.0f];
            [alert addButton:@"重新校验" actionBlock:^(void) {
                DeBugLog(@"重新训练");
                [self.gloveBackView reLoadView];
                [self startValidate];
            }];

            alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [NSBundle mainBundle].resourcePath]];
            [alert showError:@"失败" subTitle:@"手套校验失败" closeButtonTitle:@"开始训练" duration:0];
        }

    });
    */
}

- (void)getBlueData
{
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

    self.pipeline.babyBluetooth.having(currPeripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();

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
                 self.dataView.minCheckOK = [NSString stringWithFormat:@"%ld",(long)minFingerData];
                 self.dataView.maxCheckOK = [NSString stringWithFormat:@"%ld",(long)maxFingerData];
                 @synchronized (self) {
                     self.pipeline.blueCurrentNum = cutr;
                 }
             }
         }];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"这个characteristic没有nofity的权限"];
        return;
    }

}

- (void)dealloc
{
    [self.pipeline.babyBluetooth cancelAllPeripheralsConnection];
}

@end
