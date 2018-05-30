//
//  UITabBar+Extension.m
//  CXJTabbarController
//
//  Created by pro on 2018/5/29.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//

#import "UITabBar+Extension.h"
#import <objc/runtime.h>
#import "CXJTabbarConst.h"
@implementation UITabBar (Extension)

-(void)setPlusBtn:(UIButton *)plusBtn
{
    if (![plusBtn isKindOfClass:[UIButton class]]) return;
    
    objc_setAssociatedObject(self, @selector(plusBtn), plusBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[NSNotificationCenter defaultCenter] postNotificationName:CXJNotificationTypeSetPlusButton object:plusBtn];
}

-(UIButton *)plusBtn
{
    return objc_getAssociatedObject(self, _cmd);
}


-(void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor
{
    objc_setAssociatedObject(self, @selector(badgeBackgroundColor), badgeBackgroundColor,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)badgeBackgroundColor
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setBadgeTitleColor:(UIColor *)badgeTitleColor
{
    objc_setAssociatedObject(self, @selector(badgeTitleColor), badgeTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)badgeTitleColor
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
