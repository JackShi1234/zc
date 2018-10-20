//
//  CALayer+BordColor.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/11.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "CALayer+BordColor.h"

@implementation CALayer (BordColor)
- (void)setBorderColorWithUIColor:(UIColor *)color

{
    
    self.borderColor = color.CGColor;
    
}
@end
