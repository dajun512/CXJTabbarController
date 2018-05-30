//
//  CXJTabbar.m
//  CXJTabbarController
//
//  Created by pro on 2018/5/29.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//

#import "CXJTabbar.h"
#import "UITabBar+Extension.h"
#import "UITabBarItem+Extension.h"
#import "CXJTabbarConst.h"

//绑定的起始tag
static NSInteger const startIndex = 1000;
//plus的tag
static NSInteger const plusIndex = 9999;

@interface CXJTabbar()

/** tabbarItems */
@property (nonatomic,strong) NSMutableDictionary *badgeValuesDict;

@end

@implementation CXJTabbar
#pragma mark - lazy
-(NSMutableDictionary *)badgeValuesDict
{
    if (!_badgeValuesDict) {
        _badgeValuesDict = [NSMutableDictionary dictionary];
    }
    return _badgeValuesDict;
}

/**
 初始化
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //*********监听通知
        ({
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBadgeValueChanged:) name:CXJNotificationTypeBadgeValueChange object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSetPlusButton:) name:CXJNotificationTypeSetPlusButton object:nil];
        });
        //*********设置默认badge颜色
        ({
            if (!self.badgeBackgroundColor) {
                self.badgeBackgroundColor  = [UIColor redColor];
            }
            if (!self.badgeTitleColor) {
                self.badgeTitleColor = [UIColor whiteColor];
            }
        });
    }
    return self;
}


/**
 设置items时调用(添加tag并添加到字典数组)
 */
-(void)setItems:(NSArray<UITabBarItem *> *)items
{
    [super setItems:items];
    //*********清除原有字典数据
    ({
        if (self.badgeValuesDict.count) [self.badgeValuesDict removeAllObjects];
    });
    
    //*********绑定标记到每个item,并且添加到可变字典
    ({
        NSInteger indexTag = startIndex;
        
        for (UITabBarItem *item in items) {
            item.index = indexTag;
            
            [self.badgeValuesDict setValue:item forKey:[NSString stringWithFormat:@"%ld",indexTag]];
            
            indexTag++;
        }
    });
    
}


/**
 布局调用
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    //起始标记
    NSInteger idx = 0;
    //tabbarButton位置变量
    CGFloat tabbarButtonX = 0.0f;
    CGFloat tabbarButtonY = 0.0f;
    NSInteger tabbarButtonCount = self.items.count % 2 == 0 ? self.items.count : self.items.count + 1;
    tabbarButtonCount = tabbarButtonCount > 4 ? 4 : tabbarButtonCount;
    CGFloat tabbarButtonW = self.bounds.size.width / (tabbarButtonCount+1);
    CGFloat tabbarButtonH = self.bounds.size.height;
    //badgeLabel变量
    NSString *badgeText;
    NSInteger badgeTextLength = 0;
    CGFloat badgeLabelW = 0;
    CGFloat badgeLabelRedius = 9.0f;
    CGFloat badgeLabelH = 18.0;
    
    
    
    for (UIButton *tabbarButton in self.subviews) {
        if (![tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        //*********设置tabbarItem的位置
        ({
            tabbarButtonX = idx >= (tabbarButtonCount * 0.5) ? (idx+1) * tabbarButtonW : idx * tabbarButtonW;
            tabbarButton.frame = CGRectMake(tabbarButtonX, tabbarButtonY, tabbarButtonW, tabbarButtonH);
            
        });
        
        NSInteger indexTag = startIndex+idx;
        idx++;
        
        //*********设置badgeLabel
        ({
            
            UILabel *oldLabel = [tabbarButton viewWithTag:indexTag];
            if (oldLabel) oldLabel.hidden = YES;

            NSString *key = [NSString stringWithFormat:@"%ld",indexTag];
            UITabBarItem *tabbarItem = [self.badgeValuesDict valueForKey:key];
            if (tabbarItem == nil) continue;
            if (tabbarItem.customBadgeValue == nil) continue;
            if ([tabbarItem.customBadgeValue isEqualToString:@"0"]) continue;
            
 
            if (!oldLabel) {
                UILabel *label = [[UILabel alloc] init];
                label.tag = indexTag;
                label.font = [UIFont systemFontOfSize:13.0];
                label.backgroundColor  = self.badgeBackgroundColor;
                label.textColor = self.badgeTitleColor;
                label.textAlignment = NSTextAlignmentCenter;
                label.layer.masksToBounds = YES;
                [tabbarButton addSubview:label];
                oldLabel = label;
            }
            
            oldLabel.hidden = NO;
            badgeText = tabbarItem.customBadgeValue;
            badgeTextLength = badgeText.length > 5 ? 5 : badgeText.length;
            badgeLabelW = badgeLabelH + (badgeTextLength - 1) * 8.0f;
            oldLabel.text = badgeText;
            oldLabel.frame = CGRectMake(tabbarButton.bounds.size.width * 0.58f, 2.0f, badgeLabelW, badgeLabelH);
            oldLabel.layer.cornerRadius = badgeLabelRedius;
        });
        
        
    }

    
    //*********设置plusBtn
    ({
        UIButton *plusButton = [self viewWithTag:plusIndex];
        if (!plusButton) return;
        plusButton.center = CGPointMake(self.bounds.size.width * 0.5, 0);
    });
    
    
}


/**
 销毁通知
 */
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - badgeValue改变通知
-(void)didBadgeValueChanged:(NSNotification *)noti
{
    UITabBarItem *item = (UITabBarItem *)noti.object;
    if (!item || item.index == 0) return;
    NSString *key = [NSString stringWithFormat:@"%ld",item.index];
    
    self.badgeValuesDict[key] = item;
    
    [self setNeedsLayout];
}

#pragma mark - 设置了plusButton
-(void)didSetPlusButton:(NSNotification *)noti
{
    //*********移除原有plusButton
    ({
        UIButton *oldButton = [self viewWithTag:plusIndex];
        if (oldButton) {
            [oldButton removeFromSuperview];
        }
    });
    
    //*********添加plusButton
    ({
        UIButton *currentButton = self.plusBtn;
        if (![currentButton isKindOfClass:[UIButton class]]) return;
        currentButton.tag = plusIndex;
        [currentButton sizeToFit];
        [self addSubview:currentButton];
    });

}

#pragma mark - 拦截plus按钮点击
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if (hitView == nil && CGRectContainsPoint(self.plusBtn.frame, point)) {
        return self.plusBtn;
    }else{
        return hitView;
    }
    
}


@end
