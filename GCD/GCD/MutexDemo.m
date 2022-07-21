//
//  MutexDemo.m
//  Lock
//
//  Created by Sun on 2020/1/19.
//  Copyright © 2020 sun. All rights reserved.
//

#import "MutexDemo.h"
#import <pthread.h>

@interface MutexDemo()
@property (nonatomic, assign) pthread_mutex_t ticketMutex;
@property (nonatomic, assign) pthread_mutex_t moneyMutex;
@end

@implementation MutexDemo

- (void)__initMutex:(pthread_mutex_t *)mutex {
    
//    // 创建属性
//    pthread_mutexattr_t attr;
//    // 初始化属性
//    pthread_mutexattr_init(&attr);
//    // 设置属性类型
//    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
//    // 初始化锁
//    pthread_mutex_init(mutex, &attr);
//    // 销毁锁
//    pthread_mutexattr_destroy(&attr);
    
    // 初始化锁, 参数传入 NULL，就相当于上面的代码
    pthread_mutex_init(mutex, NULL);

}

// 锁的初始化
- (instancetype)init {
    if (self = [super init]) {
        [self __initMutex:&_ticketMutex];
        [self __initMutex:&_moneyMutex];
    }
    return self;
}

// 卖票代码加锁
- (void)__saleTicket {
    pthread_mutex_lock(&_ticketMutex);
    [super __saleTicket];
    pthread_mutex_unlock(&_ticketMutex);
}

// 存钱代码加锁
- (void)__saveMoney {
    pthread_mutex_lock(&_moneyMutex);
    [super __saveMoney];
    pthread_mutex_unlock(&_moneyMutex);
}

// 取钱代码加锁
- (void)__drawMoney {
    pthread_mutex_lock(&_moneyMutex);
    [super __drawMoney];
    pthread_mutex_unlock(&_moneyMutex);
}

// 锁需要销毁
- (void)dealloc {
    pthread_mutex_destroy(&_moneyMutex);
    pthread_mutex_destroy(&_ticketMutex);
}

@end
