//
//  MyButton.m
//  zhuanshi
//
//  Created by Martintao on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor image:(UIImage *)image font:(UIFont *)font backgroundColor:(UIColor *)bgColor {
    if (self == [super initWithFrame:frame]) {
        self.frame = frame;
        self.titleLabel.textColor = textColor;
        self.titleLabel.text = text;
        self.imageView.image = image;
        self.titleLabel.font = font;
        self.backgroundColor = bgColor;
    }
    return self;
}

@end
