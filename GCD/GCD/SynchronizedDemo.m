//
//  SynchronizedDemo.m
//  Lock
//
//  Created by Sun on 2020/1/24.
//  Copyright © 2020 sun. All rights reserved.
//

#import "SynchronizedDemo.h"

@implementation SynchronizedDemo

// 取钱
- (void)__drawMoney {
    
    @synchronized ([self class]) { // 加锁
        [super __drawMoney];
    } // 解锁
}

// 存钱
- (void)__saveMoney {
    
    @synchronized ([self class]) { // 加锁
        [super __saveMoney];
    } // 解锁
}

// 卖票
- (void)__saleTicket {
    
    static NSObject *lock;
    // 保证锁的唯一性
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = [[NSObject alloc] init];
    });
    
    @synchronized (lock) { // 加锁
        [super __saleTicket];
    } // 解锁
}

// 递归调用方法
- (void)otherTest {
    @synchronized ([self class]) {
        NSLog(@"123");
        [self otherTest];
    }
}
@end
