//
//  SBaseDemo.m
//  Lock
//
//  Created by Sun on 2020/1/19.
//  Copyright © 2020 sun. All rights reserved.
//

#import "SBaseDemo.h"

#import "SBaseDemo.h"
//#import <libkern/OSAtomic.h>

@interface SBaseDemo()

@property (nonatomic, assign) int money;
@property (nonatomic, assign) int ticketsCount;

@end

@implementation SBaseDemo

/**
 举例1：存取钱演示
 */
- (void)moneyTest {
    // 本来有100万
    self.money = 0;
    // 全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 全局队列；不阻塞；新的子线程
    // 存钱
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __saveMoney];
        }
    });
    // 全局队列；不阻塞；新的子线程
    // 取钱
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __drawMoney];
        }
    });
}

/**
 存钱
 */
- (void)__saveMoney {

    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50;
    self.money = oldMoney;
    NSLog(@"存了50元，剩余%d钱, 线程在 %@", _money, [NSThread currentThread]);
  
}
/**
 取钱
 */
- (void)__drawMoney {
    
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 50;
    self.money = oldMoney;
    NSLog(@"取了50元，剩余%d钱, 线程在 %@", _money, [NSThread currentThread]);
}

/**
  举例2：买票演示
 */
- (void)ticketTest {
    // 原来一共有15张票
    self.ticketsCount = 15;
    // 全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //10条线程测试汇编锁的细节
//    for (int i = 0; i<10; i++) {
//        [[[NSThread alloc]initWithTarget:self selector:@selector(__saleTicket) object:nil]start];
//    }
    // 全局队列；不阻塞；新的子线程
    // 子线程卖票5张
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
    // 子线程卖票5张
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
    // 子线程卖票5张
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
}

/**
 卖一张票
 */
- (void)__saleTicket {
    
    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;
    NSLog(@"剩余%d张票, 线程在 %@", oldTicketsCount, [NSThread currentThread]);
}

@end

