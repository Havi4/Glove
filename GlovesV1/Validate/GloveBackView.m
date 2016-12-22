//
//  GloveBackView.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/23.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "GloveBackView.h"
#import "FingerView.h"

@interface GloveBackView ()

@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) FingerView *firstFinger;
@property (nonatomic, strong) FingerView *twoFinger;
@property (nonatomic, strong) FingerView *threeFinger;
@property (nonatomic, strong) FingerView *fourFinger;
@property (nonatomic, strong) FingerView *fiveFinger;

@property (nonatomic, strong) UIColor *successColor;
@property (nonatomic, strong) UIColor *errorColor;

@end

@implementation GloveBackView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackShaw];
        [self setup];
    }
    return self;
}

- (void)setBackShaw{
    CGRect rect;
    rect = CGRectMake(0, 0, 48, 48);
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    avatarImageView.image = [UIImage imageNamed:@"background_image"];

        //Round the corners
    CALayer * layer = [avatarImageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:9.0];

        //Add a shadow by wrapping the avatar into a container
    UIView * shadow = [[UIView alloc] initWithFrame: self.bounds];
    avatarImageView.frame = CGRectMake(0,0,self.bounds.size.width, self.bounds.size.height);

        // setup shadow layer and corner
    shadow.layer.shadowColor = [UIColor grayColor].CGColor;
    shadow.layer.shadowOffset = CGSizeMake(0, 1);
    shadow.layer.shadowOpacity = 1;
    shadow.layer.shadowRadius = 9.0;
    shadow.layer.cornerRadius = 9.0;
    shadow.clipsToBounds = NO;

        // combine the views
    [shadow addSubview: avatarImageView];

    [self addSubview:shadow];
}

- (void)setup{
    self.backImage = [[UIImageView alloc]init];
    self.backImage.image = [UIImage imageNamed:@"gloves_back"];
    self.backImage.frame = (CGRect){0,0,250,256};
    self.backImage.center = self.center;
    [self addSubview:self.backImage];

    _firstFinger = [[FingerView alloc]initWithFrame:(CGRect){-36,50,100,100}];
    _firstFinger.backgroundColor = [UIColor clearColor];
    _firstFinger.lineWidth = 28.5;
    _firstFinger.offsetNum = 35;
    _firstFinger.corneroffset = CGSizeMake(15, 15);
    _firstFinger.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    [self.backImage addSubview:_firstFinger];

    _twoFinger = [[FingerView alloc]initWithFrame:(CGRect){21,19,80,120}];
    _twoFinger.backgroundColor = [UIColor clearColor];
    _twoFinger.lineWidth = 30;
    _twoFinger.offsetNum = 18;
    _twoFinger.corneroffset = CGSizeMake(15, 15);
    _twoFinger.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    [self.backImage addSubview:_twoFinger];

    _threeFinger = [[FingerView alloc]initWithFrame:(CGRect){78,0,80,138}];
    _threeFinger.backgroundColor = [UIColor clearColor];
    _threeFinger.lineWidth = 33;
    _threeFinger.offsetNum = -4;
    _threeFinger.corneroffset = CGSizeMake(15, 15);
    _threeFinger.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    [self.backImage addSubview:_threeFinger];

    _fourFinger = [[FingerView alloc]initWithFrame:(CGRect){134,14,88,127}];
    _fourFinger.backgroundColor = [UIColor clearColor];
    _fourFinger.lineWidth = 33;
    _fourFinger.offsetNum = -28;
    _fourFinger.corneroffset = CGSizeMake(15, 15);
    _fourFinger.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    [self.backImage addSubview:_fourFinger];

    _fiveFinger = [[FingerView alloc]initWithFrame:(CGRect){170,99,260,80}];
    _fiveFinger.backgroundColor = [UIColor clearColor];
    _fiveFinger.lineWidth = 33;
    _fiveFinger.offsetNum = -112;
    _fiveFinger.corneroffset = CGSizeMake(20, 10);
    _fiveFinger.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    [self.backImage addSubview:_fiveFinger];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_firstFinger setPercentage:0.78];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_twoFinger setPercentage:0.8];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_threeFinger setPercentage:0.8];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_fourFinger setPercentage:0.8];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_fiveFinger setPercentage:0.35];
//    });

}

- (void)startValidateGloveWithIndex:(int)index isOK:(BOOL)isOK
{
    if (index == 1) {//代表大拇指
        _fiveFinger.gaugeColor = isOK ? self.successColor:self.errorColor;
        [_fiveFinger setPercentage:0.35];
    }else if (index == 2) {//代表食指
        _fourFinger.gaugeColor = isOK ? self.successColor:self.errorColor;
        [_fourFinger setPercentage:0.8];
    }else if (index == 3) {//代表中指
        _threeFinger.gaugeColor = isOK ? self.successColor:self.errorColor;
        [_threeFinger setPercentage:0.8];
    }else if (index == 4) {//代表无名指
        _twoFinger.gaugeColor = isOK ? self.successColor:self.errorColor;
        [_twoFinger setPercentage:0.8];
    }else if (index == 5) {//代表小拇指
        _firstFinger.gaugeColor = isOK ? self.successColor:self.errorColor;
        [_firstFinger setPercentage:0.78];
    }
}

- (UIColor *)successColor
{
    return [UIColor colorWithRed:0.180 green:0.710 blue:0.463 alpha:1.00];
}

- (UIColor *)errorColor
{
    return [UIColor colorWithRed:0.753 green:0.161 blue:0.196 alpha:1.00];
}

- (void)reLoadView
{
    [_fiveFinger setPercentage:0];
    [_fourFinger setPercentage:0];
    [_threeFinger setPercentage:0];
    [_twoFinger setPercentage:0];
    [_firstFinger setPercentage:0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
