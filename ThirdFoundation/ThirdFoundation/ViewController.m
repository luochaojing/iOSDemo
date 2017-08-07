//
//  ViewController.m
//  ThirdFoundation
//
//  Created by Luo on 2017/7/18.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "ViewController.h"
#import "TXAttributeView.h"
#import "UserModel.h"

#import "TimerViewController.h"
#import "YDChaPageViewController.h"
#import "MainTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) TXAttributeView *txView;
@property (strong, nonatomic) TXAttributeView *txErrorView;


//data
@property (strong, nonatomic) NSArray<NSString *> *titlesArray;
@property (strong, nonatomic) NSArray<NSString *> *vcNamesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.txView = [TXAttributeView new];
//    [self.txView makeCorrectConstraint];
//    
//    
//    self.txErrorView = [TXAttributeView new];
//    [self.txErrorView makeErrorConstraint];
    
    
    //[self.view addSubview:self.txErrorView];
    //[self.view addSubview:self.txView];
    
    //[self makeContraint];
    
    [self yyModelTest];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];

    
}



- (void)makeContraint
{
    [self.txView mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.equalTo(self.view).offset(50);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);

    }];
    
    
    [self.txErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.txView.mas_bottom).offset(20);
        make.left.equalTo(self.txView);
        make.right.equalTo(self.txView);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)yyModelTest
{
    
    NSDictionary *dic= @{@"name1":@"luochao",@"name2":@"jing"};
    UserModel *user = [UserModel modelWithDictionary:dic];
    NSLog(@"user.name1 = %@",user.name1);
    NSLog(@"user.name = %@",user.name);
    
}

- (void)push{
    
    YDChaPageViewController *vc = [[YDChaPageViewController alloc] init];
    vc.title = @"自定义page";
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 表格

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

//- ()


@end
