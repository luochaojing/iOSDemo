//
//  TimerViewController.h
//  ThirdFoundation
//
//  Created by Luo on 2017/7/26.
//  Copyright © 2017年 yuedongquan. All rights reserved.
//

#import <UIKit/UIKit.h>




/**
 1、在tableview滑动下的runloop mode为tracking，不接受timer的事件，所以不会卡
 2、在timer的回调耗时间比较久的话，在pop会明显的卡顿，如果只是短暂的函数不明显
 3、多个timer的情况，待研究
 4、如何改变主线程的runloop mode？readonly。runtime的方法是否可行，后果是什么？
 5、如何解决pop手势的卡顿，是否减少timer的回调函数的执行时间就可以了？
 6、在悦动圈寻宝里将三个定时器销毁也是会卡，将定时器的回调函数直接return还是会卡，应该有其他的输入源
 7、虽然未找到原因，但是timer的回调还是应该尽量短。可以用子线程减少卡顿。
 8、悦动圈的卡顿暂时判断在viewwillappear几个函数的原因
 9、不过为啥底部的滚动视图有时候也会卡呢？
 10、一般的在主线程插入的函数都运行时间很少，怀疑是由于CA动画引起的
 11、延伸出来的问题：UIView动画会在pop手势的时候复原或者暂停的解决方案？
 */
@interface TimerViewController : UIViewController

@end
