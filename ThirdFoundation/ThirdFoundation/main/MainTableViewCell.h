//
//  MainTableViewCell.h
//  ThirdFoundation
//
//  Created by Luo on 2017/8/6.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell


@property (copy, nonatomic) NSString *title;
@property (weak, nonatomic) UIViewController *pushVC;

@end
