//
//  OSSpinLockDemo.m
//  线程同步Test
//
//  Created by Sun on 2020/1/18.
//  Copyright © 2020 sun. All rights reserved.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>
/**
 OSSpinLock叫做”自旋锁”, 等待锁的线程会处于忙等（busy-wait）状态，一直占用着CPU资源,
 所以可能造成优先级反转的问题：
 线程1优先级别高于线程2
 线程2先执行该段被锁修饰的代码，但是没有执行完毕。这时候线程1来执行该段代码，由于线程1级别高，所以CPU的资源会一直分配给线程1，此时线程2又没有解锁，造成死锁
 */

/**
 如果两个操作不能同时进行，两个操作加的锁必须是同一个；
 加锁可以阻止一段代码被再次执行的原理是：在执行该段代码的时候会判断该锁是否已经被锁，如果已经被锁, 那么就要等待，直到该锁被打开以后才能再次执行该段代码
 */

@interface OSSpinLockDemo()

@property (nonatomic, assign) OSSpinLock moneyLock;
@property (nonatomic, assign) OSSpinLock ticketLock;

@end

@implementation OSSpinLockDemo

- (instancetype)init {
    if (self = [super init]) {
        self.moneyLock = OS_SPINLOCK_INIT;
        self.ticketLock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)__drawMoney {
    OSSpinLockLock(&_moneyLock);
    [super __drawMoney];
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__saveMoney {
    OSSpinLockLock(&_moneyLock);
    [super __saveMoney];
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__saleTicket {

    /** 如果这么写，意思是如果没有加锁，那么加锁，执行代码。如果有加锁，则不再执行该段代码，继续向下执行。
     */
    //    if (OSSpinLockTry(&_lock)) {
    //        int oldTicketsCount = self.ticketsCount;
    //           sleep(.2);
    //           oldTicketsCount--;
    //           self.ticketsCount = oldTicketsCount;
    //           NSLog(@"剩余%d张票, 线程在 %@", oldTicketsCount, [NSThread currentThread]);
    //
    //           // 解锁
    //           OSSpinLockUnlock(&_lock);
    //    }
    OSSpinLockLock(&_ticketLock);
    [super __saleTicket];
    OSSpinLockUnlock(&_ticketLock);
}
@end
