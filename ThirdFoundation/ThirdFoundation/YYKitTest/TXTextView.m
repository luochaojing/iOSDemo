//
//  TXTextView.m
//  ThirdFoundation
//
//  Created by Luo on 2017/7/19.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "TXTextView.h"


@interface TXTextView()

@property (strong, nonatomic) YYTextView *yyTextView;

@end


@implementation TXTextView


- (TXTextView *)operationSuccessBlock:(void (^)(TXTextView *, NSError *))successBlk
{
    TXTextView *tv = [[TXTextView alloc] init];
    
    __weak typeof(self) wSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        wSelf.stop = YES;
        successBlk(nil,nil);
    });
    
    
    return tv;
}




@end
