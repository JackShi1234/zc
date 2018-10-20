//
//  ViewControllerRegist1.h
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerElse.h"

@interface ViewControllerRegist1 : ViewControllerElse
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *onePsdTF;
@property (weak, nonatomic) IBOutlet UITextField *teoPsdTF;
- (IBAction)selectBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
- (IBAction)getCode:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end
