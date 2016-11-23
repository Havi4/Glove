//
//  FingerSubView.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/23.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "FingerSubView.h"

@interface FingerSubView ()

@property (nonatomic, strong) UILabel *stepTitleLabel;
@property (nonatomic, strong) UILabel *stepDetailLabel;

@end

@implementation FingerSubView

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
    self.stepTitleLabel = [[UILabel alloc]init];
    [self addSubview:self.stepTitleLabel];
    self.stepTitleLabel.textColor = kBarHightlightedColor;
    self.stepTitleLabel.font = kTitleNumberFont(kTitleNum);
    self.stepTitleLabel.text = @"第一步";
    [self.stepTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
    }];

    self.stepDetailLabel = [[UILabel alloc]init];
    [self addSubview:self.stepDetailLabel];
    self.stepDetailLabel.textColor = kBarNormalColor;
    self.stepDetailLabel.font = kTitleNumberFont(kSubTitleNum);
    self.stepDetailLabel.text = @"请握紧大拇指";
    [self.stepDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.stepTitleLabel.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(self.stepTitleLabel.mas_height);
    }];

}

- (void)setTitleString:(NSString *)titleString
{
    _stepTitleLabel.text = titleString;
}

- (void)setSubTitleString:(NSString *)subTitleString
{
    _stepDetailLabel.text = subTitleString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
