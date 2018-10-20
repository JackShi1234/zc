//
//  ViewControllerRegist3.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerRegist3.h"
#import "ViewControllerRegist4.h"
//#import "YAddressPickerView.h"
@interface ViewControllerRegist3 ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate,UITextFieldDelegate>
//@property (nonatomic, strong) YAddressPickerView *addView;
@property (nonatomic, assign) float price;
@end

@implementation ViewControllerRegist3

#pragma -mark
#pragma -mark 按钮点击方法

- (IBAction)gotoNext:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_shopNameTF.text.length < 1) {
        HUD(@"请输入您的商铺名称");
    }
    else if (_cityTF.text.length <1){
        HUD(@"请选择店铺所在省市区");
    } else if (_addressTF.text.length <1){
        HUD(@"请输入详细地址");
    }else if (_shopimg == nil){
        HUD(@"请上传店铺照片");
    }//审核驳回重新提交数据
    else if(_jumpType == 1){
        [self editTheMessgae];
    }
    else if (_price > 0 || _price == -999){
        ViewControllerRegist4 *regist4 = [[ViewControllerRegist4 alloc]initWithNibName:@"ViewControllerRegist4" bundle:nil];
        regist4.phone = self.phone;
        regist4.code = self.code;
        regist4.password = self.password;
        regist4.psd = self.psd;
        regist4.realname = self.realname;
        regist4.usercard = self.usercard;
        regist4.cardimg = self.cardimg;
        regist4.bcardimg = self.bcardimg;
        regist4.shopname = _shopNameTF.text;
        regist4.shopimg = _shopimg;
        regist4.price = _price;
        regist4.province = _province;
        regist4.city = _city;
        regist4.county = _county;
        regist4.shopaddress = _addressTF.text;
        [self.navigationController pushViewController:regist4 animated:YES];
    }
    //金额为0,直接注册
    else{
        [self.view endEditing:YES];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self registerUser];
    }

}

#pragma -mark
#pragma -mark system
- (void)viewDidLoad {
    [super viewDidLoad];
    _price = -999;
    // Do any additional setup after loading the view from its nib.
//    self.title = @"上传门店信息";
//    _addView = [[YAddressPickerView alloc]init];
//    [self.view addSubview:_addView];
//    _addView.delegate = self;
    [self getMoney];
}
#pragma mark - AddressViewDelegate
- (void)cancelOnclick{
    //[self addressBtn:self.button];
}
- (void)completingTheSelection:(NSString *)province city:(NSString *)city area:(NSString *)area{
    _province = province;
    _city = city;
    _county = area;
    _cityTF.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    
}
- (void)viewDisappearance{
    
   // self.button.selected = !self.button.selected;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.cityTF) {
        [self.view endEditing:YES];
//        [_addView show];
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectImg:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self editPortrait];
}
- (void)editPortrait {
    //创建图片选择器
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    //设置图像选取控制器的类型为静态图像
    //imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
    //允许用户进行编辑
    imagePicker.allowsEditing = YES;
    //设置委托对象
    imagePicker.delegate = self;
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //指定源类型前，检查图片源是否可用
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            //指定源的类型
            imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            //以模视图控制器的形式显示
            [self presentViewController:imagePicker animated:YES completion:^{}];
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message: @"相册不能使用，请检查设置。"   preferredStyle: UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
            return;
        }
        
    }];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"拍一张" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //检查相机模式是否可用
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message: @"相册不能使用，请检查设置。"   preferredStyle: UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];            NSLog(@"相机不可用.");
            return;
        }else{
            imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            
        }
        
        BOOL canTakePicture = YES;
        if (!canTakePicture) {
            NSLog(@"不支持照相机设备.");
            return;
        }
        //imagePicker.showsCameraControls = YES;
        //以模视图控制器的形式显示
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
        
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action3];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
//拍摄照片时被调用，告知委托对象，选取操作已经完成，同时将返回选取图片的实例
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    // NSLog(@"====info==%@",editingInfo);
    
    //[self uploadheadImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.shopImgBtn setImage:image forState:UIControlStateNormal];
    _shopimg = image;
}

// 获取相册 时被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    //[self uploadheadImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.shopImgBtn setImage:image forState:UIControlStateNormal];
    _shopimg = image;

}
#pragma mark - 获取注册金额
- (void)getMoney
{
    [LXNetworking postWithUrl:[NSString stringWithFormat:@"%@login/getmoney",SERVER_IP] params:@{} success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        if ([dic[@"status"] intValue] == 1) {
//            _payMoneyLab.text = [NSString stringWithFormat:@"%@元",dic[@"data"]];
            _price = [dic[@"data"] floatValue];
        }
        else{
            HUD(dic[@"msg"]);
        }
        
    } fail:^(NSError *error) {
        ShowError
    }];
}
- (void)registerUser
{
    NSMutableArray *imageArr  = [NSMutableArray arrayWithObjects:_cardimg,_bcardimg,_shopimg, nil];
    NSMutableArray *nameArr  = [NSMutableArray arrayWithObjects:@"cardimg",@"bcardimg",@"shopimg", nil];
    [LXNetworking uploadWithImageArray:imageArr url:[NSString stringWithFormat:@"%@login/register",SERVER_IP] filename:nil name:nameArr params:@{@"mobile":_phone,@"password":_password,@"pwd":_psd,@"code":_code,@"realname":_realname,@"usercard":_usercard,@"shopname":_shopname,@"province":_province,@"city":_city,@"county":_county,@"shopaddress":_addressTF.text,@"type":@"3"} progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    } success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dic[@"status"] intValue] == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            HUD(dic[@"msg"]);
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        ShowError
    }];
}
- (void)editTheMessgae
{
    NSMutableArray *imageArr  = [NSMutableArray arrayWithObjects:_cardimg,_bcardimg,_shopimg, nil];
    NSMutableArray *nameArr  = [NSMutableArray arrayWithObjects:@"cardimg",@"bcardimg",@"shopimg", nil];
    [LXNetworking uploadWithImageArray:imageArr url:[NSString stringWithFormat:@"%@login/edituserself",SERVER_IP] filename:nil name:nameArr params:@{@"realname":_realname,@"usercard":_usercard,@"shopname":_shopNameTF.text,@"province":_province,@"city":_city,@"county":_county,@"shopaddress":_addressTF.text,@"userid":self.userID} progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    } success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dic[@"status"] intValue] == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            HUD(dic[@"msg"]);
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        ShowError
    }];
}
@end
