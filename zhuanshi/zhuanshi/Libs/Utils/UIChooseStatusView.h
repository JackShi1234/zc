//
//  UIChooseStatusView.h
//  uitext
//
//  Created by 呵呵 on 2018/4/19.
//  Copyright © 2018年 呵呵. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef void(^getBlock)(NSInteger integer);

@interface UIChooseStatusView : UIView
@property (nonatomic,copy)getBlock myBlock;
-(UIChooseStatusView *)initWithFrame:(CGRect)frame Title:(NSArray *)array local:(NSInteger)local block:(getBlock)ablock;
@end
