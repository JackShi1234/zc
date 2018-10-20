//
//  ViewControllerRegist2.h
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerElse.h"
@interface ViewControllerRegist2 : ViewControllerElse
@property (weak, nonatomic) IBOutlet UITextField *realnameTF;
@property (weak, nonatomic) IBOutlet UITextField *usercardTF;
@property (nonatomic,strong) NSString *phone,*code,*password,*psd,*userID;
@property (weak, nonatomic) IBOutlet UIButton *cardImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *bcardImgBtn;
- (IBAction)selectImg:(UIButton *)sender;
// 0 注册 1登录时未审核通过
@property (nonatomic,assign) NSInteger jumpType;
@end
