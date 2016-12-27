//
//  TagView.h
//  biaoqian
//
//  Created by 陈亚勃 on 16/1/8.
//  Copyright © 2016年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView
/**
 *  tag的高度
 */
@property(nonatomic, assign) CGFloat tagViewButtonHeight;
/**
 *  tag的字号
 */
@property(nonatomic, assign) NSInteger tagViewButtonFont;
/**
 *  已经选择的tag的名字
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *haveSelected;
/**
 *  还未选中的tag的名字
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *notSelected;

- (NSArray *)selectedItem;

@end
