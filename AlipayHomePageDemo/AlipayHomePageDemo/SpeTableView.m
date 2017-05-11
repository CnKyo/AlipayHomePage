//
//  SpeTableView.m
//  AlipayHomePageDemo
//
//  Created by xuchaoqi on 2017/5/10.
//  Copyright © 2017年 MS. All rights reserved.
//

#import "SpeTableView.h"
#import "MJRefresh.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface SpeTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , assign)NSInteger number;

@end
@implementation SpeTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.number = 20;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.mj_header endRefreshing];
            });
        }];
    }
    return self;
}

-(void)setContentOffsetY:(CGFloat)contentOffsetY {
    _contentOffsetY = contentOffsetY;
    if (![self.mj_header isRefreshing]) {
        
        self.contentOffset = CGPointMake(0, contentOffsetY);
    }
}

- (void)loadMoreData{
    self.number += 10;
    [self reloadData];
    self.changeContentSize(self.contentSize);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.number;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
