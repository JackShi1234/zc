//
//  UIStatusView.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/20.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "UIStatusView.h"

@interface UIStatusView()
@property (nonatomic,assign)NSInteger local;
@property (nonatomic,copy)NSArray *arrayTitle;
@property (nonatomic,copy)NSArray *arrayImage;
@end;

@implementation UIStatusView
-(UIStatusView *)initWithFrame:(CGRect)frame local:(NSInteger)local block:(getText)block
{
    self = [super initWithFrame:frame];
    if (self) {
        self.local = local;
        self.aBlock = block;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    self.backgroundColor = [UIColor whiteColor];
    if (self.local==0) {
        self.arrayTitle = @[@"下架发布",@"修改",@"已售出"];
        self.arrayImage = @[@"wdcl-xj",@"wdcl-bj",@"wdcl-zs"];
    }else if (self.local==4)
    {
        self.arrayTitle = @[@"上架发布",@"修改",@"删除"];
        self.arrayImage = @[@"wdcl-sj",@"wdcl-bj",@"wdcl-sc"];
    }else if (self.local==3)
    {
        self.arrayTitle = @[@"删除",@"修改"];
        self.arrayImage = @[@"wdcl-sc",@"wdcl-bj"];
    }
    for (int i=0; i<self.arrayTitle.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kWidth/self.arrayTitle.count*i, 0, (kWidth-self.arrayTitle.count-1)/self.arrayTitle.count, self.frame.size.height)];
        [button setImage:[UIImage imageNamed:self.arrayImage[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:self.arrayTitle[i] forState:UIControlStateNormal];
        [button setTitleColor:Usual66Color forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.arrayTitle[i]isEqualToString:@"修改"]) {
            [button setTitleColor:UsualBlueColor forState:UIControlStateNormal];
        }
        [self addSubview:button];
        
        UILabel *labelLine = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/self.arrayTitle.count*(i+1), 5, kWidth/self.arrayTitle.count, 20)];
        labelLine.backgroundColor = UsualGrayColor;
        [self addSubview:labelLine];
    }
}

-(void)buttonClick:(UIButton *)button
{
    if (self.aBlock) {
        self.aBlock(button.titleLabel.text);
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
