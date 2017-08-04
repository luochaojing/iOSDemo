//
//  YDChaPageViewController.m
//  ThirdFoundation
//
//  Created by Luo on 2017/8/2.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "YDChaPageViewController.h"

#import "YDChaPageControl.h"

@interface YDChaPageViewController ()

@property (strong, nonatomic) YDChaPageControl *pageC;

@end

@implementation YDChaPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _pageC = [[YDChaPageControl alloc] initWithFrame:CGRectMake(10, 100, 380, 6)];
    [self.view addSubview:_pageC];
    
 
    NSURL *url = [NSURL URLWithString: @"https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=c50272d3c3cec3fd9f33af27b7e1bf5a/58ee3d6d55fbb2fb3f06d70d4f4a20a44623dc84.jpg"];
    UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    
    
    UIButton *changeIndexBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
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



@end
