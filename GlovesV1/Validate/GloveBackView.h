//
//  GloveBackView.h
//  GlovesV1
//
//  Created by HaviLee on 2016/11/23.
//  Copyright © 2016年 HaviLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GloveBackView : UIView

- (void)startValidateGloveWithIndex:(int)index isOK:(BOOL)isOK;

- (void)reLoadView;

@end
