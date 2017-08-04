//
//  YDChaPageControl.h
//  SportsBar
//
//  Created by Luo on 2017/8/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@class YDChaPageControl;

@protocol YDChaPageControlDelegate <NSObject>

- (void)chaPageControl:(YDChaPageControl *)pageControl didSelectedIndex:(NSInteger)index;

@end



/**
 如何让动画配合外部的调用
 */
@interface YDChaPageControl : UIView

@property (strong, nonatomic) UIColor *normalColor;

@property (strong, nonatomic) UIColor *selectedColor;

@property (assign, nonatomic) NSInteger currentIndex;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, weak) id<YDChaPageControlDelegate> delegate;


- (void)addTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents;



@end
NS_ASSUME_NONNULL_END
