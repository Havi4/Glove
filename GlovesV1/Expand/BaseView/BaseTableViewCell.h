//
//  BaseTableViewCell.h
//  ZZHTabStruct
//
//  Created by HaviLee on 2016/10/29.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TableViewCellConfigureBlock)(NSIndexPath *indexPath, id item);

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

- (void)configureCellWith:(id)item andIndex:(NSIndexPath *)indexPath;

@end
