//
//  ViewControllerRegist2.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerRegist2.h"
#import "ViewControllerRegist3.h"
@interface ViewControllerRegist2 ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate,UITextFieldDelegate>
@property (nonatomic,assign) BOOL isCardImg;
@property (nonatomic,strong) UIImage *cardimg,*bcardimg;
@end

@implementation ViewControllerRegist2
#pragma -mark
#pragma -mark 按钮点击方法
- (IBAction)gotoNext:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (_realnameTF.text.length < 1) {
        HUD(@"请输入您的真实姓名");
    }
    else if (_usercardTF.text.length <1){
        HUD(@"请输入您的身份证号");
    }else if (![Utils validateIdentityCard:_usercardTF.text]){
        HUD(@"请输入正确的身份证号");
    }else if (_cardimg == nil){
        HUD(@"请上传身份证正面照片");
    }
    else if (_bcardimg == nil){
        HUD(@"请上传身份证反面照片");
    }
    else{
        ViewControllerRegist3 *regist3 = [[ViewControllerRegist3 alloc]initWithNibName:@"ViewControllerRegist3" bundle:nil ];
        regist3.phone = self.phone;
        regist3.password = self.password;
        regist3.psd = self.psd;
        regist3.realname = _realnameTF.text;
        regist3.usercard = _usercardTF.text;
        regist3.cardimg = _cardimg;
        regist3.bcardimg = _bcardimg;
        regist3.code = self.code;
        regist3.jumpType = _jumpType;
        regist3.userID = self.userID;
        [self.navigationController pushViewController:regist3 animated:YES];
    }

}


#pragma -mark
#pragma -mark system
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"上传身份信息";
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

- (IBAction)selectImg:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (sender == self.cardImgBtn) {
        _isCardImg = YES;
    }
    else{
        _isCardImg = NO;
    }
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
    if (_isCardImg) {
        [self.cardImgBtn setImage:image forState:UIControlStateNormal];
        _cardimg = image;
        
    }
    else{
        [self.bcardImgBtn setImage:image forState:UIControlStateNormal];
        _bcardimg = image;
    }
}

// 获取相册 时被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    //[self uploadheadImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (_isCardImg) {
        [self.cardImgBtn setImage:image forState:UIControlStateNormal];
        _cardimg = image;
        
    }
    else{
        [self.bcardImgBtn setImage:image forState:UIControlStateNormal];
        _bcardimg = image;
    }
}
@end
