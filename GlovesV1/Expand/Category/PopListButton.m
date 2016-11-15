//
//  PopListButton.m
//  GlovesV1
//
//  Created by HaviLee on 2016/11/15.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import "PopListButton.h"
#define kScreen [UIScreen mainScreen].bounds

@interface PopListButton ()

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation PopListButton

#pragma mark - 初始化

- (instancetype) initWithFrame:(CGRect)frame buttonType:(FlatButtonType)initType buttonStyle:(FlatButtonStyle)bStyle animateToInitialState:(BOOL)animateToInitialState{
    self = [super initWithFrame:frame buttonType:initType buttonStyle:bStyle animateToInitialState:animateToInitialState];
    if (self) {
        [self addTarget:self
                 action:@selector(buttonClick:)
       forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.frame = CGRectMake(kScreen.size.width - 100, kScreen.size.height-100, 50, 50);
        self.currentButtonType = buttonMenuType;
        self.currentButtonStyle = buttonRoundedStyle;

        self.roundBackgroundColor = [UIColor redColor];
        self.lineThickness = 3;
        self.lineRadius = 1;
        self.tintColor = [UIColor flatPeterRiverColor];
        [self addTarget:self
                 action:@selector(buttonClick:)
                         forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panActionWithGesture:)];
        
        [self addGestureRecognizer:pan];
    }
    return self;
}
#pragma mark - 创建内部button
- (void)setupButtons {
    for (int i = 0; i< (self.imageArray.count == 0 ? 4: self.imageArray.count); i++) {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        button.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 50, 50);
        button.hidden = YES;
        button.alpha = 0;
        if (self.imageArray.count == 0) {
            
            button.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        }else {
            [button setImage:self.imageArray[i] forState:UIControlStateNormal];
        }
        
        button.layer.cornerRadius = 25;
        button.layer.masksToBounds = YES;
        [self.superview addSubview:button];
        [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
    }
    [self.superview bringSubviewToFront:self];
}
#pragma mark - 暴露在外的初始化类方法
+ (instancetype)creatMenuButton {
    return [[self alloc]init];
}
#pragma mark - 圆形按钮已经显示到父视图调用的方法
- (void)didMoveToSuperview {
    [self setupButtons];
}

#pragma mark - 前置红色按钮点击事件
- (void)buttonClick:(UIButton *)sender {
    
    self.selected = !self.selected;
    if (sender.selected) {
        [self openButtonState];
        [self animateToType:buttonCloseType];
    }else {
        [self closeButonOpenState];
        [self animateToType:buttonMenuType];
    }
    
}
#pragma mark - 后置按钮的打开状态
- (void)openButtonState {
    CGFloat margin = 70;
    self.userInteractionEnabled = NO;
    for (int i = 0; i< self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.hidden = NO;
            button.alpha = 1;
            if (i == 0) {
                button.frame = CGRectMake(self.frame.origin.x-10, self.frame.origin.y - margin-10, 50, 50);
            }else {
                UIButton *prebutton = self.buttonArray[i-1];
                button.frame = CGRectMake(button.frame.origin.x-10, prebutton.frame.origin.y - margin, 50, 50);
            }
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
    }
}
#pragma mark - 后置按钮的关闭状态
- (void)closeButonOpenState {
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        for (UIButton *button in self.buttonArray) {
            
            button.frame = CGRectMake(self.frame.origin.x-10, self.frame.origin.y-10, 50, 50);
        }
        
    } completion:^(BOOL finished) {
        for (UIButton *button in self.buttonArray) {
            button.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-10, 50, 50);
            button.hidden = YES;
            button.alpha = 0;
        }
        self.userInteractionEnabled = YES;
    }];
}
#pragma mark - 后置按钮的点击事件
- (void)backButtonClick:(UIButton *)sender {
    if (self.clickBlock) {
        self.selected = NO;
        [self animateToType:buttonMenuType];
        self.clickBlock(sender.tag);
        [self closeButonOpenState];
    }
}
#pragma mark - lazyLoad用于缓存所有后置按钮
- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
