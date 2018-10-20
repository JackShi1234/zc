//
//  ViewControllerRegist1.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerRegist1.h"
#import "ViewControllerRegist2.h"
//#import "ContentVC.h"
@interface ViewControllerRegist1 ()<UITextFieldDelegate>
{
    NSTimer *_timer;
    int _Interval;
    BOOL isTime;
}
@property (nonatomic,strong)NSString *content;
@end

@implementation ViewControllerRegist1
- (IBAction)Agreement:(UIButton *)sender {
//    if (_content.length>0) {
//        ContentVC *contentVc = [[ContentVC alloc] init];
//        contentVc.content = _content;
//        contentVc.titleStr = @"用户协议";
//        [self.navigationController pushViewController:contentVc animated:YES];
//    }
}

#pragma -mark
#pragma -mark 按钮点击方法

- (IBAction)buttonRegist:(UIButton *)sender {
   [self.view endEditing:YES];
    if (_phoneTF.text.length < 1 )
    {
        HUD(@"请输入手机号");
    }
    else if (![CBUtil isValidatePhoneNumber:self.phoneTF.text])
    {
        HUD(@"请输入正确的手机号格式");
    }
    else if (_onePsdTF.text.length < 1 )
    {
        HUD(@"请输入密码");
    }
    else if (_teoPsdTF.text.length < 1 )
    {
        HUD(@"请再次输入密码");
    }else if (![_onePsdTF.text isEqualToString:_teoPsdTF.text] )
    {
        HUD(@"两次密码不一致");
    }
    else if (_selectedBtn.selected == NO)
    {
        HUD(@"请仔细阅读协议后勾选协议");
    }
    else
    {
        ViewControllerRegist2 *regist2 = [[ViewControllerRegist2 alloc]initWithNibName:@"ViewControllerRegist2" bundle:nil];
        regist2.phone = _phoneTF.text;
        regist2.password = [Utils md5:[Utils md5:_onePsdTF.text]];
        regist2.psd = [Utils md5:[Utils md5:_teoPsdTF.text]];
        regist2.code = _codeTF.text;
        regist2.jumpType = 0;
        [self.navigationController pushViewController:regist2 animated:YES];
    }
    
}
- (IBAction)buttonLogin:(UIButton *)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    [self getAgreement];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
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

- (IBAction)selectBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
- (IBAction)getCode:(UIButton *)sender
{
    
    [self.view endEditing:YES];
    if (_phoneTF.text.length < 1 ) {
        HUD(@"请输入手机号");
        return;
    }
    else if (![CBUtil isValidatePhoneNumber:self.phoneTF.text]) {
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
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@login/postmessage",SERVER_IP] params:@{@"mobile":_phoneTF.text,@"flag":@"1"} success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        HUD(dic[@"msg"]);
    } fail:^(NSError *error) {
        ShowError
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
    else if (textField == _onePsdTF || textField == _teoPsdTF)
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
- (void)getAgreement
{
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@index/agreement",SERVER_IP] params:@{} success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        if ([dic[@"status"] intValue] == 1) {
            _content = [dic[@"data"] objectForKey:@"content"];
        }
        else
        {
            HUD(dic[@"msg"]);
        }
    } fail:^(NSError *error) {
        ShowError;
    }];
}
@end
