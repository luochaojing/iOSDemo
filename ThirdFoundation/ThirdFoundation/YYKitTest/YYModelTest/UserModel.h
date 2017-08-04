//
//  UserModel.h
//  ThirdFoundation
//
//  Created by Luo on 2017/7/26.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import <Foundation/Foundation.h>




/**
 有两个需求：
 1、一个属性对应多个key，且有优先性(已经解决)
 2、多个属性对象一个key（YYModel已经有了）
 */
@interface UserModel : NSObject

@property (copy, nonatomic) NSString *name1;
@property (copy, nonatomic) NSString *name;

@end
