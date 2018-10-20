//
//  ViewControllerRegist4.h
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerElse.h"

@interface ViewControllerRegist4 : ViewControllerElse
@property (nonatomic,strong) NSString *phone,*code,*password,*psd,*realname,*usercard,*shopname,*province,*city,*county,*shopaddress,*userID;
@property (nonatomic,strong) UIImage *cardimg,*bcardimg,*shopimg;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLab;
@property (weak, nonatomic) IBOutlet UIButton *wechatPay;
@property (weak, nonatomic) IBOutlet UIButton *aplipay;
- (IBAction)selectWechat:(UIButton *)sender;
- (IBAction)selecAlipay:(UIButton *)sender;
@property (nonatomic, assign) float price;
// 0注册 1登录时未缴纳保证金
@property (nonatomic,assign) NSInteger jumpType;
@property (nonatomic,strong)NSString *token;
@end
