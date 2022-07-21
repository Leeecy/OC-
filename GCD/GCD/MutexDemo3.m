//
//  MutexDemo3.m
//  Lock
//
//  Created by Sun on 2020/1/21.
//  Copyright © 2020 sun. All rights reserved.
//

#import "MutexDemo3.h"
#import <pthread.h>

/**
 使用递归锁
 */
@interface MutexDemo3()
@property (nonatomic, assign) pthread_mutex_t mutex;
@end

@implementation MutexDemo3

// 初始化锁
- (void)__initMutex:(pthread_mutex_t *)mutex {
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(mutex, &attr);
    pthread_mutexattr_destroy(&attr);
}

- (instancetype)init {
    if (self = [super init]) {
        [self __initMutex:&_mutex];
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
         递归调用 otherTest 时候，otherTest 要加锁，但是代码已经被加锁，只能等待锁被解开，就一直等待,但是解锁代码又在后面，所以造成死锁
         这种死锁不可以使用新的锁来解决，因为调用的是同一个方法
         解决方案：更改锁的类型，使用递归锁
         */
        [self otherTest];
    }
    // 解锁
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
}

@end
