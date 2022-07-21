//
//  MutexDemo2.m
//  Lock
//
//  Created by Sun on 2020/1/21.
//  Copyright © 2020 sun. All rights reserved.
//

#import "MutexDemo2.h"
#import <pthread.h>

/**
 A方法调用方法B, 在A解锁之前B再次加同一个锁，
 会导致死锁。B方法会一致占用线程，等待锁被解开
 解决方案：让 otherTest2 使用新的锁
 */
@interface MutexDemo2()
// 锁1
@property (assign, nonatomic) pthread_mutex_t mutex;
// 锁2
@property (assign, nonatomic) pthread_mutex_t mutex2;
@end

@implementation MutexDemo2

// 初始化锁
- (void)__initMutex:(pthread_mutex_t *)mutex {
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
        pthread_mutex_init(mutex, &attr);
    pthread_mutexattr_destroy(&attr);
}

- (instancetype)init {
    if (self = [super init]) {
        [self __initMutex:&_mutex];
        [self __initMutex:&_mutex2];
    }
    return self;
}

- (void)otherTest {
    // 加锁
    pthread_mutex_lock(&_mutex);
    NSLog(@"otherTest");
    
    // 调用otherTest2
    static int count = 0;
    if (count < 10) {
        count++;
        /**
         调用 otherTest2 时候，otherTest2 要加锁，但是代码已经被加锁，只能等待锁被解开，就一直等待,但是解锁代码又在后面，所以造成死锁
         这种死锁可以让 otherTest2 使用新的锁来解决
         */
        [self otherTest2];
    }
    // 解锁
    pthread_mutex_unlock(&_mutex);
}

- (void)otherTest2 {
    // 加锁
    pthread_mutex_lock(&_mutex2);
    NSLog(@"otherTest2");
    // 解锁
    pthread_mutex_unlock(&_mutex2);
}

- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
}

@end
