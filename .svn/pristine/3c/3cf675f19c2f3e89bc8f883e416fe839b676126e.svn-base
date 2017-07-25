//
//  TDTabBarVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/3.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDTabBarVC.h"
#import "TDNavigationVC.h"
#import "TDHomeVC.h"
#import "TDProfileHomeVC.h"
#import "TDInfoHomeVC.h"
#import "TDAgricultureHomeVC.h"
@interface TDTabBarVC ()

@end

@implementation TDTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    // 1.初始化子控制器
    TDHomeVC *home = [[TDHomeVC alloc] init];
    [self addChildVc:home title:@"首页" image:@"home" selectedImage:@"home_s"];
    
    TDAgricultureHomeVC *agriculture = [[TDAgricultureHomeVC alloc] init];
    [self addChildVc:agriculture title:@"农产品" image:@"shop" selectedImage:@"shop_s"];
    
    TDInfoHomeVC *info = [[TDInfoHomeVC alloc] init];
    [self addChildVc:info title:@"资讯" image:@"news" selectedImage:@"news_s"];
    
    TDProfileHomeVC *profile = [[TDProfileHomeVC alloc] init];
    [self addChildVc:profile title:@"我的" image:@"me" selectedImage:@"me_s"];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName :kThemeBlue
                                                        } forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName : kMainFigure
                                                        } forState:UIControlStateNormal];
}

#pragma mark - Private Method

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
//    [childVc.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    // 设置文字的样式
    //    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    //    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    //    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    childVc.title=title;
    TDNavigationVC *nav = [[TDNavigationVC alloc] initWithRootViewController:childVc];
    if([nav.viewControllers objectAtIndex:0]){
        // childVc.tabBarController.title =@"精选";
        // childVc.title=@"我要出国";
    }
    [self addChildViewController:nav];
}

@end
