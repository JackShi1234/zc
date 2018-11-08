//
//  myLabel.m
//  zhuanshi
//
//  Created by Martintao on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "myLabel.h"

@implementation myLabel

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font backgroundColor:(UIColor *)bgColor{
    if (self = [super initWithFrame:frame]) {
        
        self.text = text;
        self.textColor = color;
        self.font = font;
        self.frame = frame;
        self.backgroundColor = bgColor;
    }
    return self;
}

@end
