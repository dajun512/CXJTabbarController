//
//  UITabBarItem+Extension.h
//  CXJTabbarController
//
//  Created by pro on 2018/5/29.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (Extension)

/** 设置tag */
@property (nonatomic,assign) NSInteger index;

/** 设置badgeValue */
@property (nonatomic,strong) NSString *customBadgeValue;

@end
