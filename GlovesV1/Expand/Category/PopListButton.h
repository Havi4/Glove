//
//  PopListButton.h
//  GlovesV1
//
//  Created by HaviLee on 2016/11/15.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import <VBFPopFlatButton/VBFPopFlatButton.h>

@interface PopListButton : VBFPopFlatButton

@property (nonatomic, copy) void (^clickBlock)(NSInteger integer);
@property (nonatomic, strong) NSArray<UIImage *> *imageArray;

+ (instancetype)creatMenuButton;
- (instancetype) initWithFrame:(CGRect)frame buttonType:(FlatButtonType)initType buttonStyle:(FlatButtonStyle)bStyle animateToInitialState:(BOOL)animateToInitialState;

@end
