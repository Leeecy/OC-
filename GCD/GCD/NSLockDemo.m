//
//  NSLockDemo.m
//  Lock
//
//  Created by Sun on 2020/1/22.
//  Copyright © 2020 sun. All rights reserved.
//

#import "NSLockDemo.h"

@interface NSLockDemo()
// 买票的代码锁
@property (nonatomic, strong) NSLock *ticketLock;
// 存取钱的代码锁
@property (nonatomic, strong) NSLock *moneyLock;
@end

@implementation NSLockDemo

// 锁的初始化
- (instancetype)init {
    if (self = [super init]) {
        self.ticketLock = [[NSLock alloc] init];
        self.moneyLock = [[NSLock alloc] init];
    }
    return self;
}

// 卖票的代码加锁
- (void)__saleTicket {
    [self.ticketLock lock];
    [super __saleTicket];
    [self.ticketLock unlock];
}

// 存钱的代码加锁
- (void)__saveMoney {
    [self.moneyLock lock];
    [super __saveMoney];
    [self.moneyLock unlock];
}

// 取钱的代码加锁
- (void)__drawMoney {
        
    [self.moneyLock lock];
    [super __drawMoney];
    [self.moneyLock unlock];
}

@end
