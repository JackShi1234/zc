//
//  UIStatusView.h
//  CarBusess
//
//  Created by 呵呵 on 2018/4/20.
//  Copyright © 2018年 呵呵. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef void(^getText)(NSString *string);
@interface UIStatusView : UITableViewHeaderFooterView;
@property (nonatomic,copy) getText aBlock;
-(UIStatusView *)initWithFrame:(CGRect)frame local:(NSInteger)local block:(getText)block;
@end
