//
//  ViewControllerRegist.m
//  zhuanshi
//
//  Created by Martintao on 2018/10/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewControllerRegist.h"

@interface ViewControllerRegist ()<UITextFieldDelegate>

@end

@implementation ViewControllerRegist

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//获取验证码方法
- (IBAction)clickGetCode:(id)sender {
    
    NSDictionary * parame = @{
                              @"phonenumber":_confirmTextField.text

                              };
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_IP,SENDCODE] params:parame success:^(id response) {
        
        NSDictionary *dic = (NSDictionary *)response;
        //        UserModel *model = [UserModel modelWithJSON:dic[@"data"]];
        if ([dic[@"code"] intValue] == 1) {
            
            HUD(dic[@"msg"]);
//            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            HUD(dic[@"msg"]);
        }
    } fail:^(NSError *error) {
        ShowError
    }];
}

//注册方法
- (IBAction)clickResign:(id)sender {
    
    NSDictionary * parame = @{
                              @"phonenumber":_passwordTextField.text,
                              @"password":_passwordTextField.text,
                              @"code":_codeTextField.text,
                              @"tgname":_confirmTextField.text,
                              };
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_IP,REGISTER] params:parame success:^(id response) {
        
        NSDictionary *dic = (NSDictionary *)response;
        //        UserModel *model = [UserModel modelWithJSON:dic[@"data"]];
        if ([dic[@"code"] intValue] == 1) {
            
            HUD(dic[@"msg"]);
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            HUD(dic[@"msg"]);
        }
    } fail:^(NSError *error) {
        ShowError
    }];
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
