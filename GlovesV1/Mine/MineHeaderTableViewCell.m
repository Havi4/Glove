//
//  MineHeaderTableViewCell.m
//  ZZHTabStruct
//
//  Created by HaviLee on 2016/10/29.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import "MineHeaderTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UserInfoDetailModel.h"

@interface MineHeaderTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) UILabel *mineNameLabel;
@property (nonatomic, strong) UILabel *mineCheckLabel;
@property (nonatomic, strong) UIImageView *mineBarcodeImageView;

@end

@implementation MineHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.iconImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"head_placeholder"];
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderColor = kContentColor.CGColor;
    self.iconImageView.layer.borderWidth = 2;
    
    //
    self.editImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.editImageView];
    self.editImageView.image = [UIImage imageNamed:@"editIcon"];
        //
    self.mineNameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.mineNameLabel];
    self.mineNameLabel.text = @"Havi_Lee";
    self.mineNameLabel.font = kTitleNumberFont(kTitleNum);
    self.mineNameLabel.textColor = kBarHightlightedColor;
    self.mineCheckLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.mineCheckLabel];
    self.mineCheckLabel.text = @"点击查看";
    self.mineCheckLabel.font = kTitleNumberFont(kSubTitleNum);
    self.mineCheckLabel.textColor = kContentColor;
    
    //
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self setTintColor:kContentColor];
    self.mineBarcodeImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.mineBarcodeImageView];
    self.mineBarcodeImageView.image = [UIImage imageNamed:@"barCode"];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView,15)
    .widthIs(60)
    .heightIs(60)
    .centerYEqualToView(self.contentView);
    
    self.mineNameLabel.sd_layout
    .leftSpaceToView(self.iconImageView,10)
    .topSpaceToView(self.contentView,15);
    
    self.mineCheckLabel.sd_layout
    .leftSpaceToView(self.iconImageView,10)
    .bottomSpaceToView(self.contentView,-20);
    
    self.editImageView.sd_layout
    .leftSpaceToView(self.iconImageView,-15)
    .topSpaceToView(self.iconImageView,-15)
    .widthIs(15)
    .heightIs(15);
    
    self.mineBarcodeImageView.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView,0)
    .widthIs(20)
    .heightIs(20);
    
}

- (void)configureCellWith:(id)item andIndex:(NSIndexPath *)indexPath
{
    UserInfoDetailModel *user = item;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:user.nUserInfo.portraitFileUrl ] placeholder:[UIImage imageNamed:@"head_placeholder"]];
    self.mineNameLabel.text = user.nUserInfo.userName.length == 0 ? @"匿名用户":user.nUserInfo.userName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
