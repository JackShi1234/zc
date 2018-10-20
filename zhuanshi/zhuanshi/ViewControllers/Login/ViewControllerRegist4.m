//
//  ViewControllerRegist4.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerRegist4.h"
//#import "ViewControllerMain.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "WXApi.h"
@interface ViewControllerRegist4 ()
@property (nonatomic,strong)NSString *type;
@property (nonatomic,assign) BOOL isPay;
@end

@implementation ViewControllerRegist4

#pragma -mark
#pragma -mark 按钮方法

- (IBAction)PayDone:(UIButton *)sender
{
    if (_jumpType == 0) {
        [self.view endEditing:YES];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self registerUser];
    }
    //未缴纳保证金
    else if (_jumpType == 1){
        [self pay];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXPayComplete" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AliPayComplete" object:nil];
}
#pragma -mark
#pragma -mark system
- (void)viewDidLoad {
    [super viewDidLoad];
    _type= @"2";
    // Do any additional setup after loading the view.
    self.title = @"支付保证金";
    if (_price < 0) {
        [self getMoneyData];
    }
    else{
        _payMoneyLab.text = [NSString stringWithFormat:@"%.2f元",_price];
    }
    _wechatPay.selected = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onResp:) name:@"WXPayComplete" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didWork:) name:@"AliPayComplete" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 获取注册金额
- (void)getMoneyData
{
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@login/getmoney",SERVER_IP] params:@{} success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        if ([dic[@"status"] intValue] == 1) {
            _payMoneyLab.text = [NSString stringWithFormat:@"%@元",dic[@"data"]];
            _price = [dic[@"data"] floatValue];
        }
        else{
            HUD(dic[@"msg"]);
        }
       
    } fail:^(NSError *error) {
        ShowError
    }];
}
- (IBAction)selectWechat:(UIButton *)sender
{
    _wechatPay.selected = !_wechatPay.selected;
    _aplipay.selected = !_wechatPay.selected;
    if (_wechatPay.selected) {
        _type = @"2";
    }
}

- (IBAction)selecAlipay:(UIButton *)sender
{
    _aplipay.selected = !_aplipay.selected;
    _wechatPay.selected = !_aplipay.selected;
    if (_aplipay.selected) {
        _type = @"1";
    }
}
- (void)registerUser
{
    NSMutableArray *imageArr  = [NSMutableArray arrayWithObjects:_cardimg,_bcardimg,_shopimg, nil];
    NSMutableArray *nameArr  = [NSMutableArray arrayWithObjects:@"cardimg",@"bcardimg",@"shopimg", nil];
    [LXNetworking uploadWithImageArray:imageArr url:[NSString stringWithFormat:@"%@login/register",SERVER_IP] filename:nil name:nameArr params:@{@"mobile":_phone,@"password":_password,@"pwd":_psd,@"code":_code,@"realname":_realname,@"usercard":_usercard,@"shopname":_shopname,@"province":_province,@"city":_city,@"county":_county,@"shopaddress":_shopaddress,@"type":_type} progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    } success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dic[@"status"] intValue] == 1) {
           // [self.navigationController popToRootViewControllerAnimated:YES];
            _token = [dic[@"data"] objectForKey:@"token"];
            _userID = [dic[@"data"] objectForKey:@"userid"];
            [self pay];
        }
        else{
            HUD(dic[@"msg"]);
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        ShowError
    }];
}
- (void)pay{
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@Login/postmoney",SERVER_IP] params:@{@"token":_token,@"userid":_userID,@"money":[NSString stringWithFormat:@"%.2f",_price],@"flag":_type} success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dic[@"status"] intValue] == 1) {
            if([_type isEqualToString:@"1"]){
//                [self doAlipayPayWithPayDic:dic];
            }else{
//                [self doWXPayWithOrderDic:dic[@"data"]];
            }
        }
        else{
            HUD(dic[@"msg"]);
        }
    } fail:^(NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         ShowError
    }];
}
    
#pragma mark -
#pragma mark   微信支付
//- (void)doWXPayWithOrderDic:(NSDictionary *)dic
//{
//    if (![WXApi isWXAppInstalled]) {
//
//        HUD(@"未安装微信客户端");
//        return;
//    }
//    //设置支付参数
//    time_t now;
//    time(&now);
//    NSString *time_stamp  = [NSString stringWithFormat:@"%ld", now];
//    NSLog(@"%d",time_stamp.intValue);
//    //调起微信支付
//    PayReq* req             = [[PayReq alloc] init];
//    req.openID              = [dic objectForKey:@"appid"];
//    req.partnerId           = [dic objectForKey:@"partnerid"];
//    req.prepayId            = [dic objectForKey:@"prepayid"];
//    req.nonceStr            = [dic objectForKey:@"noncestr"];
//    req.timeStamp           = [[dic objectForKey:@"timestamp"] intValue];
//    req.package             = [dic objectForKey:@"package"];
//    req.sign                = [dic objectForKey:@"sign"];
//
//    BOOL ii = [WXApi sendReq:req];
//    if (ii==NO) {
//        HUD(@"微信调起失败");
//    }
//
//}
#pragma mark -
#pragma mark   支付宝支付
//- (void)doAlipayPayWithPayDic:(NSDictionary *)dic
//{
//    NSString *appScheme = @"carBussess";
//
//    [[AlipaySDK defaultService] payOrder:dic[@"data"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//        NSLog(@"reslut = %@",resultDic);
//        NSString *code = [resultDic objectForKey:@"resultStatus"];
//        if ([code isEqualToString:@"9000"])
//        {
//            _isPay = YES;
//            //支付成功
//            [self goMyOrder];
//
//        }else if ([code isEqualToString:@"6001"])
//        {
//            HUD(@"支付取消");
//            [self performSelector:@selector(goMyOrder) withObject:self afterDelay:1.5];
//        }
//        else
//        {
//            [self goMyOrder];
//        }
//
//    }];
//}
- (void)goMyOrder
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 根据支付结果做判断
    
//- (void)didWork:(NSNotification *)sender
//{
//    NSDictionary *resultDic = sender.userInfo;
//    NSString *code = [resultDic objectForKey:@"resultStatus"];
//    if ([code isEqualToString:@"9000"])
//    {
//        _isPay = YES;
//        //支付成功
//        [self goMyOrder];
//        
//    }else if ([code isEqualToString:@"6001"])
//    {
//        HUD(@"支付取消");
//        [self performSelector:@selector(goMyOrder) withObject:self afterDelay:1.5];
//    }else
//    {
//        HUD(@"支付失败");
//        [self performSelector:@selector(goMyOrder) withObject:self afterDelay:1.5];
//    }
//}
//-(void) onResp:(NSNotification *)noti
//    {
//        BaseResp* resp = [noti object];
//        //[_hud hide:YES];
//        if([resp isKindOfClass:[PayResp class]]){
//            //支付返回结果，实际支付结果需要去微信服务器端查询
//            switch (resp.errCode) {
//                case WXSuccess:
//                {
//                    //支付成功
//                    _isPay = YES;
//                    [self goMyOrder];
//                    break;
//                }
//                case WXErrCodeUserCancel:
//                {
//                    //支付取消
//                    HUD(@"支付取消");
//                    [self performSelector:@selector(goMyOrder) withObject:self afterDelay:1.5];
//                    break;
//                }
//                
//                default:
//                {
//                    //支付失败
//                    HUD(@"支付失败");
//                }
//                break;
//            }
//        }
//    }
@end

