//
//  ViewControllerBase.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/11.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerBase.h"

@interface ViewControllerBase ()

@end

@implementation ViewControllerBase

- (void)viewDidLoad {
    [super viewDidLoad];
// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
    [self.navigationController.navigationBar setBarTintColor:UsualBlueColor];

    UIColor *color = RGBCOLOR(34, 116, 255, 1);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBarTintColor:color];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button setImage:[UIImage imageNamed:@"fh"] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 4);
    [button addTarget:self action:@selector(goToBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (self.navigationController.viewControllers.count > 1) {
//        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goToBack)];
//        [leftItem setTintColor:[UIColor whiteColor]];
        self.navigationItem.leftBarButtonItem = leftItem;
    }

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBarTintColor:color];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
- (void)goToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
