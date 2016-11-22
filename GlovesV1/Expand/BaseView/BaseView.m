//
//  BaseView.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/15.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllSubView];
    }
    return self;
}

- (void)addAllSubView
{
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.frame];
    backImageView.image = [UIImage imageNamed:@"background_image"];
    [self addSubview:backImageView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
