//
//  TXAttributeView.h
//  ThirdFoundation
//
//  Created by Luo on 2017/7/19.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry.h>
#import <YYLabel.h>

/*
 问题：
 在UILabel自适应高度的时候，有可能被父视图的大小拉伸
 解决办法
 */
@interface TXAttributeView : UIView

- (void)makeErrorConstraint;
- (void)makeCorrectConstraint;


@end
