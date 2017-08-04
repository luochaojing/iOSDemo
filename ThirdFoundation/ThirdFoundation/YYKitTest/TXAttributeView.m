//
//  TXAttributeView.m
//  ThirdFoundation
//
//  Created by Luo on 2017/7/19.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "TXAttributeView.h"
#import <YYKit.h>

@interface TXAttributeView()
{
    YYLabel *_yyLabel;
    
    UIView *_bottomView;
    
    
}

@end

@implementation TXAttributeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        _yyLabel = [[YYLabel alloc] init];
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor purpleColor];
    

        _yyLabel.backgroundColor = [UIColor orangeColor];
        
        NSString *content = @"";
        
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:content];
        NSRange range = [content rangeOfString:@"1"];
        NSRange range1 = [content rangeOfString:@"首次登陆"];
        [one setFont:[UIFont boldSystemFontOfSize:20] range:range1];
        [one setColor:[UIColor blueColor] range:range];
        one.lineSpacing = 20;
        
        NSString *appendStr = @"运20元\n我我我我";
        NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:appendStr];
        [two setFont:[UIFont systemFontOfSize:12]];
        [two setColor:[UIColor yellowColor] range:[appendStr rangeOfString:@"我我"]];
        
        
        [one appendAttributedString:two];
        [one setAlignment:NSTextAlignmentCenter];
        

        [one setTextHighlightRange:NSMakeRange(3, 3) color:[UIColor redColor] backgroundColor:[UIColor orangeColor] userInfo:@{} tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"xx");
            
        } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            
            NSLog(@"YY");
        }];
 
        [_yyLabel setAttributedText:one];
        _yyLabel.numberOfLines = 0;

        
        [self addSubview:_yyLabel];
        [self addSubview:_bottomView];
        
    }
    
    return self;
}

- (void)makeErrorConstraint
{
    
    //Label高度自适应
    [_yyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self).offset(10);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_yyLabel.mas_bottom).offset(20);
        make.left.equalTo(_yyLabel.mas_left);
        make.right.equalTo(_yyLabel.mas_right);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_greaterThanOrEqualTo(SCREEN_HEI * 0.3);
    }];
    
}



- (void)makeCorrectConstraint
{
    
    [_yyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self).offset(10);
    }];
    
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_yyLabel.mas_bottom).offset(20);
        make.left.equalTo(_yyLabel.mas_left);
        make.right.equalTo(_yyLabel.mas_right);
        make.height.equalTo(@40);
        //或者这个也行
        //make.bottom.lessThanOrEqualTo(self.mas_bottom).offset(-30);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        

        make.bottom.greaterThanOrEqualTo(_bottomView.mas_bottom).offset(30);
        make.height.mas_greaterThanOrEqualTo(SCREEN_HEI * 0.3);
    }];
}
@end
