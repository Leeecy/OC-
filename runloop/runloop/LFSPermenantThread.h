//
//  LFSPermenantThread.h
//  runloop
//
//  Created by app on 2022/7/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LFSPermenantThreadTask)(void);
@interface LFSPermenantThread : NSObject
/**
 在当前子线程执行一个任务
 */
- (void)executeTask:(LFSPermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;
@end

NS_ASSUME_NONNULL_END
