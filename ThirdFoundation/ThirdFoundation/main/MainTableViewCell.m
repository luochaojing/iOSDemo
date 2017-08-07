//
//  MainTableViewCell.m
//  ThirdFoundation
//
//  Created by Luo on 2017/8/6.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "MainTableViewCell.h"

@interface MainTableViewCell()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation MainTableViewCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView).offset(50);
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
    }
    
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title.copy;

    self.titleLabel.text = _title;
}




- (void)awakeFromNib {
    [super awakeFromNib];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
