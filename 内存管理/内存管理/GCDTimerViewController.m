//
//  GCDTimerViewController.m
//  内存管理
//
//  Created by app on 2022/7/22.
//

#import "GCDTimerViewController.h"
#import "GCDTimer.h"
@interface GCDTimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation GCDTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __block int num = 60;
    NSString *timerKey = [NSString stringWithFormat:@"beck.wang.timer"];
    
    [[GCDTimer sharedInstance]scheduleGCDTimerWithName:timerKey interval:1 queue:dispatch_get_main_queue() repeats:YES option:CancelPreviousTimerAction action:^{
        NSLog(@"1");
        num--;
        self.label.text = [NSString stringWithFormat:@"%d",num];
    }];
}



@end
