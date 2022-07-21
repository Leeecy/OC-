//
//  LFSPermenantThread.m
//  runloop
//
//  Created by app on 2022/7/19.
//

#import "LFSPermenantThread.h"


/** MJThread **/
@interface YZThread : NSThread

@end

@implementation YZThread

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end


@interface LFSPermenantThread()

@property (strong, nonatomic) YZThread *innerThread;

@end


@implementation LFSPermenantThread

- (instancetype)init
{
    if (self = [super init]) {
        self.innerThread = [[YZThread alloc] initWithBlock:^{
            NSLog(@"begin----");
            
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext context = {0};
            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            // 销毁source
            CFRelease(source);
            // 启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            
            NSLog(@"end----");
        }];
        
        [self.innerThread start];
    }
    return self;
}

- (void)executeTask:(LFSPermenantThreadTask)task
{
    if (!self.innerThread || !task) return;
    
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop
{
    if (!self.innerThread) return;
    
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [self stop];
}

#pragma mark - private methods
- (void)__stop
{
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(LFSPermenantThreadTask)task
{
    task();
}

@end
