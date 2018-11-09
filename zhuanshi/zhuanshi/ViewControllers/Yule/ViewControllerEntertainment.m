//
//  ViewControllerEntertainment.m
//  zhuanshi
//
//  Created by Martintao on 2018/10/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewControllerEntertainment.h"
#import "myLabel.h"

@interface ViewControllerEntertainment ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    SDCycleScrollView *cycleScrollView;
    UITapGestureRecognizer *tap;
    NSString *longStr;
    NSString *url;
    NSMutableArray *bannerStrArr;
    NSNumber *longNumber ;
    NSInteger tag;
}

@property (nonatomic , strong)NSMutableArray *scrollerViewArr;
@property (nonatomic,strong)NSMutableArray *UrlArr;
@property (nonatomic ,strong)UIView *scrollerView;
@property (nonatomic ,strong) UITableView *leftTable;
@property (nonatomic ,strong) UITableView *rightTable;



@end

@implementation ViewControllerEntertainment

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
    
    UILabel * labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(16, kWidth/1.8 + 20, kWidth-32, 60)];
    labelTitle.text = @"XXX喜中iPhone XS Max 一台";
    labelTitle.font = [UIFont systemFontOfSize:30];
    labelTitle.textColor = [UIColor redColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelTitle];
    //    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.mas_equalTo(self.view.mas_leading).offset(16);
    //        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-16);
    //        make.height.mas_equalTo(60);
    //        make.top.mas_equalTo(self.scrollerView.mas_bottom).offset(20);
    //    }];
    
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"问答",@"倾述",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(60, kWidth/1.8 + 20 + 60, kWidth - 120, 60);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor colorWithRed:252/255.0 green:245/255.0 blue:248/255.0 alpha:1];
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth/1.8 + 20 + 60 + 60, kWidth, kHeigth-kWidth/1.8 - 20 - 60 - 60) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
    self.leftTable = tableView;
    [self.view addSubview:tableView];
    
    UITableView *tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth/1.8 + 20 + 60 + 60, kWidth, kHeigth-kWidth/1.8 - 20 - 60 - 60) style:UITableViewStyleGrouped];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    MJRefreshNormalHeader *header1 = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        _page = 1;
        //        [self.bigDataArr removeAllObjects];
        //添加多次刷新，崩溃修复
        [tableView1 reloadData];
        //        [self getCarList];
    }];
    tableView1.mj_header = header1;
    MJRefreshBackFooter *footer1 = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        //        if (self.bigDataArr.count > 0 ) {
        //            _page++;
        //            [self getCarList];
        //        }
    }];
    tableView1.mj_footer = footer1;
    self.rightTable = tableView1;
    [self.view addSubview:tableView1];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tag == 0) {
        return 3;
    }else if (tag == 1) {
        return 4;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tag == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"item";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (tag == 1){
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"itemR";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 60)];
    
    myLabel * label = [[myLabel alloc]initWithFrame:CGRectMake(16, 0, 80, view.bounds.size.height) text:@"iphoneX" textColor:RGBCOLOR(14, 14, 14, 1) font:[UIFont systemFontOfSize:18] backgroundColor:[UIColor whiteColor]];
    [view addSubview:label];
    
    myLabel * label2 = [[myLabel alloc]initWithFrame:CGRectMake(kWidth-150, 0, 40, view.bounds.size.height) text:@"88" textColor:RGBCOLOR(14, 14, 14, 1) font:[UIFont systemFontOfSize:18] backgroundColor:[UIColor whiteColor]];
    [view addSubview:label2];
    
    UIButton *buttonMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonMessage setTitle:@"参加竞猜" forState:UIControlStateNormal];
    [buttonMessage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonMessage.layer.cornerRadius = 10.0f;
    buttonMessage.titleLabel.font = [UIFont systemFontOfSize:15];
    buttonMessage.backgroundColor = RGBCOLOR(14,14,14, 1);
    @weakify(self)
    [buttonMessage addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        //        [weak_self releaseMsg];
    }];
    buttonMessage.frame = CGRectMake(kWidth - 100, 10, 80, 40);
    [view addSubview:buttonMessage];
    
    return view;
}

-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    //我定义了一个 NSInteger tag，是为了记录我当前选择的是分段控件的左边还是右边。
    NSInteger selecIndex = sender.selectedSegmentIndex;
    switch(selecIndex){
        case 0:
        self.leftTable.hidden = NO;
        self.rightTable.hidden = YES;
        sender.selectedSegmentIndex=0;
        tag = 0;
        [self.leftTable reloadData];
        break;
        case 1:
        self.leftTable.hidden = YES;
        self.rightTable.hidden = NO;
        sender.selectedSegmentIndex = 1;
        tag=1;
        [self.rightTable reloadData];
        break;
        default:
        break;
            
    }
    
}
    
    

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"娱乐";
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
