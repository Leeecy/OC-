//
//  ViewController.m
//  GCD
//
//  Created by app on 2022/7/20.
//

#import "ViewController.h"
#import "OSSpinLockDemo.h"
#import "OSSPinLockDemo2.h"
#import "OSUnfairLockDemo.h"
#import "NSConditionLockDemo.h"
#import "SBaseDemo.h"
#import "SemaphoreDemo.h"
#import "SerialQueueDemo.h"
#import "GroupQueue.h"

@interface ViewController ()
@property(atomic,assign)NSString *name;
@property(atomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)GroupQueue *group;
@property(nonatomic,strong)dispatch_semaphore_t semaphore;
@property(nonatomic,strong)dispatch_queue_t queue;
@end

@implementation ViewController
-(void)read{
    
    dispatch_async(self.queue, ^{
        sleep(1);
        NSLog(@"%s",__func__);
    });
    
}
-(void)write{
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_barrier_async(self.queue, ^{
        sleep(1);
        NSLog(@"%s",__func__);
    });
    
//    dispatch_semaphore_wait(self.semaphore,DISPATCH_TIME_FOREVER);
//    NSLog(@"%s",__func__);
//    dispatch_semaphore_signal(self.semaphore);
}
- (void)forNumIncrementCondition:(NSUInteger )num  actionBlock:(void(^)(int i))actionBlcok
{
    for (int a = 0; a < num; a ++)
    {
        if (actionBlcok) {
            actionBlcok(a);
        }
    }
}
- (void)concurrentQueueAsyncAndSync2BarrrierTest{
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue, ^{
        
        [self forNumIncrementCondition:5 actionBlock:^(int i) {
            NSLog(@"任务1 %d",i);
        }];
    });
    
    dispatch_async(concurrentQueue, ^{
        
        [self forNumIncrementCondition:5 actionBlock:^(int i) {
            NSLog(@"任务2 %d",i);
        }];
    });
    
    
    NSLog(@"同步栅栏 start😊");
    dispatch_barrier_sync(concurrentQueue, ^{
        
        [self forNumIncrementCondition:5 actionBlock:^(int i) {
            NSLog(@"同步栅栏, %@",[NSThread currentThread]);
        }];
    });
    NSLog(@"同步栅栏 end😊");
    
    
    dispatch_async(concurrentQueue, ^{
        [self forNumIncrementCondition:5 actionBlock:^(int i) {
            NSLog(@"任务3 %d",i);
        }];
    });
    
    dispatch_async(concurrentQueue, ^{
        
        [self forNumIncrementCondition:5 actionBlock:^(int i) {
            NSLog(@"任务4 %d",i);
        }];
    });
    
    NSLog(@"异步栅栏 start 😄");
    dispatch_barrier_async(concurrentQueue, ^{
        [self forNumIncrementCondition:5 actionBlock:^(int i) {
            NSLog(@"异步栅栏 %@",[NSThread currentThread]);
        }];
    });
    
    NSLog(@"异步栅栏 end 😄");
    
    dispatch_async(concurrentQueue, ^{
        
        [self forNumIncrementCondition:5 actionBlock:^(int i) {
            NSLog(@"任务5 %d",i);
        }];
    });
    dispatch_async(concurrentQueue, ^{
        
        [self forNumIncrementCondition:5 actionBlock:^(int i) {
            NSLog(@"任务6 %d",i);
        }];
    });
    
}
- (void)demo2 {
    
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 10000; i++) {
        dispatch_async(queue2, ^{
            NSString *url = [NSString stringWithFormat:@"%ld.png",(long)i];
            
            dispatch_barrier_async(queue2, ^{
                [mArray addObject:url];
                
            });
           
        });
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self demo2];
//    self.group = [[GroupQueue alloc]init];
//    [self.group handle];
    
    [self concurrentQueueAsyncAndSync2BarrrierTest];
    self.queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i =0; i<5; i++) {
//        [[[NSThread alloc]initWithTarget:self selector:@selector(read) object:nil]start];
//        [[[NSThread alloc]initWithTarget:self selector:@selector(write) object:nil]start];
        
//        [self read];
//        [self read];
//        [self read];
        [self write];
//        [self write];
    }
    
    self.arr = [NSMutableArray array];//这句操作set方法 加锁了 线程安全
    [self.arr addObject:@"1"];//这句不是线程安全 addObject和set方法没关系了
//    [self mainSyncTest];
    SemaphoreDemo * unfair = [[SemaphoreDemo alloc]init];
//    [unfair moneyTest];
//    [unfair ticketTest];
//    [unfair otherTest];
//    [self semaphoreTaskTest];
    
    
    // 全局队列；不阻塞；新的子线程
    // 存钱
//    dispatch_async(queue, ^{
//
//        for (int i =0; i<20; i++) {
//            [self addSum];
//        }
//
//    });
//    // 全局队列；不阻塞；新的子线程
//    // 取钱
//    dispatch_async(queue, ^{
//        for (int i =0; i<20; i++) {
//            [self addSum];
//        }
//    });
    
}
-(void)addSum{
    int a = 10;
    int b =20;
    int c = a +b;
    NSLog(@"c=%d",c);
}
/** 信号量测试 */
- (void)semaphoreTaskTest{
   
    // crate的value表示，最多几个资源可访问。
    // 这里设定的信号值为1，这样每次仅开辟一个线程空间来处理任务，无论任务耗时长短，保证一个执行完成之后再去执行另一个。
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
   //任务A
   dispatch_async(quene, ^{
       dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
       NSLog(@"任务A准备开始 - 1");
//       sleep(3);
//       NSLog(@"任务A执行结束 - 1");
       dispatch_semaphore_signal(semaphore);
   });
   //任务B
   dispatch_async(quene, ^{
       dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
       NSLog(@"任务B准备开始 - 2");
//       sleep(2);
//       NSLog(@"任B执行结束 - 2");
       dispatch_semaphore_signal(semaphore);
   });
   //任务c
//   dispatch_async(quene, ^{
//       dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//       NSLog(@"任务C准备开始 - 3");
//       sleep(4);
//       NSLog(@"任C执行结束 - 3");
//       dispatch_semaphore_signal(semaphore);
//   });
}

- (void)mainSyncTest{
    NSLog(@"0");
    // 等
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"1");
    });
    NSLog(@"2");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_queue_t queue2 = dispatch_queue_create("myqueu2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue2, ^{
        NSLog(@"1");
        [self performSelector:@selector(test2) withObject:nil afterDelay:.0];
        NSLog(@"3");
    });
}
-(void)test2{
    NSLog(@"2");
}
-(void)testAsyncMainqueue{
    NSLog(@"0");
    // 等
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"1");
        NSLog(@"3");
        NSLog(@"4");
        NSLog(@"5");
    });
    NSLog(@"2");
}
@end
