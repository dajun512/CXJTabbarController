//
//  UITabBar+Extension.h
//  CXJTabbarController
//
//  Created by pro on 2018/5/29.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Extension)

/** 中间按钮 */
@property (nonatomic,strong) UIButton *plusBtn;

/** badge背景色 */
@property (nonatomic,strong) UIColor *badgeBackgroundColor;

/** badge字体颜色 */
@property (nonatomic,strong) UIColor *badgeTitleColor;

@end
