//
//  TimeViewController.m
//  内存管理
//
//  Created by app on 2022/7/21.
//

#import "TimeViewController.h"
#import "TimerProxy.h"
@interface TimeViewController ()
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
//    __weak typeof(self)weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [weakSelf timerTest];
//    }];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[TimerProxy initWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
}

-(void)timerTest{
    NSLog(@"%s",__func__);
}

-(void)dealloc{
    [self.timer invalidate];
}

@end
