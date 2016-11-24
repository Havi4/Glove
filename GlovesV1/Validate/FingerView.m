//
//  FingerView.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/23.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "FingerView.h"

@interface FingerView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayerCircle;
@property (nonatomic, strong) CALayer *bgLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSMutableArray *colors1;


@end

@implementation FingerView


- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor clearColor];
    [self.layer addSublayer:self.gradientLayerCircle];
    [self.layer addSublayer:self.bgLayer];
//
    [self.bgLayer addSublayer:self.gradientLayer];

    _progressLayer = [CAShapeLayer layer];
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
    _progressLayer.lineCap = kCALineCapSquare;
    _progressLayer.lineWidth = self.lineWidth;
    UIRectCorner corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        //create path
    CGSize radii = self.corneroffset;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectZero byRoundingCorners:corners cornerRadii:radii];
        // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    [path moveToPoint:CGPointMake(self.width/2-self.offsetNum , 10)];
    [path addLineToPoint:CGPointMake(self.width/2, self.bounds.size.height)];
        // 将path绘制出来
    _progressLayer.path = path.CGPath;
    _progressLayer.strokeStart = 0.0f;
    _progressLayer.strokeEnd = 0.0f;
    _progressLayer.lineJoin = kCALineJoinRound;
    _progressLayer.lineCap = kCALineCapRound;
    [self.bgLayer setMask:_progressLayer];

}

- (CAGradientLayer *)gradientLayerCircle{
    if (!_gradientLayerCircle) {
        CAShapeLayer *arc = [CAShapeLayer layer];
        UIRectCorner corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            //create path
        CGSize radii = self.corneroffset;;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectZero byRoundingCorners:corners cornerRadii:radii];
            // 添加路径[1条点(100,100)到点(200,100)的线段]到path
        [path moveToPoint:CGPointMake(self.width/2-self.offsetNum , 10)];
        [path addLineToPoint:CGPointMake(self.width/2, self.bounds.size.height)];
            // 将path绘制出来
        arc.path = path.CGPath;
        arc.fillColor = [UIColor clearColor].CGColor;
        arc.strokeColor = [UIColor whiteColor].CGColor;
        arc.lineWidth = self.lineWidth;

        _gradientLayerCircle = [CAGradientLayer layer];
        _gradientLayerCircle.frame = self.bounds;
        _gradientLayerCircle.colors = self.colors;
        _gradientLayerCircle.masksToBounds = YES;
        _gradientLayerCircle.startPoint = CGPointMake(0,0.5);
        _gradientLayerCircle.endPoint = CGPointMake(1,0.5);
        _gradientLayerCircle.mask = arc;
    }
    return _gradientLayerCircle;
}

- (CALayer*)bgLayer
{
    if (!_bgLayer) {
        _bgLayer = [CALayer layer];
    }
    return _bgLayer;
}

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        CAShapeLayer *arc = [CAShapeLayer layer];
        UIRectCorner corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            //create path
        CGSize radii = self.corneroffset;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectZero byRoundingCorners:corners cornerRadii:radii];
            // 添加路径[1条点(100,100)到点(200,100)的线段]到path
        [path moveToPoint:CGPointMake(self.width/2-self.offsetNum , 10)];
        [path addLineToPoint:CGPointMake(self.width/2, self.bounds.size.height)];
            // 将path绘制出来
        arc.path = path.CGPath;
        arc.fillColor = [UIColor clearColor].CGColor;
        arc.strokeColor = [UIColor whiteColor].CGColor;
        arc.lineWidth = self.lineWidth;
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = self.colors1;
        _gradientLayer.masksToBounds = YES;
        _gradientLayer.startPoint = CGPointMake(0,0.5);
        _gradientLayer.endPoint = CGPointMake(1,0.5);
        _gradientLayer.mask = arc;
    }
    return _gradientLayer;
}


- (NSMutableArray *)colors{
    if (!_colors){
        _colors = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIColor *hexColor = [UIColor clearColor];
            [_colors addObject:(__bridge id)hexColor.CGColor];
        }
    }
    return _colors;
}

- (NSMutableArray *)colors1{
    if (!_colors1){
        _colors1 = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIColor *hexColor = self.gaugeColor?self.gaugeColor:[UIColor clearColor];
            [_colors1 addObject:(__bridge id)hexColor.CGColor];
        }
    }
    return _colors1;
}

- (void)setGaugeColor:(UIColor *)gaugeColor
{
    _gaugeColor = gaugeColor;
    _colors1 = nil;
    _gradientLayer = nil;
    [self.bgLayer addSublayer:self.gradientLayer];
}

-(void)setPercentage:(double)percentage{
    [_progressLayer removeAllAnimations];
    _progressLayer.strokeEnd = percentage;
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 0.5;
    drawAnimation.removedOnCompletion = YES;
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    drawAnimation.toValue = [NSNumber numberWithFloat:(percentage)];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_progressLayer addAnimation:drawAnimation forKey:@"drawCircleAnimation"];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
