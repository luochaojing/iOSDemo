//
//  YDChaPageViewController.m
//  ThirdFoundation
//
//  Created by Luo on 2017/8/2.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "YDChaPageViewController.h"

#import "YDPageControl.h"

#import "YDScrollView.h"


@interface YDChaPageViewController ()

@property (strong, nonatomic) YDPageControl *pageC;
@property (strong, nonatomic) YDScrollView *bannerView;
@end

@implementation YDChaPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _pageC = [[YDPageControl alloc] initWithFrame:CGRectMake(10, 100, 380, 6)];
    //[self.view addSubview:_pageC];

    self.bannerView = [[YDScrollView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WID, 200)];
    self.bannerView.urlArray = [self urlArry].copy;
    [self.view addSubview:self.bannerView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    UIButton *changeIndexBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 450, 200, 40)];
    changeIndexBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:changeIndexBtn];
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
    //return @[@"https://o2q4lkh55.qnssl.com/407902259.jpg",
//             @"https://o2q4lkh55.qnssl.com/389983521.jpg",
//             @"https://o2q4lkh55.qnssl.com/394352537.jpg"];
//    
    return @[@"https://o2q4lkh55.qnssl.com/407902259.jpg",
             @"https://o2q4lkh55.qnssl.com/407902259.jpg",
             @"https://o2q4lkh55.qnssl.com/407902259.jpg",
             @"https://o2q4lkh55.qnssl.com/407902259.jpg",
             @"https://o2q4lkh55.qnssl.com/407902259.jpg"];
}

@end
