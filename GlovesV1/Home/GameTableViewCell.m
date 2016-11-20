//
//  GameTableViewCell.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/16.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "GameTableViewCell.h"


@interface GameTableViewCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UILabel *subTitleNameLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation GameTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    _backView = [[UIImageView alloc]init];
    _backView.userInteractionEnabled = YES;
    _backView.image = [UIImage imageNamed:@"background_image"];
    _backView.layer.shadowOffset = CGSizeMake(0, 0);
    _backView.layer.shadowColor = [UIColor blackColor].CGColor;
    _backView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    _backView.layer.shadowRadius = 5;
    _backView.bounds = self.bounds;
    [self.contentView addSubview:_backView];
    [_backView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    _webImageView = [YYAnimatedImageView new];
    _webImageView.size = CGSizeMake(kScreenWidth-20, kCellHeight*0.6);
    _webImageView.clipsToBounds = YES;
    _webImageView.contentMode = UIViewContentModeScaleAspectFill;
    _webImageView.backgroundColor = [UIColor lightGrayColor];
    [_backView addSubview:_webImageView];
    [_webImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.top.equalTo(_backView.mas_top).offset(10);
        make.width.equalTo(@(kScreenWidth-20));
        make.height.equalTo(@(kCellHeight*0.6));
    }];
    
    _titleNameLabel = [[UILabel alloc]init];
    _titleNameLabel.font = kTitleNumberFont(kSubTitleNum);
    _titleNameLabel.textColor = kBarHightlightedColor;
    _titleNameLabel.text = @"";
    [_backView addSubview:_titleNameLabel];
    
    [_titleNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(10);
        make.top.equalTo(_webImageView.mas_bottom).offset(15);
    }];
    
    _subTitleNameLabel = [[UILabel alloc]init];
    _subTitleNameLabel.font = kTitleNumberFont(kContentNum);
    _subTitleNameLabel.textColor = kBarNormalColor;
    _subTitleNameLabel.text = @"";
    [_backView addSubview:_subTitleNameLabel];
    
    _detailLabel = [[UILabel alloc]init];
    _detailLabel.font = kTitleNumberFont(kContentNum);
    _detailLabel.textColor = kContentColor;
    _detailLabel.numberOfLines = 0;
    _detailLabel.text = @"";
    [_backView addSubview:_detailLabel];
    
    [_detailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subTitleNameLabel.mas_bottom).offset(10);
        make.left.equalTo(_backView.mas_left).offset(10);
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.bottom.equalTo(_backView.mas_bottom).offset(-10);
    }];
    
    
    [_subTitleNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.centerY.equalTo(_titleNameLabel.mas_centerY);
    }];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.center = CGPointMake(self.width / 2, self.height / 2);
    _indicator.hidden = YES;
    //[self.contentView addSubview:_indicator]; //use progress bar instead..
    
    _label = [UILabel new];
    _label.size = self.size;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"Load fail, tap to reload.";
    _label.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _label.hidden = YES;
    _label.userInteractionEnabled = YES;
    [self.contentView addSubview:_label];
    
    CGFloat lineHeight = 4;
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.size = CGSizeMake(_webImageView.width, lineHeight);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, _progressLayer.height / 2)];
    [path addLineToPoint:CGPointMake(_webImageView.width, _progressLayer.height / 2)];
    _progressLayer.lineWidth = lineHeight;
    _progressLayer.path = path.CGPath;
    _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    [_webImageView.layer addSublayer:_progressLayer];
    return self;
}

- (void)setImageURL:(NSURL *)url {
    _label.hidden = YES;
    _indicator.hidden = NO;
    [_indicator startAnimating];
    __weak typeof(self) _self = self;
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.progressLayer.hidden = YES;
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];
    
    [_webImageView setImageWithURL:url
                       placeholder:[UIImage imageNamed:@"home_placeholder_image"]
                           options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                              if (expectedSize > 0 && receivedSize > 0) {
                                  CGFloat progress = (CGFloat)receivedSize / expectedSize;
                                  progress = progress < 0 ? 0 : progress > 1 ? 1 : progress;
                                  if (_self.progressLayer.hidden) _self.progressLayer.hidden = NO;
                                  _self.progressLayer.strokeEnd = progress;
                              }
                          } transform:nil
                        completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                            if (stage == YYWebImageStageFinished) {
                                _self.progressLayer.hidden = YES;
                                [_self.indicator stopAnimating];
                                _self.indicator.hidden = YES;
//                                if (!image) _self.label.hidden = NO;
                            }
                        }];
}

- (void)configCell:(id)info
{
    NSDictionary *gameSetting = info;
    _titleNameLabel.text = [gameSetting objectForKey:@"gameName"];
    _subTitleNameLabel.text = [gameSetting objectForKey:@"gameLevel"];
    _detailLabel.text = [gameSetting objectForKey:@"gameDetail"];
}

@end
