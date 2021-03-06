//
//  YDImageCollectionViewCell.m
//  ThirdFoundation
//
//  Created by Luo on 2017/8/5.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "YDChaImageCollectionViewCell.h"


@interface YDChaImageCollectionViewCell()

@property (strong, nonatomic) UIImageView *imgView;

@end

@implementation YDChaImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor orangeColor];
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleToFill;
        self.imgView = imgView;
        
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgView];
        
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.left.bottom.right.equalTo(self);
        }];
    }
    return self;
}


@end
