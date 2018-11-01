//
//  ViewControllerRegist.h
//  zhuanshi
//
//  Created by Martintao on 2018/10/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewControllerBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewControllerRegist : ViewControllerBase
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
@property (weak, nonatomic) IBOutlet UITextField *getPersonTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

NS_ASSUME_NONNULL_END
