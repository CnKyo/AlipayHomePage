//
//  ViewController.m
//  AlipayHomePageDemo
//
//  Created by xuchaoqi on 2017/5/10.
//  Copyright © 2017年 MS. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+rightAndLeft.h"
#import "SpeTableView.h"
#import "MJRefresh.h"

#define kScreen_Width   [UIScreen mainScreen].bounds.size.width
#define kScreen_Height   [UIScreen mainScreen].bounds.size.height
#define kFunctionHeaderViewHeight    95
#define kCoverHeaderViewHeight   60
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic , strong)UIView *navBgView;
@property (nonatomic , strong)UIView *firstLevelNavView;
@property (nonatomic , strong)UIView *secondLevelNavView;
@property (nonatomic , strong)SpeTableView *tableView;
@property (nonatomic , strong)UIView *functionHeaderView;
@property (nonatomic , strong)UIView *coverHeaderView;
@property (nonatomic , strong)UIView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}


- (void)createUI {
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreen_Width, 1000);
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(kFunctionHeaderViewHeight+kCoverHeaderViewHeight, 0, 0, 0);
    [self.view addSubview:_scrollView];
    
    _navBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
    _navBgView.backgroundColor = [UIColor colorWithRed:65/255.0 green:128/255.0 blue:1 alpha:1];
    [self.view addSubview:_navBgView];
    
    _firstLevelNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
    _firstLevelNavView.backgroundColor = [UIColor clearColor];
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payBtn setImage:[UIImage imageNamed:@"home_bill"] forState:UIControlStateNormal
     ];
    [payBtn setTitle:@"账单" forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    payBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [payBtn sizeToFit];
    payBtn.frame = CGRectMake(10, 20+10, payBtn.frame.size.width+10, payBtn.frame.size.height);
    [_firstLevelNavView addSubview:payBtn];
    [self.view addSubview:_firstLevelNavView];
    
    _secondLevelNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
    _secondLevelNavView.backgroundColor = [UIColor clearColor];
    UIButton *billBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billBtn setImage:[UIImage imageNamed:@"pay_mini"] forState:UIControlStateNormal
     ];
    [billBtn sizeToFit];
    billBtn.frame = CGRectMake(10, 20+10, billBtn.frame.size.width+10, billBtn.frame.size.height);
    [_secondLevelNavView addSubview:billBtn];
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn setImage:[UIImage imageNamed:@"scan_mini"] forState:UIControlStateNormal
     ];
    [scanBtn sizeToFit];
    scanBtn.frame = CGRectMake(CGRectGetMaxX(billBtn.frame)+40, 20+10, billBtn.frame.size.width+10, billBtn.frame.size.height);
    [_secondLevelNavView addSubview:scanBtn];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"camera_mini"] forState:UIControlStateNormal
     ];
    [searchBtn sizeToFit];
    searchBtn.frame = CGRectMake(CGRectGetMaxX(scanBtn.frame)+40, 20+10, billBtn.frame.size.width+10, billBtn.frame.size.height);
    [_secondLevelNavView addSubview:searchBtn];
    _secondLevelNavView.alpha = 0;
    [self.view addSubview:_secondLevelNavView];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kFunctionHeaderViewHeight+kCoverHeaderViewHeight)];
    _headerView.backgroundColor = [UIColor colorWithRed:65/255.0 green:128/255.0 blue:1 alpha:1];
    [_scrollView addSubview:_headerView];
    
    _functionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kFunctionHeaderViewHeight)];
    _functionHeaderView.backgroundColor = [UIColor clearColor];
    CGFloat padding = 5.0f;
    CGFloat buttonW = kScreen_Width/4.0 - padding*2;
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(padding, padding, buttonW, buttonW);
    [btn1 setImage:[UIImage imageNamed:@"home_scan"] forState:UIControlStateNormal];
    [btn1 setTitle:@"扫一扫" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn1 adjustmentButtonShowLeftAndRight];
    [_functionHeaderView addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(padding+kScreen_Width/4, padding, buttonW, buttonW);
    [btn2 setImage:[UIImage imageNamed:@"home_pay"] forState:UIControlStateNormal];
    [btn2 setTitle:@"付款" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn2 adjustmentButtonShowLeftAndRight];
    [_functionHeaderView addSubview:btn2];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(padding+kScreen_Width/4*2, padding, buttonW, buttonW);
    [btn3 setImage:[UIImage imageNamed:@"home_card"] forState:UIControlStateNormal];
    [btn3 setTitle:@"卡券" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn3 adjustmentButtonShowLeftAndRight];
    [_functionHeaderView addSubview:btn3];
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(padding+kScreen_Width/4*3, padding, buttonW, buttonW);
    [btn4 setImage:[UIImage imageNamed:@"home_xiu"] forState:UIControlStateNormal];
    [btn4 setTitle:@"到位" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn4 adjustmentButtonShowLeftAndRight];
    [_functionHeaderView addSubview:btn4];
    [_headerView addSubview:_functionHeaderView];
    
    _coverHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, kFunctionHeaderViewHeight, kScreen_Width, kCoverHeaderViewHeight)];
    _coverHeaderView.backgroundColor = [UIColor grayColor];
    [_headerView addSubview:_coverHeaderView];
    
    _tableView = [[SpeTableView alloc]initWithFrame:CGRectMake(0, kCoverHeaderViewHeight+kFunctionHeaderViewHeight, kScreen_Width, 1000-kFunctionHeaderViewHeight-kCoverHeaderViewHeight) style:UITableViewStylePlain];
    __weak typeof(self) weakSelf = self;
    _tableView.changeContentSize = ^(CGSize size){
        [weakSelf updateContentSize:size];
    };
    _tableView.scrollEnabled = NO;
    [_scrollView addSubview:_tableView];
    
    _scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_scrollView.mj_footer endRefreshing];
            [self.tableView loadMoreData];
        });
    }];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateContentSize:self.tableView.contentSize];
}

#pragma mark - Actions
- (void)updateContentSize:(CGSize)size{
    CGSize contentSize = size;
    contentSize.height = contentSize.height + kFunctionHeaderViewHeight + kCoverHeaderViewHeight;
    _scrollView.contentSize = contentSize;
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height = contentSize.height;
    self.tableView.frame = tableViewFrame;
}

#pragma mark - UIScrollerViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"y=====%f",y);
    if (y <= 0) {
        CGRect newFrame = self.headerView.frame;
        newFrame.origin.y = y;
        self.headerView.frame = newFrame;
        
        newFrame = self.tableView.frame;
        newFrame.origin.y = y + kCoverHeaderViewHeight + kFunctionHeaderViewHeight;
        self.tableView.frame = newFrame;
        
        //偏移量给到tableview，tableview自己来滑动
        [self.tableView setContentOffsetY:y];
        
        //滑动太快有时候不正确
        newFrame = self.functionHeaderView.frame;
        newFrame.origin.y = 0;
        self.functionHeaderView.frame = newFrame;
        
    } else if (y < kFunctionHeaderViewHeight && y > 0){
        //处理功能区隐藏和视差
        CGRect newFrame = self.functionHeaderView.frame;
        newFrame.origin.y = y/2;
        
        
        //处理透明度
        CGFloat alpha = (1 - y/kFunctionHeaderViewHeight*2.5 ) > 0 ? (1 - y/kFunctionHeaderViewHeight*2.5 ) : 0;
        self.functionHeaderView.frame = newFrame;
        self.functionHeaderView.alpha = alpha;
        
        if (alpha > 0.5) {
            CGFloat newAlpha =  alpha*2 - 1;
            self.firstLevelNavView.alpha = newAlpha;
            self.secondLevelNavView.alpha = 0;
        } else {
            CGFloat newAlpha =  alpha*2;
            self.firstLevelNavView.alpha = 0;
            self.secondLevelNavView.alpha = 1 - newAlpha;
        }
        
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 松手时刷新
    CGFloat y = scrollView.contentOffset.y;
    
    
    if (y < -65) {
        [self.tableView.mj_header beginRefreshing];
    } else if (y > 0 && y <= kFunctionHeaderViewHeight) {
        if (y > kFunctionHeaderViewHeight/2.0) {
            [self.scrollView setContentOffset:CGPointMake(0, 95) animated:YES];
        } else {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}

@end
