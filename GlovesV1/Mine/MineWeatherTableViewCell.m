//
//  MineWeatherTableViewCell.m
//  ZZHTabStruct
//
//  Created by HaviLee on 2016/10/29.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import "MineWeatherTableViewCell.h"

@interface MineWeatherTableViewCell ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *weatherTitle;
@property (nonatomic, strong) UILabel *weatherSubTitle;
@property (nonatomic, strong) UIImageView *weatherImage;
@property (nonatomic, strong) UILabel *sleepTitle;
@property (nonatomic, strong) UILabel *sleepSubTitle;
@property (nonatomic, strong) UIImageView *sleepImage;

@end

@implementation MineWeatherTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup
{
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = kBarNormalColor;
    [self.contentView addSubview:self.line];
    
    self.weatherTitle = [[UILabel alloc]init];
    self.weatherTitle.text = @"上海";
    self.weatherTitle.textColor = kContentColor;
    self.weatherTitle.font = kTitleNumberFont(kTitleNum);
    [self.contentView addSubview:self.weatherTitle];
    
    self.weatherSubTitle = [[UILabel alloc]init];
    self.weatherSubTitle.text = @"20℃-25℃";
    self.weatherSubTitle.textColor = kContentColor;
    self.weatherSubTitle.font = kTitleNumberFont(kSubTitleNum);
    [self.contentView addSubview:self.weatherSubTitle];
    
    self.weatherImage = [[UIImageView alloc]init];
    self.weatherImage.image = [UIImage imageNamed:@"weather"];
    [self.contentView addSubview:self.weatherImage];
    
    self.sleepTitle = [[UILabel alloc]init];
    self.sleepTitle.text = @"今日睡眠";
    self.sleepTitle.textColor = kContentColor;
    self.sleepTitle.font = kTitleNumberFont(kSubTitleNum);
    [self.contentView addSubview:self.sleepTitle];
    
    self.sleepSubTitle = [[UILabel alloc]init];
    self.sleepSubTitle.text = @"1h8m";
    self.sleepSubTitle.textColor = kContentColor;
    self.sleepSubTitle.font = kTitleNumberFont(kSubTitleNum);
    [self.contentView addSubview:self.sleepSubTitle];
    
    self.sleepImage = [[UIImageView alloc]init];
    self.sleepImage.image = [UIImage imageNamed:@"goodSleep"];
    [self.contentView addSubview:self.sleepImage];
    
    self.line.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView,5)
    .bottomSpaceToView(self.contentView,5)
    .widthIs(1);
    
    self.weatherTitle.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topEqualToView(self.contentView)
    .heightIs(22)
    .widthIs(80);
    
    self.weatherSubTitle.sd_layout
    .leftSpaceToView(self.contentView,15)
    .bottomEqualToView(self.contentView)
    .heightIs(22)
    .widthIs(80);
    
    self.weatherImage.sd_layout
    .leftSpaceToView(self.weatherSubTitle,10)
    .centerYEqualToView(self.contentView)
    .heightIs(29)
    .widthIs(29);
    
    self.sleepTitle.sd_layout
    .leftSpaceToView(self.line,15)
    .topEqualToView(self.contentView)
    .heightIs(22);
    
    self.sleepSubTitle.sd_layout
    .leftSpaceToView(self.line,15)
    .bottomEqualToView(self.contentView)
    .heightIs(22)
    .widthIs(60);
    
    self.sleepImage.sd_layout
    .leftSpaceToView(self.sleepSubTitle,10)
    .centerYEqualToView(self.contentView)
    .heightIs(29)
    .widthIs(29);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
