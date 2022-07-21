//
//  MutexDemo4.m
//  Lock
//
//  Created by Sun on 2020/1/22.
//  Copyright © 2020 sun. All rights reserved.
//

#import "MutexDemo4.h"
#import <pthread.h>

/**
 条件锁
 */
@interface MutexDemo4()
// 锁
@property (nonatomic, assign) pthread_mutex_t mutex;
// 条件
@property (nonatomic, assign) pthread_cond_t cond;
// 数组
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation MutexDemo4

- (instancetype)init {
    if (self = [super init]) {
        // 锁的属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        // 锁的初始化
        pthread_mutex_init(&_mutex, &attr);
        // 销毁锁的属性
        pthread_mutexattr_destroy(&attr);
        // 条件的初始化
        pthread_cond_init(&_cond, NULL);
        // 数组的初始化
        self.data = [NSMutableArray array];
    }
    return self;
}

// 两条线程同时进入，先执行哪一个线程中的方法都是有可能的
- (void)otherTest {
    // 创建线程，在线程中执行方法__remove
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];
    // 创建线程，在线程中执行方法__add
    [[[NSThread alloc] initWithTarget:self selector:@selector(__add) object:nil] start];
}

// 删除数组中元素
- (void)__remove {
    // 加锁
    pthread_mutex_lock(&_mutex);
    NSLog(@"begin");
    // 如果数组中元素个数是0
    if (self.data.count == 0) {
        // 线程休眠，等待用条件唤醒，暂时解锁
        pthread_cond_wait(&_cond, &_mutex);
    }
    
    // 线程被唤醒，加锁，继续执行代码，移出元素
    [self.data removeLastObject];
    NSLog(@"删除了元素");
    // 解锁
    pthread_mutex_unlock(&_mutex);
}

- (void)__add {
    // 加锁
    pthread_mutex_lock(&_mutex);
    // 睡眠一秒钟
    sleep(1);
    // 添加元素
    [self.data addObject:@"Test"];
    NSLog(@"添加了元素");
    /**
     如下两行代码，可以互换
     如果signal在前，就需要等带下一行代码的解锁，休眠的线程才能真正做事情
     如果解锁代码在前，那么发出信号之后，休眠的线程可以立马做事情
     */
    // 用条件_cond发出线程唤醒信号, 解锁代码
    pthread_cond_signal(&_cond);
    // 解锁
    pthread_mutex_unlock(&_mutex);
}

// 销毁锁，销毁条件
- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_cond);
}
@end
