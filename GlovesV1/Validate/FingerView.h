//
//  FingerView.h
//  GlovesV1
//
//  Created by HaviLee on 2016/11/23.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FingerView : UIView

@property (nonatomic, assign) float lineWidth;

@property (nonatomic, assign) double percentage;

@property (nonatomic, assign) double offsetNum;

@property (nonatomic, assign) CGSize corneroffset;

@property (nonatomic, strong) UIColor *gaugeColor;

@end
