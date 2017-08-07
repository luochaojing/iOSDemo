//
//  YDChaPageControl.m
//  SportsBar
//
//  Created by Luo on 2017/8/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDChaPageControl.h"

static const NSInteger kYDPageControlMostCount = 6;
static const CGFloat kBigWid =40;
static const CGFloat kMinWid = 10;
static const CGFloat kSpace = 10;

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
    
    //初始化为默认值
    self.normalBtnWid = 0;
    self.selectedBtnWid = 0;
    self.btnSpace = 0;
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
                make.width.mas_equalTo(self.selectedBtnWid);
            }];
            
            [btn setBackgroundColor:self.selectedColor];
        
        }
        
        else{
        
            UIButton *lastBtn = self.reuseBtnMuArr[i - 1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.equalTo(lastBtn.mas_right).offset(self.btnSpace);
                make.top.bottom.equalTo(self);
                make.width.mas_equalTo(self.normalBtnWid);

            }];
            
            [btn setBackgroundColor:self.normalColor];
        }
    }
}



- (void)setCount:(NSInteger)count
{
    if (count == _count || count <= 0) {
        
        return;
    }
    
    _count = count;
    //先移除全部，后续再使用重用
    [self.reuseBtnMuArr removeAllObjects];
    [self removeAllSubviews];
    for (int i = 0; i < _count; i++) {
        
        UIButton *btn = [self normalButton];
        [self.reuseBtnMuArr addObject:btn];
        [self addSubview:btn];
    }
    [self makeConstra];

}


- (void)setCurrentIndex:(NSInteger)currentIndex
{
    self.isFinished = YES;//暂时
    if (currentIndex >= self.reuseBtnMuArr.count || currentIndex < 0 || self.isFinished == NO) {
        return;
    }
    
    if (_currentIndex != currentIndex) {
        
        UIButton *btn = self.reuseBtnMuArr[currentIndex];
        [btn mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.selectedBtnWid);
        }];
        
        UIButton *lastBtn = self.reuseBtnMuArr[self.currentIndex];
        [lastBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.normalBtnWid);
        }];
        
        _currentIndex = currentIndex;
        NSLog(@"index 设置成功");

        //是否需要弱引用？
        if ([self.delegate respondsToSelector:@selector(chaPageControl:didSelectedIndex:)]) {
            [self.delegate chaPageControl:self didSelectedIndex:_currentIndex];

        }
        
        self.isFinished = YES;//暂时不启用保护
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

- (void)btnSelected:(UIButton *)button
{
    NSInteger tag = button.tag - 1000;
    self.currentIndex = tag;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    

    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    for (UIButton *btn in self.reuseBtnMuArr) {
        
        btn.layer.cornerRadius = h / 2;
        btn.layer.masksToBounds = YES;
    }
    
    //need
    CGFloat w1 = [self maxWid];
    CGFloat x1 = x + w - w1;
    CGRect frame1 = CGRectMake(x1, y, w1, h);
    self.frame = frame1;
    
}


- (UIButton *)normalButton
{
    UIButton *btn = [[UIButton alloc] init];
    return btn;
}

- (CGFloat)maxWid
{
    return self.selectedBtnWid + (self.count - 1) * (self.normalBtnWid + self.btnSpace);
}


#pragma mark - 宽度与间距

- (void)setNormalBtnWid:(CGFloat)normalBtnWid
{
    if (normalBtnWid <= 0) {
        
        _normalBtnWid = kMinWid;
        return;
    }
    
    _normalBtnWid = normalBtnWid;
}


- (void)setSelectedBtnWid:(CGFloat)selectedBtnWid
{
    if (selectedBtnWid <= 0) {
        
        _selectedBtnWid = kBigWid;
        return;
    }
    
    _selectedBtnWid = selectedBtnWid;
}


- (void)setBtnSpace:(CGFloat)btnSpace
{
    if (btnSpace <= 0) {
        
        _btnSpace = kSpace;
        return;
    }
    
    _btnSpace = btnSpace;
}

#pragma mark - 颜色

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


@end
