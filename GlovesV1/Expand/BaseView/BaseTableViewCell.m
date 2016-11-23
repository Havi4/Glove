//
//  BaseTableViewCell.m
//  ZZHTabStruct
//
//  Created by HaviLee on 2016/10/29.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSuperViews];
        UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
        backView.backgroundColor = [UIColor lightGrayColor];
        backView.alpha = 0.7;
        self.selectedBackgroundView = backView;
    }
    return self;
}

- (void)setSuperViews
{
//    UILabel *upLine = [[UILabel alloc]init];
//    upLine
    UIImageView *back = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_back"]];
    back.frame = self.bounds;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_back"]];
//    [self addSubview:back];
}

- (void)configureCellWith:(id)item andIndex:(NSIndexPath *)indexPath
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
