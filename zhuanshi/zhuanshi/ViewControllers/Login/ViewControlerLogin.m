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
//- (void)loginTheUser{
//    NSString *phoneid = [GSKeyChainDataManager readUUID].length>0?[GSKeyChainDataManager readUUID]:@"123";
//    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@login/login",SERVER_IP] params:@{@"mobile":_phoneNumber.text,@"password":[Utils md5:[Utils md5:_passWord.text]],@"phoneid":phoneid} success:^(id response) {
//        NSDictionary *dic = (NSDictionary *)response;
//        UserModel *model = [UserModel modelWithJSON:dic[@"data"]];
//        if ([dic[@"status"] intValue] == 1) {
//            [[NSUserDefaults standardUserDefaults] setObject:model.userid forKey:@"userid"];
//            [[NSUserDefaults standardUserDefaults] setObject:model.token forKey:@"token"];[[NSUserDefaults standardUserDefaults] setObject:_phoneNumber.text forKey:@"phone"];
//            ViewControllerMain *vc = [[ViewControllerMain alloc]init];
//            UINavigationController * navigationCenter = [[UINavigationController alloc] initWithRootViewController:vc];
//            navigationCenter.navigationBar.hidden = YES;
//            UIWindow * window = [UIApplication sharedApplication].delegate.window;
//            window.rootViewController = navigationCenter;
//        }
//        //未缴纳费用
//        else if ([dic[@"status"] intValue] == 7)
//        {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:dic[@"msg"]    preferredStyle: UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                ViewControllerRegist4 *regist4 = regist4 = [[ViewControllerRegist4 alloc]initWithNibName:@"ViewControllerRegist4" bundle:nil];
//                regist4.jumpType = 1;
//                regist4.userID = model.userid;
//                regist4.token = model.token;
//                regist4.price = -999;
//                [self.navigationController pushViewController:regist4 animated:YES];
//            }]];
//            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//            }]];
//            //弹出提示框；
//            [self presentViewController:alert animated:true completion:nil];
//
//
//
//        //审核被驳回
//        }else if ([dic[@"status"] intValue] == 8)
//        {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:dic[@"msg"]    preferredStyle: UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                ViewControllerRegist2 *regist2 = regist2 = [[ViewControllerRegist2 alloc]initWithNibName:@"ViewControllerRegist2" bundle:nil];
//                regist2.jumpType = 1;
//                regist2.userID = model.userid;
//                [self.navigationController pushViewController:regist2 animated:YES];
//            }]];
//            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//            }]];
//            //弹出提示框；
//            [self presentViewController:alert animated:true completion:nil];
//        }
//        else{
//            HUD(dic[@"msg"]);
//        }
//    } fail:^(NSError *error) {
//        ShowError
//    }];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
