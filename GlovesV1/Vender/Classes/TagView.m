//
//  TagView.m
//  biaoqian
//
//  Created by 陈亚勃 on 16/1/8.
//  Copyright © 2016年 cyb. All rights reserved.
//

#import "TagView.h"

typedef NS_ENUM(BOOL,TagButtontype){
    Selected,
    NotSelected,
};

@interface TagButton : UIButton

@property (nonatomic, assign) TagButtontype tagButtonType;

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font tagButtonType:(TagButtontype)tagButtonType frame:(CGRect)frame;

@end

@implementation TagButton

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font tagButtonType:(TagButtontype)tagButtonType frame:(CGRect)frame{
    if (self = [super init]) {
        self.layer.cornerRadius = 5;
        
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = font;
        self.tagButtonType = tagButtonType;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        frame.size.width = [self getLabelWidthWithText:title stringFont:font allowHeight:30] + 40;
        self.frame = frame;
        
    }
    return self;
}

- (void)setTagButtonFrame:(CGRect)tagButtonFrame{
}

- (void)setTagButtonType:(TagButtontype)tagButtonType{
    _tagButtonType = tagButtonType;
    /**
     *  设置两种type的样式
     */
    if (tagButtonType == Selected) {
        self.backgroundColor = kBarHightlightedColor;
    }else if(tagButtonType == NotSelected){
        self.backgroundColor = [UIColor grayColor];
    }
}

/**
 *  根据label的内容自动算高度
 *
 *  @param text label的内容
 *
 *  @return label的高度
 */
- (CGFloat)getLabelWidthWithText:(NSString *)text stringFont:(UIFont *)font allowHeight:(CGFloat)height{
    CGFloat width;
    CGRect rect = [text boundingRectWithSize:CGSizeMake(2000, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    width = rect.size.width;
    return width;
}
@end

#define TagButtonSpaceX 10
#define TagButtonSpaceY 10
#define LeftToView      10
#define RightToView     10
#define TopToView       10
#define TagButtonSpaceBetweenSeletedAndNotSeleted 50

#define SelectedButtonTag    1000
#define NotSelectedButtonTag 2000


@interface TagView()

@end

@implementation TagView

@synthesize haveSelected = _haveSelected;

- (void)setHaveSelected:(NSMutableArray<NSString *> *)haveSelected{
    _haveSelected = haveSelected;
}

- (NSMutableArray *)haveSelected{
    if (_haveSelected == nil) {
        _haveSelected = [NSMutableArray array];
    }
    return _haveSelected;
}

- (NSArray *)selectedItem
{
    if (self.haveSelected) {
        return _haveSelected;
    }else{
        return nil;
    }
}

- (NSMutableArray *)notSelected{
    if (_notSelected == nil) {
        _notSelected = [NSMutableArray array];
    }
    return _notSelected;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (CGFloat)tagViewButtonHeight{
    return _tagViewButtonHeight ? _tagViewButtonHeight:30;
}

- (NSInteger)tagViewButtonFont{
    return _tagViewButtonFont ? _tagViewButtonFont:13;
}



- (void)drawRect:(CGRect)rect{
    for (UIButton *button in self.subviews) {
        [button removeFromSuperview];
    }
    NSInteger beginX = LeftToView;
    NSInteger beginY = TopToView;
    for (int i = 0; i< self.haveSelected.count; i++) {  //已经选择的标签
        TagButton *button = [[TagButton alloc] initWithTitle:self.haveSelected[i] font:[UIFont systemFontOfSize:self.tagViewButtonFont] tagButtonType:Selected frame:CGRectMake(beginX, beginY, 0, self.tagViewButtonHeight)];
        [button addTarget:self action:@selector(selectedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = SelectedButtonTag+i;
        
        if (CGRectGetMaxX(button.frame) + TagButtonSpaceX > (rect.size.width - RightToView)) {
            beginX = LeftToView;
            beginY += CGRectGetHeight(button.frame)+TagButtonSpaceY;
            CGRect rect = button.frame;
            rect.origin.x = beginX;
            rect.origin.y = beginY;
            button.frame = rect;
        }
        beginX = TagButtonSpaceX + CGRectGetMaxX(button.frame);
        [self addSubview:button];
        
    }
    
    beginX = LeftToView;
    beginY += self.tagViewButtonHeight + TagButtonSpaceBetweenSeletedAndNotSeleted;
    for (int i = 0; i< self.notSelected.count; i++) {  //没有选择的标签
        TagButton *button = [[TagButton alloc] initWithTitle:self.notSelected[i] font:[UIFont systemFontOfSize:self.tagViewButtonFont] tagButtonType:NotSelected frame:CGRectMake(beginX, beginY, 0, self.tagViewButtonHeight)];
        button.tag = NotSelectedButtonTag + i;
        [button addTarget:self action:@selector(notSelectedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (CGRectGetMaxX(button.frame) + TagButtonSpaceX > (rect.size.width - RightToView)) {
            beginX = LeftToView;
            beginY += CGRectGetHeight(button.frame)+TagButtonSpaceY;
            CGRect rect = button.frame;
            rect.origin.x = beginX;
            rect.origin.y = beginY;
            button.frame = rect;
        }
        beginX = TagButtonSpaceX + CGRectGetMaxX(button.frame);
        [self addSubview:button];
    }
}

- (void)selectedButtonClicked:(UIButton *)button{
    NSInteger index = button.tag - SelectedButtonTag;
    [self.notSelected addObject:self.haveSelected[index]];
    [self.haveSelected removeObjectAtIndex:index];
    
    [self setNeedsDisplay];
}

- (void)notSelectedButtonClicked:(UIButton *)button{
    NSInteger index = button.tag - NotSelectedButtonTag;
    [self.haveSelected insertObject:self.notSelected[index] atIndex:self.haveSelected.count];
    //    [self.haveSelected addObject:self.notSelected[index]];
    [self.notSelected removeObjectAtIndex:index];
    
    [self setNeedsDisplay];
    
}




@end
