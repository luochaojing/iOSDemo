//
//  YDChaPageViewController.m
//  ThirdFoundation
//
//  Created by Luo on 2017/8/2.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "YDChaPageViewController.h"

#import "YDChaPageControl.h"

#import "YDChaScrollView.h"


@interface YDChaPageViewController ()<YDScrollViewDelegate>

@property (strong, nonatomic) YDChaPageControl *pageC;
@property (strong, nonatomic) YDChaScrollView *bannerView;
@property (strong, nonatomic) SDCycleScrollView *sdScroll;


@end

@implementation YDChaPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.bannerView = [[YDChaScrollView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WID, 200)];
    self.bannerView.autoScrollTimeInterval = 2;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.bannerView.urlArray = [self urlArry].copy;

    });
    
    self.bannerView.ydScrollDelegate = self;
    [self.view addSubview:self.bannerView];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    self.sdScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 400, SCREEN_WID, 200) imageURLStringsGroup:[self urlArry]];
    [self.view addSubview:self.sdScroll];
    self.sdScroll.autoScroll = NO;
    
    
    UIButton *changeIndexBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 450, 200, 40)];
    changeIndexBtn.backgroundColor = [UIColor orangeColor];
    [changeIndexBtn addTarget:self action:@selector(changeIndex) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)changeIndex
{
    static NSInteger index = 0;
    
    _pageC.currentIndex = index;
    index++;
    
    if (index >= 6) {
        index = 0;
        
    }
}


- (NSArray *)urlArry
{
    return @[@"https://o2q4lkh55.qnssl.com/407902259.jpg",
             @"https://o2q4lkh55.qnssl.com/389983521.jpg",
             @"https://o2q4lkh55.qnssl.com/394352537.jpg",
];
//
//    return @[@"https://o2q4lkh55.qnssl.com/407902259.jpg",
//             @"https://o2q4lkh55.qnssl.com/407902259.jpg",
//             @"https://o2q4lkh55.qnssl.com/407902259.jpg",
//             @"https://o2q4lkh55.qnssl.com/407902259.jpg",
//             @"https://o2q4lkh55.qnssl.com/407902259.jpg"];
}


#pragma mark - 代理

- (void)ydScrollView:(YDChaScrollView *)ydScrollView didSelectIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld张图片", index);
}

@end
