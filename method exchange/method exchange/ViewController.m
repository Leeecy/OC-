//
//  ViewController.m
//  method exchange
//
//  Created by app on 2022/7/18.
//

#import "ViewController.h"
#import "son.h"
@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    son *s = [[son alloc]init];
    [s eat];
    
    Father * f = [Father new];
    [f eat];
    NSArray *arr = @[@"1",@"2",@"3"];

    NSLog(@"%@",[arr objectAtIndex:4]);
//    NSArray *commonArr = [NSArray alloc];
//       NSArray *arr01 = [commonArr init];
//       NSArray *arr02 = [commonArr initWithObjects:@"1", nil];
//       NSArray *arr03 = [commonArr initWithObjects:@"1", @"2", nil];
//       NSArray *arr04 = [commonArr initWithObjects:@"1", @"2", @"3", nil];
//       NSLog(@"commonArr: %s", object_getClassName(commonArr));
//       NSLog(@"arr01: %s", object_getClassName(arr01));
//       NSLog(@"arr02: %s", object_getClassName(arr02));
//       NSLog(@"arr03: %s", object_getClassName(arr03));
//       NSLog(@"arr04: %s", object_getClassName(arr04));
    
}

- (IBAction)click1:(UIButton *)sender {
    NSLog(@"%s",__func__);
}

- (IBAction)click2:(UIButton *)sender {
    NSLog(@"%s",__func__);
}

- (IBAction)click3:(UIButton *)sender {
    NSLog(@"%s",__func__);
}
- (IBAction)segClick:(UISegmentedControl *)sender {
    NSLog(@"%s--%ld",__func__,sender.tag);
}

@end
