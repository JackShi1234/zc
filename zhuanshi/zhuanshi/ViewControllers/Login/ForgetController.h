//
//  ForgetController.h
//  CarBusess
//
//  Created by yuantuo on 2018/5/26.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerElse.h"

@interface ForgetController : ViewControllerElse
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UITextField *twoPsdTf;
- (IBAction)confirmBtnClick:(UIButton *)sender;
- (IBAction)getCode:(UIButton *)sender;

@end
