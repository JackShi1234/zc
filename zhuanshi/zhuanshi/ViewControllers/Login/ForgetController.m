//
//  ForgetController.m
//  CarBusess
//
//  Created by yuantuo on 2018/5/26.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ForgetController.h"

@interface ForgetController ()<UITextFieldDelegate>
{
    NSTimer *_timer;
    int _Interval;
    BOOL isTime;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewtopConstraint;



@end

@implementation ForgetController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"ViewControllerElse" bundle:nil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    if (version.doubleValue <= 11) {
        self.ViewtopConstraint.constant = 64;
    }else {
        self.ViewtopConstraint.constant = 0;
    }
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

- (IBAction)confirmBtnClick:(UIButton *)sender
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
    }else if (_twoPsdTf.text.length <1) {
        HUD(@"请再次输入密码");
    }else if (![_twoPsdTf.text isEqualToString:_psdTF.text]){
        HUD(@"两次密码输入不一致");
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
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@login/postmessage",SERVER_IP] params:@{@"mobile":_phoneTF.text,@"flag":@"2"} success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        HUD(dic[@"msg"]);
    } fail:^(NSError *error) {
        ShowError
    }];
}
#pragma mark - 忘记密码
- (void)commitData
{
    NSDictionary *dic = @{@"code":_codeTF.text,@"password":_psdTF.text,@"mobile":_phoneTF.text};
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_IP,@"User/editpassword"] params:dic success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        if ([dic[@"status"] intValue] == 1) {
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
    else if (textField == _psdTF || textField == _twoPsdTf)
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
