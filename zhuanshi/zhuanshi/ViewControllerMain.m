//
//  ViewControllerMain.m
//  zhuanshi
//
//  Created by Martintao on 2018/10/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewControllerMain.h"
#import "ZLNavgationController.h"
#import "ViewControllerMain.h"
#import "ViewControllerShop.h"


@interface ViewControllerMain ()

@end

@implementation ViewControllerMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTabbar];
}

-(void)createTabbar
{
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    NSArray *controller = @[@"ViewControllerHome",@"ViewControllerShop",@"ViewControllerEntertainment",@"ViewControllerMine"];
    NSArray *imageNormal = @[@"sy-hh",@"fx-hh",@"xx-hh",@"grzx-hh"];
    NSArray *imageSelect = @[@"sy-h",@"fx-h",@"xx-h",@"gezx-h"];
    NSArray *title = @[@"首页",@"购物",@"娱乐",@"我的"];
    NSMutableArray *arrayContrllers = [NSMutableArray array];
    for(int i=0;i<controller.count;i++)
    {
        Class class = NSClassFromString(controller[i]);
        UIViewController *vc = [[class alloc]init];
        ZLNavgationController *nv = [[ZLNavgationController alloc]initWithRootViewController:vc];
        UIImage *normal = [UIImage imageNamed:imageNormal[i]];
        UIImage *select = [UIImage imageNamed:imageSelect[i]];
        UIImage *normal1 = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *select1 = [select imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title[i] image:normal1 selectedImage:select1];
        nv.tabBarItem = item;
        [nv.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
        [arrayContrllers addObject:nv];
    }
    self.viewControllers  = arrayContrllers;
    self.selectedIndex = 0;
}


@end
