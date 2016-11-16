//
//  GameTableViewCell.h
//  GlovesV1
//
//  Created by HaviLee on 2016/11/16.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellHeight ceil((kScreenWidth) * 3.0 / 4.0)

@interface GameTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) YYAnimatedImageView *webImageView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UILabel *label;

- (void)setImageURL:(NSURL *)url;

- (void)configCell:(id)info;

@end
