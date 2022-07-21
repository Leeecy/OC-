//
//  CLCustomThread.m
//  runloop
//
//  Created by app on 2022/7/19.
//

#import "CLCustomThread.h"

@interface LFSThread : NSThread

@end

@implementation LFSThread
-(void)dealloc{
    NSLog(@"%s",__func__);
}
@end

@interface CLCustomThread()
@property(nonatomic,strong)LFSThread *innerThread;
@property(nonatomic,assign)BOOL isStop;
@end

@implementation CLCustomThread
-(instancetype)init{
    if (self = [super init]) {
        self.isStop = NO;
        __weak typeof(self) weakSelf = self;
        
        self.innerThread = [[LFSThread alloc]initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.isStop) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            };
        }];
    }
    return  self;

}
-(void)executeTask:(LFSThreadTask)task{
    if (!self.innerThread || !task) return;
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}
-(void)run{
    if (!self.innerThread) return;
    [self.innerThread start];
}
-(void)stop{
    if (!self.innerThread)return;
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
    
}

-(void)dealloc{
    NSLog(@"%s", __func__);
    [self stop];
}

#pragma mark - private methods
-(void)__stop{
    self.isStop = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}
-(void)__executeTask:(LFSThreadTask)task{
    task();
}


@end
