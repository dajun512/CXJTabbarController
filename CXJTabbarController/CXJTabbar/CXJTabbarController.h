//
//  CXJTabbarController.h
//  CXJTabbarController
//
//  Created by pro on 2018/5/29.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CXJTabbarController : UITabBarController

/** 获取中间加号按钮 default is nil */
@property (nonatomic,weak,readonly) UIButton *plusButton;

/** 设置中间加号按钮  */
-(void)setPlusButton:(nonnull UIButton *)plusButton;


/** 设置badge背景颜色 */
@property (nonatomic,weak,nullable) UIColor *badgeBackgroundColor;

/** 设置badge字体颜色 */
@property (nonatomic,weak,nullable) UIColor *badgeTitleColor;


@end
