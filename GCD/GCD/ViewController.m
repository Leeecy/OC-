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
@property(nonatomic,assign)int num;
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
-(void)read2{
    NSLog(@"read2");
}
-(void)asyncMain{
    dispatch_queue_t q1 = dispatch_get_main_queue();
    // 2. 安排一个任务
    for  ( int  i = 0; i<10; i++) {
         dispatch_async(q1, ^{
             NSLog (@ "%@ %d" , [ NSThread  currentThread], i);
         });
    }
    [ NSThread  sleepForTimeInterval:1.0];
    NSLog (@ "睡会" );
    [ NSThread  sleepForTimeInterval:2.0];
    NSLog (@ "come here" );
}
-(void)concureentAsync{
    dispatch_queue_t q = dispatch_queue_create( "dantesx" , DISPATCH_QUEUE_CONCURRENT );
    for  ( int  i = 0; i<100; i++) {

//        NSLog(@"%d",i);
        
//        [[[NSThread alloc]initWithTarget:self selector:@selector(read2) object:nil]start];
        
//        dispatch_queue_t q = dispatch_queue_create( "dantesx" , DISPATCH_QUEUE_CONCURRENT );

         dispatch_async(q, ^{
             NSLog (@ "%@ %d" , [ NSThread  currentThread], i);
         });
    }
    [NSThread sleepForTimeInterval:0.001];
    NSLog (@ "come here %@", [NSThread  currentThread]);
    
    
    NSLog(@"1");

    //异步并发
    dispatch_async( q, ^{
        NSLog(@"2,%@",[NSThread currentThread]);
        NSLog(@"3,%@",[NSThread currentThread]);
    });
    dispatch_async( q, ^{
        NSLog(@"4,%@",[NSThread currentThread]);
        NSLog(@"5,%@",[NSThread currentThread]);
    });
    NSLog(@"6");
    
}
-(void)sub{
    int a = self.num;
    sleep(.2);
    a -= 10;
    self.num = a;
    NSLog(@"sub之后%d",self.num);
}
-(void)add{
    int a = self.num;
    sleep(.2);
    int b = a + 10;
    self.num = b;
    NSLog(@"add之后%d",self.num);
}
-(void)semaphoreT{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
    
    // 1. 主队列 － 程序启动之后已经存在主线程，主队列同样存在
  
    //异步主队列
//    [self asyncMain];
    
    //并发队列异步
//    [self concureentAsync];
   
//    [self demo2];
//    self.group = [[GroupQueue alloc]init];
//    [self.group handle];
    
    
    self.num = 20;
    dispatch_semaphore_t t1 = dispatch_semaphore_create(3);
    //信号量测试

//    dispatch_semaphore_wait(t1, DISPATCH_TIME_FOREVER);
//    dispatch_async(self.queue, ^{
//        for (int i = 0; i<8; i++) {
//            [self sub];
////            [self semaphoreT];
//        }
//    });
//    dispatch_semaphore_signal(t1);
    
    for (NSInteger i = 0; i < 9; i++) {
            
            dispatch_async(self.queue, ^{
                //当信号量为0时候，阻塞当前线程
                dispatch_semaphore_wait(t1, DISPATCH_TIME_FOREVER);
                NSLog(@"执行任务 %ld", i);
                sleep(1);
                NSLog(@"完成当前任务 %ld", i);
                //释放信号
                dispatch_semaphore_signal(t1);
            });
        }
    
//    dispatch_semaphore_wait(t1, DISPATCH_TIME_FOREVER);
//    dispatch_async(self.queue, ^{
//        for (int i = 0; i<8; i++) {
//            [self add];
//        }
//    });
//    dispatch_semaphore_signal(t1);
    
    
    //栅栏函数测试
//    [self concurrentQueueAsyncAndSync2BarrrierTest];
    
    //测试读写
//    [self testWriteRead];
    
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
-(void)testWriteRead{
    for (int i =0; i<5; i++) {
//        [[[NSThread alloc]initWithTarget:self selector:@selector(read) object:nil]start];
//        [[[NSThread alloc]initWithTarget:self selector:@selector(write) object:nil]start];
        
//        [self read];
//        [self read];
//        [self read];
        [self write];
//        [self write];
    }
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
