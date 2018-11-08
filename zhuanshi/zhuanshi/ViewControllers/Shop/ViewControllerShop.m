//
//  ViewControllerShop.m
//  zhuanshi
//
//  Created by Martintao on 2018/10/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewControllerShop.h"
#import "myLabel.h"

#define sFirstTop 

@interface ViewControllerShop ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    SDCycleScrollView *cycleScrollView;
    UITapGestureRecognizer *tap;
    NSString *longStr;
    NSString *url;
    NSMutableArray *bannerStrArr;
    NSNumber *longNumber ;
}

@property (nonatomic , strong)NSMutableArray *scrollerViewArr;
@property (nonatomic,strong)NSMutableArray *UrlArr;
@property (nonatomic ,strong)UIView *scrollerView;
@property (nonatomic ,strong) UITableView * tableView;

@end

@implementation ViewControllerShop

#pragma -mark
#pragma -mark 轮播图;
-(NSMutableArray *)scrollerViewArr{
    if (_scrollerViewArr == nil) {
        _scrollerViewArr = [NSMutableArray array];
    }
    return _scrollerViewArr;
}

-(UIView *)scrollerView{
    
    _scrollerView = [self WscrollViewWithframe:0 :kWidth/1.8 AndUrl:self.scrollerViewArr];
    
    return _scrollerView;
}

-(UIView*)WscrollViewWithframe:(float)x :(float)y AndUrl:(NSMutableArray *)array
{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(x, 0  , kWidth, y)];
    
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,kWidth, kWidth/1.8) imageURLStringsGroup:array];
    
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lunBoOnTap:)];
    [cycleScrollView addGestureRecognizer:tap];
    cycleScrollView.delegate = self;
    //    cycleScrollView.pa = RGBCOLOR(75, 76, 78,1);
    cycleScrollView.dotColor = [UIColor whiteColor];
    cycleScrollView.pageControlDotSize = CGSizeMake(6, 6);
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    //    cycleScrollView.clickItemOperationBlock = ^void (NSInteger clickId) {
    //
    //    };
    [headerView addSubview:cycleScrollView];
    //[self.scrollerViewArr addObject:headerView];
    return headerView;
}

- (void)createView {
    
    myLabel * labelTitle = [[myLabel alloc]initWithFrame:CGRectMake(16, kWidth/1.8 + 20, kWidth-32, 60) text:@"XXX猜中iPhone XS Max 一台" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:30] backgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:labelTitle];
    //    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.mas_equalTo(self.view.mas_leading).offset(16);
    //        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-16);
    //        make.height.mas_equalTo(60);
    //        make.top.mas_equalTo(self.scrollerView.mas_bottom).offset(20);
    //    }];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight+50, kWidth, kHeigth-kTopHeight-50) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
//    [tableView registerClass:[ZCell1 class] forCellReuseIdentifier:@"cell"];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        _page = 1;
        //        [self.bigDataArr removeAllObjects];
        //添加多次刷新，崩溃修复
        [tableView reloadData];
        //        [self getCarList];
    }];
    tableView.mj_header = header;
    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        //        if (self.bigDataArr.count > 0 ) {
        //            _page++;
        //            [self getCarList];
        //        }
    }];
    tableView.mj_footer = footer;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物";
    [self.view addSubview:self.scrollerView];
    [self createView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
