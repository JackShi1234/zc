//
//  ModifyTelephoneController.h
//  CarBusess
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerElse.h"

@interface ModifyTelephoneController : ViewControllerElse

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
- (IBAction)modifyTelephoneClick:(UIButton *)sender;
- (IBAction)getCode:(UIButton *)sender;

@end
