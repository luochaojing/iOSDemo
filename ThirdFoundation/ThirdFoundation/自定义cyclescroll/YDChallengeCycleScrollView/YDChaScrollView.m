//
//  YDScrollView.m
//  ThirdFoundation
//
//  Created by Luo on 2017/8/5.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "YDChaScrollView.h"
#import "YDChaPageControl.h"
#import "YDChaImageCollectionViewCell.h"


static NSString *kYDCollectionCell_reuse_id = @"yd.collection.cell.reuse.id";
static const NSInteger kMultiple = 1000;
static const NSTimeInterval kDefaultAutoScrollTimerInterval = 2.0;

@interface YDChaScrollView()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *baseCollectionView;
@property (strong, nonatomic) NSTimer *timer;


//真实的个数
@property (strong, nonatomic) YDChaPageControl *pageControl;

//模仿SD的，将collection的item数目变得很大（100倍）
//优点：可以重用，所以并不会有额外的开销
//优点：将倍数设置成100倍，几乎可以排除用户连续滚动的情况（不停顿）,增大也几乎不会有额外的开销
//缺点：100的倍数依然存在着被拖到的可能
//缺点：定时器，不断的重复销毁和生成（如何改进定时器暂停或者不调用，加个判断会不能立马启动）
@property (assign, nonatomic) NSInteger totalItemCount;
@property (assign, nonatomic) NSInteger currentItemIndex;

@property (assign, nonatomic) NSInteger realItemCount;
@property (assign, nonatomic) NSInteger realCurrentIndex;

//功能

@end

@implementation YDChaScrollView


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
    self.backgroundColor = [UIColor grayColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
    self.baseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.baseCollectionView.delegate = self;
    self.baseCollectionView.dataSource = self;
    [self.baseCollectionView registerClass:[YDChaImageCollectionViewCell class] forCellWithReuseIdentifier:kYDCollectionCell_reuse_id];
    self.baseCollectionView.backgroundColor = [UIColor grayColor];
    self.baseCollectionView.pagingEnabled = YES;
    self.baseCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.baseCollectionView.showsVerticalScrollIndicator = NO;
    self.baseCollectionView.showsHorizontalScrollIndicator = NO;
    
    
    //初始化
    self.pageControl = [[YDChaPageControl alloc] init];
    self.pageControl.selectedBtnWid = 16;
    self.pageControl.normalBtnWid = 8;
    self.pageControl.btnSpace = 12;
    self.pageControl.normalColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1];
    self.pageControl.selectedColor = [UIColor colorWithRed:17.0/255.0 green:213.0/255.0 blue:156.0/255.0 alpha:1];
    self.autoScrollTimeInterval = 0;
    
    [self addSubview:self.baseCollectionView];
    [self addSubview:self.pageControl];
}


- (void)makeConstra
{
    [self.baseCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.width.equalTo(@200);
        make.height.equalTo(@8);
    }];
}


#pragma mark - collection

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalItemCount;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YDChaImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kYDCollectionCell_reuse_id forIndexPath:indexPath];
    
    NSInteger imageIndex = indexPath.item % self.realItemCount;
    
    if (imageIndex < self.urlArray.count) {

        NSString *imageURL = self.urlArray[imageIndex];
        [cell.imgView setImageWithURL:[NSURL URLWithString:imageURL] placeholder:self.placeholderImg];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
                   minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger realIndex = indexPath.item%self.realItemCount;
    if ([self.ydScrollDelegate respondsToSelector:@selector(ydScrollView:didSelectIndex:)]) {
        
        [self.ydScrollDelegate ydScrollView:self didSelectIndex:realIndex];
    }
}



#pragma mark - <<<<<<<<<<


#pragma mark - scrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //[self setupTimer];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGPoint point = scrollView.contentOffset;
    CGFloat x = point.x;
    
    //这里可以再优化一下，将滚动到一半的时候再设置
    
    NSInteger index = x/scrollView.frame.size.width;
    self.currentItemIndex = index;
    self.realCurrentIndex = index % self.urlArray.count;
    //NSLog(@"准备设置index");
    //这里调用多次的话会有问题
    self.pageControl.currentIndex = self.realCurrentIndex;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollToMiddleWithCurrentIndex:self.realCurrentIndex];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self setupTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invalidateTimer];
}


#pragma mark - 属性

- (UIImage *)placeholderImg
{
    if (_placeholderImg == nil) {
        _placeholderImg = [UIImage imageNamed:@"img_challenge_card_place.png"];
    }
    return _placeholderImg;
}


#pragma mark - 用户设置

- (void)setUrlArray:(NSArray<NSString *> *)urlArray
{
    _urlArray = urlArray;
    self.pageControl.count = _urlArray.count;
    self.totalItemCount = _urlArray.count * kMultiple;
    self.realItemCount = _urlArray.count;
    self.realCurrentIndex = 0;
    
    [self.baseCollectionView reloadData];

    //这里设置的有点不对
    [self setupTimer];
}


- (void)setAutoScrollTimeInterval:(NSTimeInterval)autoScrollTimeInterval
{
    if (autoScrollTimeInterval <= 0) {
        
        _autoScrollTimeInterval = kDefaultAutoScrollTimerInterval;
        return;
    }
    
    _autoScrollTimeInterval = autoScrollTimeInterval;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.realItemCount <=0 || self.totalItemCount <= 0) {
        return;
    }
    
    //在布局的时候，将collection滚到中间的位置，否则太快被两变拉倒底部
    [self.baseCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.totalItemCount / 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
}


#pragma mark - timer

- (void)setupTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(autoScrollT) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


#pragma mark - 自动滚

- (void)autoScrollT
{
    if (self.totalItemCount <=0 || self.realItemCount <= 0) {
        return;
    }
    
    
    NSInteger nextItemIndex = self.currentItemIndex + 1;
    
    //在此处判断下一个是否已经要到尽头了
    if (nextItemIndex >= self.totalItemCount) {
    
        [self scrollToMiddleWithCurrentIndex:self.realCurrentIndex];
        //算出self.currentIndex
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItemIndex inSection:0];
    
    [self.baseCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    NSLog(@"自动滚动");
}

- (void)scrollToMiddleWithCurrentIndex:(NSInteger)realCurrentIndex
{
    //滚到中间的部分+上第几个
    NSInteger item = (kMultiple / 2) * self.realItemCount + realCurrentIndex;
    
    NSIndexPath *midIndexPath = [NSIndexPath indexPathForItem:item inSection:0];
    [self.baseCollectionView scrollToItemAtIndexPath:midIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}


#pragma mark - 释放的问题

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //根据newSuperView来判断是刚创建还是销毁
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

- (void)dealloc
{
#if DEBUG
    NSLog(@"释放了");
#endif
}



@end
