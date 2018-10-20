//
//  MyTextField.m
//  testakjdflakdj
//
//  Created by zhang on 2017/9/21.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

static NSString * const DXPlaceholderColorKey = @"placeholderLabel.textColor";

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setValue:[UIColor whiteColor] forKeyPath:DXPlaceholderColorKey];
}
- (BOOL)becomeFirstResponder
{
    [self setValue:[UIColor whiteColor] forKeyPath:DXPlaceholderColorKey];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor whiteColor] forKeyPath:DXPlaceholderColorKey];
    return [super resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
