//
//  SpeTableView.h
//  AlipayHomePageDemo
//
//  Created by xuchaoqi on 2017/5/10.
//  Copyright © 2017年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeTableView : UITableView
@property(assign,nonatomic)CGFloat contentOffsetY;
@property (nonatomic , copy)void (^changeContentSize)(CGSize);

-(void)loadMoreData;
@end
