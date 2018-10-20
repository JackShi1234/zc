//
//  ModifyTelephoneController.m
//  CarBusess
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ModifyTelephoneController.h"

@interface ModifyTelephoneController ()<UITextFieldDelegate>

{
    NSTimer *_timer;
    int _Interval;
    BOOL isTime;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;

@end

@implementation ModifyTelephoneController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"修改手机号";
    self.codeBtn.layer.cornerRadius = 5.0;
    self.codeBtn.layer.borderColor = UsualBlueColor.CGColor;
    self.codeBtn.layer.borderWidth = 1.0f;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    if (version.doubleValue <= 11) {
        self.viewTopConstraint.constant = 64;
    }else {
        self.viewTopConstraint.constant = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)modifyTelephoneClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (_phoneTF.text.length < 1) {
        HUD(@"请输入手机号");
    }else if (![Utils validateMobile:_phoneTF.text]) {
        HUD(@"请输入正确的手机号格式");
    }else if (_codeTF.text.length <1) {
        HUD(@"请输入验证码");
    }else if (_psdTF.text.length <1) {
        HUD(@"请输入密码");
    }
    else
    {
        [self commitData];
    }
}

- (IBAction)getCode:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (_phoneTF.text.length < 1) {
        HUD(@"请输入手机号");
        return;
    }
    else if (![Utils validateMobile:_phoneTF.text]) {
        HUD(@"请输入正确的手机号格式");
        return;
    }
    if (!isTime) {
        [self.view endEditing:YES];
        _Interval = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeOff) userInfo:nil repeats:YES];
        isTime = YES;
        [self getCodeData];
        //HUD(@"验证码已发送到您的手机，请注意查收！")
    }
}
- (void)timeOff
{
    if (_Interval == 1) {
        [_timer invalidate];
        _timer = nil;
        
        // return;
    }
    _Interval--;
    [_codeBtn setTitle:[NSString stringWithFormat:@"%ds",_Interval] forState:UIControlStateNormal];
    if (_Interval == 0) {
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        isTime = NO;
    }
}
#pragma mark - 获取验证码
- (void)getCodeData
{
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@login/postmessage",SERVER_IP] params:@{@"mobile":_phoneTF.text,@"flag":@"3"} success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        HUD(dic[@"msg"]);
    } fail:^(NSError *error) {
        ShowError
    }];
}
#pragma mark - 修改手机号
- (void)commitData
{
    NSDictionary *dic = @{@"code":_codeTF.text,@"password":[Utils md5:[Utils md5:_psdTF.text]],@"mobile":_phoneTF.text,@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"userid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]};
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_IP,@"user/editmobile"] params:dic success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        if ([dic[@"status"] intValue] == 1) {
            HUD(dic[@"msg"]);
            [[NSUserDefaults standardUserDefaults] setObject:_phoneTF.text forKey:@"phone"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            HUD(dic[@"msg"]);
        }
    } fail:^(NSError *error) {
        ShowError;
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text;
    text = [NSString stringWithFormat:@"%@%@",textField.text,string];
    if (range.length > 0) {
        text = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
    }
    //NSLog(@"text:%@--内容%@---长度%ld--string:%@",text,textField.text,text.length,string);
    if (textField == _phoneTF) {
        //限制只能输入 字母 和 数字
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        if(basic == NO){
            HUD(@"请输入正确的手机号格式");
        }
        if (text.length > 11)
        {
            HUD(@"请输入正确的手机号格式");
            return NO;
        }
        return basic;
    }
    else if (textField == _psdTF)
    {
        
        //判断长度
        if(text.length > 12){
            HUD(@" 密码长度为6~12位 ");
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
