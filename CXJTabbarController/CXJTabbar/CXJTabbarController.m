//
//  CXJTabbarController.m
//  CXJTabbarController
//
//  Created by pro on 2018/5/29.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//

#import "CXJTabbarController.h"
#import "CXJTabbar.h"
#import "UITabBar+Extension.h"
@interface CXJTabbarController()



@end

@implementation CXJTabbarController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //*********替换为自定义tabbar
    if ([self.tabBar isKindOfClass:[CXJTabbar class]]) return;
    CXJTabbar *tabbar = ({
        CXJTabbar *tabbar = [[CXJTabbar alloc] init];
        tabbar.items = self.tabBar.items;
        tabbar.plusBtn = self.tabBar.plusBtn;
        tabbar.badgeTitleColor = self.tabBar.badgeTitleColor;
        tabbar.badgeBackgroundColor = self.tabBar.badgeBackgroundColor;
        tabbar.selectedItem = self.tabBar.items[self.selectedIndex];
        tabbar;
    });
    [self setValue:tabbar forKey:@"tabBar"];
}





#pragma mark - 设置获取badge颜色
/**
 设置badge标题颜色
 */
-(void)setBadgeTitleColor:(UIColor *)badgeTitleColor
{
    self.tabBar.badgeTitleColor = badgeTitleColor;
}
/**
 获取badge标题颜色
 */
-(UIColor *)badgeTitleColor
{
    return self.tabBar.badgeTitleColor;
}

/**
 设置badge背景色
 */
-(void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor
{
    self.tabBar.badgeBackgroundColor = badgeBackgroundColor;
}

/**
 获取badge背景色
 */
-(UIColor *)badgeBackgroundColor
{
    return self.tabBar.badgeBackgroundColor;
}


#pragma mark - 设置center按钮

/**
 获取plusButton
 */
-(UIButton *)plusButton
{
    return self.tabBar.plusBtn;
}


/**
 设置plusButton
 */
- (void)setPlusButton:(UIButton *)plusButton
{
    if ([plusButton isKindOfClass:[UIButton class]]) {
        self.tabBar.plusBtn = plusButton;
    }
}

@end
