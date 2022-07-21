//
//  OSUnfairLockDemo.m
//  Lock
//
//  Created by Sun on 2020/1/19.
//  Copyright © 2020 sun. All rights reserved.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

/**
 等待 os_unfair_lock 锁的线程会处于休眠状态
 */
@interface OSUnfairLockDemo()

@property (nonatomic, assign) os_unfair_lock moneyLock;
@property (nonatomic, assign) os_unfair_lock ticketLock;

@end

@implementation OSUnfairLockDemo

- (instancetype)init {
    if (self = [super init]) {
        // 初始化锁
        self.moneyLock = OS_UNFAIR_LOCK_INIT;
        self.ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

- (void)__saleTicket {
    // 加锁
    os_unfair_lock_lock(&_ticketLock);
    [super __saleTicket];
    // 解锁
    os_unfair_lock_unlock(&_ticketLock);
}

- (void)__saveMoney {
    // 加锁
    os_unfair_lock_lock(&_moneyLock);
    [super __saveMoney];
    // 解锁
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)__drawMoney {
    // 加锁
    os_unfair_lock_lock(&_moneyLock);
    [super __drawMoney];
    // 解锁
    os_unfair_lock_unlock(&_moneyLock);
}

@end
