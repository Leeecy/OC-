//
//  SemaphoreDemo.m
//  Lock
//
//  Created by Sun on 2020/1/24.
//  Copyright © 2020 sun. All rights reserved.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo()
// 信号量
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
// 卖票的信号量
@property (nonatomic, strong) dispatch_semaphore_t ticketSemaphore;
// 存取钱的信号量
@property (nonatomic, strong) dispatch_semaphore_t moneySemaphore;

@end
@implementation SemaphoreDemo
// 信号量的初始化，设置初始值
- (instancetype)init {
    if (self = [super init]) {
        self.semaphore = dispatch_semaphore_create(5);
        self.ticketSemaphore = dispatch_semaphore_create(1);
        self.moneySemaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)__drawMoney {
    // 信号量的值 <= 0, 线程进入休眠，等待信号量的值 > 0
    // 信号量的值 > 0, 信号量减一，继续执行代码
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    [super __drawMoney];
    // 信号量的值加一
    dispatch_semaphore_signal(self.moneySemaphore);
}

- (void)__saveMoney {
    // 根据信号量的值，判断是休眠还是继续执行代码
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    [super __saveMoney];
    // 信号量的值加一
    dispatch_semaphore_signal(self.moneySemaphore);
}

- (void)__saleTicket {
    // 根据信号量的值，判断是休眠还是继续执行代码
    dispatch_semaphore_wait(self.ticketSemaphore, DISPATCH_TIME_FOREVER);
    [super __saleTicket];
    // 信号量的值加一
    dispatch_semaphore_signal(self.ticketSemaphore);
}

- (void)otherTest {
    // 20个线程同时执行test方法
    for (int i = 0; i < 20; i++) {
        [[[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil] start];
    }
}

- (void)test {
    // 根据信号量的值，判断是休眠还是继续执行代码
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    sleep(2);
    NSLog(@"test - %@", [NSThread currentThread]);
    // 信号量的值加一
    dispatch_semaphore_signal(self.semaphore);
    NSLog(@"~~~我不知道我有没有被打印~~~~");
}


@end
