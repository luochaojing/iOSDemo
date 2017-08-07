//
//  YDScrollView.h
//  ThirdFoundation
//
//  Created by Luo on 2017/8/5.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDChaScrollView;

@protocol YDScrollViewDelegate <NSObject>

//点击
- (void)ydScrollView:(YDChaScrollView *)ydScrollView didSelectIndex:(NSInteger)index;

@end


@interface YDChaScrollView : UIView

//data
@property (strong, nonatomic) UIImage *placeholderImg;
@property (strong, nonatomic) NSArray<UIImage *> *imgeArray;
@property (strong, nonatomic) NSArray<NSString *> *urlArray;

//config
@property (assign, nonatomic) NSTimeInterval autoScrollAble;//是否自动滚动
@property (assign, nonatomic) NSTimeInterval autoScrollTimeInterval;//自动滚动的时间

@property (strong, nonatomic) UIColor *pageControlSelectedColor;
@property (strong, nonatomic) UIColor *pageControlNormalColor;

@property (assign, nonatomic) CGFloat pageControlHeight;//高度，会自适应圆角

@property (weak, nonatomic) id<YDScrollViewDelegate> ydScrollDelegate;

@end
