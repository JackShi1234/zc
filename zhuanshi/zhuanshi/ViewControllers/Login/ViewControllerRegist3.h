//
//  ViewControllerRegist3.h
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "ViewControllerElse.h"

@interface ViewControllerRegist3 : ViewControllerElse
@property (weak, nonatomic) IBOutlet UITextField *shopNameTF;
@property (nonatomic,strong) NSString *phone,*code,*password,*psd,*realname,*usercard,*shopname,*province,*city,*county,*userID;
@property (nonatomic,strong) UIImage *cardimg,*bcardimg,*shopimg;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UIButton *shopImgBtn;
- (IBAction)selectImg:(UIButton *)sender;
// 0 注册 1登录时未审核通过
@property (nonatomic,assign) NSInteger jumpType;
@end
