//
//  YDChaPageControl.m
//  SportsBar
//
//  Created by Luo on 2017/8/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDChaPageControl.h"

static const NSInteger kYDPageControlMostCount = 6;
static const CGFloat kBigWid = 80;
static const CGFloat kMinWid = 30;

@interface YDChaPageControl()
{
    UIColor *_normalColor;
}

@property (strong, nonatomic) NSMutableArray *reuseBtnMuArr;
@property (strong, nonatomic) NSMutableArray *validBtnMuArr;

//动画保护机制
@property (assign, nonatomic) BOOL isFinished;

@end

@implementation YDChaPageControl


@synthesize normalColor = _normalColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self comInit];
        [self makeConstra];
        
        
        
    }
    
    return self;
}


- (void)comInit
{
    self.backgroundColor = [UIColor clearColor];
    self.reuseBtnMuArr = [[NSMutableArray alloc] init];
    self.isFinished = YES;
    
    self.normalColor = [UIColor grayColor];
    self.selectedColor = [UIColor colorWithRed:17.0/255.0 green:213.0/255.0 blue:156.0/255.0 alpha:1];
    
    for (int i = 0; i < kYDPageControlMostCount; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [self.reuseBtnMuArr addObject:btn];
   //  [btn addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>]
    }
}




- (void)makeConstra
{
    for (int i = 0; i < self.reuseBtnMuArr.count; i++) {
        
        UIButton *btn = self.reuseBtnMuArr[i];
        btn.layer.cornerRadius = kMinWid / 2;
        btn.layer.masksToBounds = YES;
        
        
        
        if (i == 0) {
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.bottom.top.equalTo(self);
                make.width.mas_greaterThanOrEqualTo(kMinWid);
                make.width.mas_equalTo(kBigWid);
                
            }];
            
            [btn setBackgroundColor:self.selectedColor];
        
        }
        
        else{
        
            UIButton *lastBtn = self.reuseBtnMuArr[i - 1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.equalTo(lastBtn.mas_right).offset(20);
                make.top.bottom.equalTo(self);
                make.width.mas_greaterThanOrEqualTo(kMinWid);

            }];
            
            [btn setBackgroundColor:self.normalColor];
        }
        
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setCount:(NSInteger)count
{
//    if (_count != count) {
//        
//        _count = count;
//        [self.validBtnMuArr removeAllObjects];//直接增减是否会好点
//        for (int i = 0; i < _count; i++) {
//            
//            UIButton *btn = [self.reuseBtnMuArr objectAtIndex:i];
//            
//            
//        }
//    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex >= kYDPageControlMostCount || currentIndex < 0 || self.isFinished == NO) {
        return;
    }
    
    if (_currentIndex != currentIndex) {
        
        
        UIButton *btn = self.reuseBtnMuArr[currentIndex];
        [btn mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(kBigWid);
        }];
        
        UIButton *lastBtn = self.reuseBtnMuArr[self.currentIndex];
        [lastBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(kMinWid);
        }];
        
        _currentIndex = currentIndex;

        //是否需要弱引用？
        
        if ([self.delegate respondsToSelector:@selector(chaPageControl:didSelectedIndex:)]) {
            [self.delegate chaPageControl:self didSelectedIndex:_currentIndex];

        }
        
        
        self.isFinished = NO;
        __weak typeof(self) weadSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            
            [btn setBackgroundColor:self.selectedColor];
            [lastBtn setBackgroundColor:self.normalColor];
            [weadSelf layoutIfNeeded];
            
        } completion:^(BOOL finished) {
           
            weadSelf.isFinished = YES;
                NSLog(@"当前index = %ld", weadSelf.currentIndex);
        }];
        
    }
}


- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{

}


- (void)setNormalColor:(UIColor *)normalColor
{
    if (!normalColor) {
        return;
    }
    
    _normalColor = normalColor;
}

- (UIColor *)normalColor
{
    if (_normalColor == nil) {
        
        _normalColor = [UIColor whiteColor];
    }
    
    return _normalColor;
}



- (void)btnSelected:(UIButton *)button
{
    NSInteger tag = button.tag - 1000;
    self.currentIndex = tag;
}


- (void)layoutSubviews
{
    CGFloat hei = self.frame.size.height;
    for (UIButton *btn in self.reuseBtnMuArr) {
        
        btn.layer.cornerRadius = hei / 2;
        btn.layer.masksToBounds = YES;
    }
}

@end
