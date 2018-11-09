//
//  ViewControlerLogin.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/11.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControlerLogin.h"
#import "MyTextField.h"
#import "ViewControllerRegist.h"
//#import "GSKeyChainDataManager.h"
#import "ViewControllerMain.h"
//#import "UserModel.h"
#import "ForgetController.h"
@interface ViewControlerLogin ()
@property (weak, nonatomic) IBOutlet MyTextField *phoneNumber;
@property (weak, nonatomic) IBOutlet MyTextField *passWord;

@end

@implementation ViewControlerLogin
#pragma -mark
#pragma -mark buttonPress
- (IBAction)forgetPassword:(UIButton *)sender
{
    ForgetController *forget = [[ForgetController alloc] initWithNibName:@"ForgetController" bundle:nil];
//    forget.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forget animated:YES];
}
- (IBAction)login:(UIButton *)sender
{
//    [self.view endEditing:YES];
//    if(self.phoneNumber.text.length==0)
//    {
//        HUD(@"请输入手机号");
//        return;
//    }
//    if(![CBUtil isValidatePhoneNumber:self.phoneNumber.text])
//    {
//        HUD(@"请输入正确的手机号");
//        return;
//    }
//    if(self.passWord.text.length==0)
//    {
//        HUD(@"请输入密码");
//        return;
//    }
    //调用登陆接口
//    [self loginTheUser];
    ViewControllerMain * main = [[ViewControllerMain alloc]init];
    [self.navigationController pushViewController:main animated:YES];
}
- (IBAction)regist:(UIButton *)sender
{
   // ViewControllerRegist1 *regist1 = [[ViewControllerRegist1 alloc]initWithNibName:@"ViewControllerRegist1" bundle:nil];
    ViewControllerRegist *regist1 = [[ViewControllerRegist alloc] init];
    [self.navigationController pushViewController:regist1 animated:YES];
}


#pragma -mark
#pragma -mark system
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginTheUser{
    NSDictionary * dic = @{@"phonenumber":_phoneNumber.text,@"password":_passWord.text};
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_IP,LOGININ] params:dic success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        if ([dic[@"code"] intValue] == 1) {
    //        [userdefault setObject:dic[@"data"][@"uid"] forKey:@"userid"];
    //        [userdefault setObject:dic[@"data"][@"token"] forKey:@"token"];
            ViewControllerMain *vc = [[ViewControllerMain alloc]init];
            UINavigationController * navigationCenter = [[UINavigationController alloc] initWithRootViewController:vc];
            navigationCenter.navigationBar.hidden = YES;
            UIWindow * window = [UIApplication sharedApplication].delegate.window;
            window.rootViewController = navigationCenter;
        }
        else{
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
