//
//  TXTextView.h
//  ThirdFoundation
//
//  Created by Luo on 2017/7/19.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 测试YYTextView
 */
@interface TXTextView : UIView



@property (assign, nonatomic) BOOL stop;

- (TXTextView *)operationSuccessBlock:(void(^)(TXTextView *selfView, NSError *error))successBlk;


@end
