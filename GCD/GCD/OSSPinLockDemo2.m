//
//  OSSPinLockDemo2.m
//  线程同步Test
//
//  Created by Sun on 2020/1/18.
//  Copyright © 2020 sun. All rights reserved.
//

#import "OSSPinLockDemo2.h"
#import <libkern/OSAtomic.h>

@implementation OSSPinLockDemo2
// 静态全局变量（其他文件不可用）
static OSSpinLock moneyLock_;

// initialize中初始化（用到该类的时候再初始化）
+ (void)initialize {
    // 让 moneyLock_ 只初始化一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        moneyLock_ = 0;
    });
}

- (void)__drawMoney {
    OSSpinLockLock(&moneyLock_);
    [super __drawMoney];
    OSSpinLockUnlock(&moneyLock_);
}

- (void)__saveMoney {
    OSSpinLockLock(&moneyLock_);
    [super __saveMoney];
    OSSpinLockUnlock(&moneyLock_);
}

- (void)__saleTicket {
    // 静态局部变量(static只会初始化一次)
    static OSSpinLock ticketLock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&ticketLock);
    [super __saleTicket];
    OSSpinLockUnlock(&ticketLock);
}
@end
