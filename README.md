# 支付宝首页渐变效果
支付宝首页的列表是从界面的中间开始的，而上面的部分又是同tableView联动的，并且在滑动过程中，伴随着透明度和frame的调整，感觉上比较炫酷，针对这种效果，做了一个小demo。
效果如下：
![GitHub set up-w140](https://github.com/cusinkgetntly/AlipayHomePage/blob/master/1.gif)
##注意
这个demo实现的方法是在scrollView上添加了tableview的方法，tableView的滑动效果关闭，通过滚动ScrollView实现滚动tableView的效果。本demo把tableView分了一层出来，是为了不让scrollView和tableView的delegate不是同一个对象，方便处理。
##关键代码

```
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

```
借鉴了[https://github.com/seedotlee/AlipayIndexDemo](https://github.com/seedotlee/AlipayIndexDemo)，也使用了这位同学的素材，不过这个demo是swift版本的，效果类似。

