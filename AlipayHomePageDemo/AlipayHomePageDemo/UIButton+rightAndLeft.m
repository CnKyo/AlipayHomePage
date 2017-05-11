//
//  UIButton+rightAndLeft.m
//  AlipayHomePageDemo
//
//  Created by xuchaoqi on 2017/5/10.
//  Copyright © 2017年 MS. All rights reserved.
//

#import "UIButton+rightAndLeft.h"

@implementation UIButton (rightAndLeft)
- (UIButton *)adjustmentButtonShowLeftAndRight{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat totleHeight = imageSize.height + titleSize.height + 5;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totleHeight-imageSize.height), (self.frame.size.width - imageSize.width)/2 - 5, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(self.frame.size.width - titleSize.width)/2 - 10, -(totleHeight-titleSize.height), 0);
    return self;
}
@end
