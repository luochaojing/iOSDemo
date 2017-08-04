//
//  UserModel.m
//  ThirdFoundation
//
//  Created by Luo on 2017/7/26.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"name":@"name",
             @"name":@"name1",
             @"name":@"name2",
             @"name1":@"name"
             };
}


// 多生成几个和key对应的属性，取值的时候将不同的属性通过同一个返回
// 应用场景
// 在后台两个接口，一个返回invite，一个是invited，二者意思一样。
// 假如为了配合后台新建两个model的话，会比较麻烦，且很多时候整个项目都已经在使用同一个模型
// 这个方法会方便很多
// 注意的点：需要将其他的属性写在内部隐藏

- (NSString *)name
{
    if (!_name) {
        return _name;
    }
    
    if (!_name1) {
        return _name1;
    }
    return @"";
}

@end
