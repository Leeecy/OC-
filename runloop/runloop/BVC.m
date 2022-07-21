//
//  BVC.m
//  runloop
//
//  Created by app on 2022/7/19.
//

#import "BVC.h"
#import "LThread.h"
#import "CLCustomThread.h"
@interface BVC ()
@property(nonatomic,strong)LThread *thred;
@property(nonatomic,assign)BOOL isStop;
@property(nonatomic,strong)CLCustomThread *thread;

@end

@implementation BVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isStop = NO;
//    self.thred =[[LThread alloc] initWithTarget:self selector:@selector(run) object:nil];
//    __weak typeof(self) weakSelf = self;
//    self.thred = [[LThread alloc]initWithBlock:^{
//        NSLog(@"begin-%s %@",__func__,[NSThread currentThread]);
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop]run];
//        NSLog(@"end-%s %@",__func__,[NSThread currentThread]);
//    }];
//    [self.thred start];
    
        self.thread = [[CLCustomThread alloc]init];
    [self.thread run];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self performSelector:@selector(test) onThread:self.thred withObject:nil waitUntilDone:NO];
//    NSLog(@"1234");
    
    [self.thread executeTask:^{
            NSLog(@"1234");
    }];
}
-(void)run{
    NSLog(@"%s %@",__func__,[NSThread currentThread]);
    
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
}
-(void)test{
    NSLog(@"%s",__func__);
}
-(void)dealloc{
    NSLog(@"%s",__func__);
//    [self.thread stop];
    
}

@end
