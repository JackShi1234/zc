//
//  UIChooseStatusView.m
//  uitext
//
//  Created by 呵呵 on 2018/4/19.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "UIChooseStatusView.h"

@interface UIChooseStatusView()
@property (nonatomic,weak)UILabel *label;
@property (nonatomic,copy)NSArray *array;
@property (nonatomic,assign)NSInteger local;
@end

@implementation UIChooseStatusView

-(UIChooseStatusView *)initWithFrame:(CGRect)frame Title:(NSArray *)array local:(NSInteger)local block:(getBlock)ablock
{
    self = [super initWithFrame:frame];
    self.local = local;
    if (self) {
        self.myBlock = ablock;
        [self setUIWithTitle:array];
    }
    return self;
}

-(void)setUIWithTitle:(null_unspecified NSArray *)array
{
    self.array = array;
    
    for (int i=0; i<array.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/array.count*i, 0, self.frame.size.width/array.count, self.frame.size.height-1)];
        button.tag = 10+i;
        [button setTitle:array[i] forState:UIControlStateNormal];
        if (i==self.local) {
            [button setTitleColor:UsualBlueColor forState:UIControlStateNormal];
        }else
        {
            [button setTitleColor:RGBCOLOR(66, 66, 66, 1) forState:UIControlStateNormal];
        }
        
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/self.array.count*self.local, self.frame.size.height-1, self.frame.size.width/array.count, 1)];
    label.backgroundColor = UsualBlueColor;
    [self addSubview:label];
    self.label = label;
}

-(void)buttonPress:(UIButton *)sender
{
    for (int i=0; i < self.array.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:10+i];
        if (sender.tag - 10 == i) {
            [btn setTitleColor:UsualBlueColor forState:UIControlStateNormal];
            
        }else{
            [btn setTitleColor:RGBCOLOR(66, 66, 66, 1) forState:UIControlStateNormal];
        }
    }
    self.label.frame = CGRectMake(self.frame.size.width/self.array.count*(sender.tag-10), sender.frame.size.height, self.frame.size.width/self.array.count, 1);
    
    if (self.myBlock) {
        self.myBlock(sender.tag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
