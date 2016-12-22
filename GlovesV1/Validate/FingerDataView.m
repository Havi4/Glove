//
//  FingerDataView.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/28.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "FingerDataView.h"

@interface FingerDataView ()

@property (nonatomic, strong) UILabel *minLabel;
@property (nonatomic, strong) UILabel *maxLabel;

@end

@implementation FingerDataView

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
    _minLabel = [[UILabel alloc]init];
    [self addSubview:_minLabel];
    [_minLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-60);
    }];

    _maxLabel = [[UILabel alloc]init];
    [self addSubview:_maxLabel];
    [_maxLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(60);
    }];
}

- (void)setMinCheckOK:(NSString *)minCheckOK
{
    _minLabel.text = minCheckOK;
    _minLabel.font = kTitleNumberFont(18);
    _minLabel.textColor = kBarNormalColor;
}

- (void)setMaxCheckOK:(NSString *)maxCheckOK
{
    _maxLabel.text = maxCheckOK;
    _maxLabel.font = kTitleNumberFont(18);
    _maxLabel.textColor = kBarNormalColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
