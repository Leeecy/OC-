//
//  NSConditionLockDemo.m
//  Lock
//
//  Created by Sun on 2020/1/23.
//  Copyright © 2020 sun. All rights reserved.
//

#import "NSConditionLockDemo.h"

/**
 NSConditionLock锁
 */
@interface NSConditionLockDemo()
// NSConditionLock锁
@property (nonatomic, strong) NSConditionLock *conditionLock;

@end

@implementation NSConditionLockDemo

// 锁的初始化附带条件
- (instancetype)init {
    if (self = [super init]) {
        self.conditionLock = [[NSConditionLock alloc] initWithCondition:1];
    }
    return self;
}

// 三个线程中执行三个方法
- (void)otherTest {
    [[[NSThread alloc] initWithTarget:self selector:@selector(__one) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__two) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__three) object:nil] start];
}

- (void)__one {
    // 直接加锁
    [self.conditionLock lock];
    NSLog(@"__one");
    // 解锁，条件置为2
    [self.conditionLock unlockWithCondition:2];
}

- (void)__two {
    // 当条件为2，加锁
    [self.conditionLock lockWhenCondition:2];
    NSLog(@"__two");
    sleep(1);
    // 解锁，条件置为3
    [self.conditionLock unlockWithCondition:3];
}

- (void)__three {
    // 当条件为3，加锁
    [self.conditionLock lockWhenCondition:3];
    NSLog(@"__three");
    // 解锁
    [self.conditionLock unlock];
}
@end
