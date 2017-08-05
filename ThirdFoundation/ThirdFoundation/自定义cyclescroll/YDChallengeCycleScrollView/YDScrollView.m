//
//  YDScrollView.m
//  ThirdFoundation
//
//  Created by Luo on 2017/8/5.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "YDScrollView.h"
#import "YDPageControl.h"
#import "YDImageCollectionViewCell.h"


static NSString *kYDCollectionCell_reuse_id = @"yd.collection.cell.reuse.id";

@interface YDScrollView()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *baseCollectionView;
@property (assign, nonatomic) NSInteger pageCount;
@property (strong, nonatomic) YDPageControl *pageControl;

@end

@implementation YDScrollView


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
    self.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
    self.baseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.baseCollectionView.delegate = self;
    self.baseCollectionView.dataSource = self;
    [self.baseCollectionView registerClass:[YDImageCollectionViewCell class] forCellWithReuseIdentifier:kYDCollectionCell_reuse_id];
    self.baseCollectionView.backgroundColor = [UIColor whiteColor];
    self.baseCollectionView.pagingEnabled = YES;
    self.baseCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.baseCollectionView.showsVerticalScrollIndicator = NO;
    self.baseCollectionView.showsHorizontalScrollIndicator = NO;
    
    
    self.pageControl = [[YDPageControl alloc] init];
    
    
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
        make.width.equalTo(@150);
        make.height.equalTo(@6);
    }];
}


#pragma mark - collection

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.urlArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YDImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kYDCollectionCell_reuse_id forIndexPath:indexPath];
    NSString *url = @"";
    if (indexPath.row < self.urlArray.count) {
        url = self.urlArray[indexPath.row];
    }
    [cell.imgView setImageWithURL:[NSURL URLWithString:url] placeholder:self.placeholderImg];
    
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


#pragma mark - <<<<<<<<<<


#pragma mark - scrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    CGFloat x = point.x;
    
    NSInteger index = x/scrollView.frame.size.width;
    
    NSLog(@"index = %ld", index);
    self.pageControl.currentIndex = index;
    
//    if (index == self.urlArray.count - 1) {
//        
//        [self.baseCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
//    }
    
    self.baseCollectionView.contentOffset = CGPointMake(CGRectGetWidth(self.baseCollectionView.bounds), 0);

    
}


- (void)autox
{


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
    [self.baseCollectionView reloadData];
    self.pageControl.count = _urlArray.count;
}


@end
