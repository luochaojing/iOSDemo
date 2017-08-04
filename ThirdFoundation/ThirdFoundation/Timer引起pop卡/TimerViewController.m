//
//  TimerViewController.m
//  ThirdFoundation
//
//  Created by Luo on 2017/7/26.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()<UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>
{
    UIButton *btn;
}
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timer1;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
//    self.timer = [NSTimer timerWithTimeInterval:3 block:^(NSTimer * _Nonnull timer) {
//        [weakSelf log];
//    } repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//    
//    self.timer1 = [NSTimer timerWithTimeInterval:3 block:^(NSTimer * _Nonnull timer) {
//        [weakSelf log];
//    } repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSDefaultRunLoopMode];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hideOnPopAnimation) userInfo:nil repeats:YES];
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timer1Event) userInfo:nil repeats:YES];
    
    NSLog(@"当前runloopMode = %@",[NSRunLoop currentRunLoop].currentMode);

    //添加下面这个界面动不了
    //[[NSRunLoop currentRunLoop] run];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WID, 300) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];


    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(pushNav) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}


- (void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"viewwillAppear = %@", animated);
    NSLog(@"当前runloopMode = %@",[NSRunLoop currentRunLoop].currentMode);
    
    
    
    NSRunLoop *currentRunloop = [NSRunLoop currentRunLoop];
    //[currentRunloop setValue:UITrackingRunLoopMode forKey:@"currentMode"];

    
    
    //  取得当前类类型
    Class cls = [currentRunloop class];
    
    unsigned int ivarsCnt = 0;
    //　获取类成员变量列表，ivarsCnt为类成员数量
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        NSLog(@"变量名 = %@", key);
        //　获取变量值
        //id value = [self valueForKey:key];
        
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
        //const char *type = ivar_getTypeEncoding(ivar);
        
        
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushNav
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"第二层";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}




- (void)timer1Event
{

    sleep(1);
    NSLog(@"sleep");
}

- (void)log
{
    
    
    NSArray<UIColor *> *colorArr = @[[UIColor redColor],
                                     [UIColor blueColor],
                                     [UIColor yellowColor],
                                     [UIColor orangeColor]];
    
    static NSInteger index = 0;
    if (index >= colorArr.count) {
        
        index = 0;
    }
    
    UIColor *currentColor = colorArr[index];
    btn.backgroundColor = currentColor;
    index++;
    
    
    
    //dispatch_async(dispatch_get_main_queue(), ^{
        

    //NSLog(@"before = %@",[NSDate date]);
        for (int i = 0; i < 10; i++) {

            UIView *v = [UIView new];
        }
        //[NSThread sle]
    //});
    
    //NSLog(@"after = %@", [NSDate date]);

}


#pragma mark - 表格

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *xx = @"x";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xx];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:xx];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"当前runloopMode = %@",[NSRunLoop currentRunLoop].currentMode);
}


#pragma mark - CA动画

-(void)hideOnPopAnimation{

    
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.fromValue = @(btn.centerY);
    animation.toValue = @(btn.centerY + 200);
    animation.duration = 6;  //40
    animation.repeatCount = 0;
    animation.delegate = self;
    [btn.layer addAnimation:animation forKey:nil];
    
}


- (void)animationDidStart:(CAAnimation *)anim
{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

@end
