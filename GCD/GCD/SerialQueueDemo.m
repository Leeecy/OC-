//
//  SerialQueueDemo.m
//  Lock
//
//  Created by Sun on 2020/1/23.
//  Copyright © 2020 sun. All rights reserved.
//

#import "SerialQueueDemo.h"

/**
 使用串行队列（sync），实现两段代码不可以同时执行
 使用串行队列（sync），实现一段代码不可以同时执行
 */
@interface SerialQueueDemo()
// 卖票的队列
@property (nonatomic, strong) dispatch_queue_t ticketQueue;
// 存取钱的队列
@property (nonatomic, strong) dispatch_queue_t moneyQueue;
@end

@implementation SerialQueueDemo

- (instancetype)init {
    if (self = [super init]) {
        // 创建卖票的串行队列
        self.ticketQueue = dispatch_queue_create("ticketQueue", DISPATCH_QUEUE_SERIAL);
        // 创建存取钱的串行队列
        self.moneyQueue = dispatch_queue_create("moneyQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)__drawMoney {
    // 在存取钱的串行队列中添加取钱任务
    dispatch_sync(self.moneyQueue, ^{
        [super __drawMoney];
    });
}

- (void)__saveMoney {
    // 在存取钱的串行队列中添加存钱任务
    dispatch_sync(self.moneyQueue, ^{
        [super __saveMoney];
    });
}

- (void)__saleTicket {
    // 在卖票的串行队列中添加卖票任务
    dispatch_sync(self.ticketQueue, ^{
        [super __saleTicket];
    });
}
@end
