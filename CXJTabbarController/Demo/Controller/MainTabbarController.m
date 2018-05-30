//
//  MainTabbarController.m
//  CXJTabbarController
//
//  Created by pro on 2018/5/29.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//  使用说明:
//  1.继承CXJTabbarContoller
//  2.调用-(void)setPlusButton:(nonnull UIButton *)plusButton; 设置plus按钮
//  3.其它的可设置badge背景色及字体颜色
//(其它用法与原生无区别)

#import "MainTabbarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "PlusViewController.h"
#import "PlusButton.h"
@interface MainTabbarController ()

@end

@implementation MainTabbarController
+(void)load
{
    UITabBarItem *barItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    [barItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:150.0/256 green:115.0/256 blue:20.0/256 alpha:1.0f]} forState:UIControlStateSelected];
    
    UITabBar *tabbar = [UITabBar appearanceWhenContainedIn:self, nil];
    tabbar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    //tabbar.shadowImage = [UIImage imageNamed:@"tabbar_background"];
    tabbar.backgroundColor = [UIColor whiteColor];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //*********添加子控制器
    ({
        //设置badgeValue
        [self addChildViewController:[[FirstViewController alloc] init] itemTitle:@"主页" icon:@"home"];
        [self addChildViewController:[[SecondViewController alloc] init] itemTitle:@"消息" icon:@"message"];
        [self addChildViewController:[[ThreeViewController alloc] init] itemTitle:@"定位" icon:@"mycity"];
        [self addChildViewController:[[FourViewController alloc] init] itemTitle:@"我的" icon:@"account"];
        
        [self setSelectedIndex:0];
    });
    
    //*********添加plus按钮
    PlusButton *plusBtn = ({
        PlusButton *plusBtn = [PlusButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn addTarget:self action:@selector(didClickPlusButton:) forControlEvents:UIControlEventTouchDown];
        plusBtn;
    });
    [self setPlusButton:plusBtn];
    
    //*********设置badge背景颜色和文字颜色
    ({
        self.badgeBackgroundColor = [UIColor colorWithRed:150.0/256 green:115.0/256 blue:20.0/256 alpha:1.0f];
        self.badgeTitleColor = [UIColor whiteColor];
    });
}

#pragma mark - 添加子控制器
-(void)addChildViewController:(UIViewController *)childController itemTitle:(NSString *)title icon:(NSString *)icon
{
    childController.title = title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",icon]];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_highlight",icon]];
    
    [self addChildViewController:nav];
}


#pragma mark - 点击plus回调
-(void)didClickPlusButton:(UIButton *)plusButton
{
    PlusViewController *plusVC = [[PlusViewController alloc] init];
    [self presentViewController:plusVC animated:YES completion:nil];
    
}

@end
