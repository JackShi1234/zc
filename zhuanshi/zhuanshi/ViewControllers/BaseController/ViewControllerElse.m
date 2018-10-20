//
//  ViewControllerElse.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/11.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerElse.h"

@interface ViewControllerElse ()

@end

@implementation ViewControllerElse

-(void)doback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIColor *color = RGBCOLOR(34, 116, 255, 1);
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button setImage:[UIImage imageNamed:@"fh"] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 4);
    [button addTarget:self action:@selector(doback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
     [self.navigationController.navigationBar setBarTintColor:color];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (self.navigationController.viewControllers.count>1) {
        self.navigationItem.leftBarButtonItem = leftItem;
    }
//    self.hidesBottomBarWhenPushed = YES;
//    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
   // self.hidesBottomBarWhenPushed = NO;
   // self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
