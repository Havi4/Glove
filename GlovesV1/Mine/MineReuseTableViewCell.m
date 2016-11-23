//
//  MineReuseTableViewCell.m
//  ZZHTabStruct
//
//  Created by HaviLee on 2016/10/29.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import "MineReuseTableViewCell.h"

@implementation MineReuseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
    }
    return self;
}

- (void)setup
{
    
}

- (void)configureCellWith:(id)item andIndex:(NSIndexPath *)indexPath
{
    self.textLabel.font = kTitleNumberFont(kTitleNum);
    self.textLabel.text = [item objectForKey:@"title"];
    self.textLabel.textColor = kContentColor;
    NSString *imageName = [item objectForKey:@"icon"];
    self.imageView.image = [UIImage imageNamed:imageName];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self setTintColor:kContentColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
