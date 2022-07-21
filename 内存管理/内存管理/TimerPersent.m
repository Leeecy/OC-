//
//  TimerPersent.m
//  内存管理-定时器
//
//  Created by liuyaozong on 2022/1/25.
//

#import "TimerPersent.h"

@implementation TimerPersent
+(instancetype)initWithObject:(NSObject *)obj {
    TimerPersent *persent = [[TimerPersent alloc] init];
    persent.target = obj;
    return  persent;
}
//消息转发. 让传进来的 target去响应
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return  self.target;
}
@end
