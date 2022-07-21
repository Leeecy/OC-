//
//  ViewController.m
//  runloop
//
//  Created by app on 2022/7/18.
//

#import "ViewController.h"
#import "LThread.h"
@interface ViewController ()
@property(nonatomic,strong)LThread *thred;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    CFRunLoopAddObserver(CFRunLoopGetMain(), <#CFRunLoopObserverRef observer#>, kCFRunLoopCommonModes);
    
    self.thred = [[LThread alloc]initWithBlock:^{
        NSLog(@"begin-%s %@",__func__,[NSThread currentThread]);
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop]run];
        NSLog(@"end-%s %@",__func__,[NSThread currentThread]);
    }];
    [self.thred start];
    
    //向线程加入perform事件
    [self performSelector:@selector(performEvent) onThread:self.thred withObject:nil waitUntilDone:YES];
    //  下面这个方法同样产生source0
    
}
- (void)performEvent {
    NSLog(@"处理Perform事件");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(test) onThread:self.thred withObject:nil waitUntilDone:NO];
    NSLog(@"1234");
    
}
-(void)test{
    NSLog(@"%s",__func__);
}
-(void)run{
    NSLog(@"%s %@",__func__,[NSThread currentThread]);
    
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
}
-(void)dealloc{
    NSLog(@"%s",__func__);
}
@end
