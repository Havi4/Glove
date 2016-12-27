//
//  DataFingerableViewCell.m
//  GlovesV1
//
//  Created by HaviLee on 2016/12/22.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "DataFingerableViewCell.h"

@interface DataFingerableViewCell ()

@end

@implementation DataFingerableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.fingerDataTitle = [[UILabel alloc]init];
        self.fingerDataTitle.text = @"大拇指";
        self.fingerDataTitle.textColor = [UIColor grayColor];
        [self addSubview:self.fingerDataTitle];
        [self.fingerDataTitle makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.width.equalTo(@60);
            make.centerY.equalTo(self.mas_centerY);
        }];

        self.minDataTitle = [[UILabel alloc]init];
        self.minDataTitle.textColor = [UIColor grayColor];
        self.minDataTitle.text = @"最小值:";
        [self addSubview:self.minDataTitle];
        [self.minDataTitle makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.fingerDataTitle.mas_right).offset(15);
            make.width.equalTo(@60);
            make.centerY.equalTo(self.mas_centerY);

        }];

        self.minDataLabel = [[UILabel alloc]init];
        self.minDataLabel.textColor = kBarHightlightedColor;
        self.minDataLabel.text = @"200";
        [self addSubview:self.minDataLabel];
        [self.minDataLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.minDataTitle.mas_right).offset(5);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@60);
        }];

        self.maxDataTitle = [[UILabel alloc]init];
        self.maxDataTitle.textColor = [UIColor grayColor];
        self.maxDataTitle.text = @"最大值:";
        [self addSubview:self.maxDataTitle];
        [self.maxDataTitle makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.minDataLabel.mas_right).offset(15);
            make.width.equalTo(@60);
            make.centerY.equalTo(self.mas_centerY);

        }];

        self.maxDataLabel = [[UILabel alloc]init];
        self.maxDataLabel.textColor = kBarHightlightedColor;
        self.maxDataLabel.text = @"200";
        [self addSubview:self.maxDataLabel];
        [self.maxDataLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.maxDataTitle.mas_right).offset(5);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@60);
        }];


    }
    return self;
}

@end
