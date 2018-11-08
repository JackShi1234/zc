//
//  myLabel.h
//  zhuanshi
//
//  Created by Martintao on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface myLabel : UILabel

- (instancetype)initWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color font:(UIFont*)font backgroundColor:(UIColor*)bgColor;

@end

NS_ASSUME_NONNULL_END
