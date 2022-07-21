//
//  NSConditionDemo.m
//  Lock
//
//  Created by Sun on 2020/1/22.
//  Copyright © 2020 sun. All rights reserved.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo()
// 条件
@property (nonatomic, strong) NSCondition *condition;
// 数组
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation NSConditionDemo

// 初始化数组和条件
- (instancetype)init {
    if (self = [super init]) {
        self.condition = [[NSCondition alloc] init];
        self.data = [NSMutableArray array];
    }
    return self;
}

// 两个线程中执行不同方法
- (void)otherTest {
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__add) object:nil] start];
}

// 删除数组中元素
- (void)__remove {
    // 加锁
    [self.condition lock];
    NSLog(@"begin");
    
    if (self.data.count == 0) {
        // 休眠，等待唤醒
        [self.condition wait];
    }
    [self.data removeLastObject];
    NSLog(@"删除了元素");
    // 解锁
    [self.condition unlock];
}

// 添加数组中元素
- (void)__add {
    // 加锁
    [self.condition lock];
    // 睡眠
    sleep(1);
    [self.data addObject:@"Test"];
    NSLog(@"添加了元素");
    // 如果线程在睡眠，则唤醒
//    [self.condition signal];
    [self.condition broadcast];
    
    [self.condition unlock];
}

@end
