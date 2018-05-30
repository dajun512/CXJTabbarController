//
//  UITabBarItem+Extension.m
//  CXJTabbarController
//
//  Created by pro on 2018/5/29.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//

#import "UITabBarItem+Extension.h"
#import <objc/runtime.h>
#import "CXJTabbarConst.h"
@implementation UITabBarItem (Extension)


-(void)setIndex:(NSInteger)index
{
    objc_setAssociatedObject(self, @selector(index), [NSNumber numberWithInteger:index], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)index
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setCustomBadgeValue:(NSString *)customBadgeValue
{
    objc_setAssociatedObject(self, @selector(customBadgeValue), customBadgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:CXJNotificationTypeBadgeValueChange object:self];
}

- (NSString *)customBadgeValue
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setBadgeValue:(NSString *)badgeValue
{
    self.customBadgeValue = badgeValue;
}

@end
