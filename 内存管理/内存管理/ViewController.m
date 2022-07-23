//
//  ViewController.m
//  内存管理
//
//  Created by app on 2022/7/21.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,copy)NSMutableString *name;
@property(nonatomic,strong)NSMutableString *age;
@end

@implementation ViewController
// 如果是iOS平台（指针的最高有效位是1，就是Tagged Pointer）
#   define _OBJC_TAG_MASK (1UL<<63)

// 如果是Mac平台（指针的最低有效位是1，就是Tagged Pointer）
#   define _OBJC_TAG_MASK 1UL

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self.name mutableCopy]
    self.name = [NSMutableString stringWithFormat:@"asdaasfffafd"];
    self.age = @"age";
    NSString *str  = [self.name copy];
    
    NSMutableString *s2 = [NSMutableString stringWithFormat:@"asdaasfffafd"];
    NSMutableString *s3 = [s2 copy];
//    [s3 appendString:@"ass"];
    NSLog(@"s3 %p %p", s2, s3);
    NSMutableString *age  = [self.age copy];
    NSLog(@"name %p %p", self.name, str);
    NSLog(@"%p %p", self.age, age);
    
    

    
//    [str appendString:@"22"];
  
}

-(void)testTagPoint{
    NSMutableString *mutableStr = [NSMutableString string];
        NSString *immutable = nil;
        #define _OBJC_TAG_MASK (1UL<<63)
        char c = 'a';
        do {
            [mutableStr appendFormat:@"%c", c++];
            immutable = [mutableStr copy];
            NSLog(@"%p %@ %@", immutable, immutable, immutable.class);
        }while(((uintptr_t)immutable & _OBJC_TAG_MASK) == _OBJC_TAG_MASK);
    
    NSNumber *number1 = @(0x11111111);
        NSNumber *number2 = @(0x20);
        NSNumber *number3 = @(0x3F);
        NSNumber *numberFFFF = @(0xFFFFFFFFFFEFE);
        NSNumber *maxNum = @(MAXFLOAT);
        NSLog(@"number1 pointer is %p class is %@", number1, number1.class);
        NSLog(@"number2 pointer is %p class is %@", number2, number2.class);
        NSLog(@"number3 pointer is %p class is %@", number3, number3.class);
        NSLog(@"numberffff pointer is %p class is %@", numberFFFF, numberFFFF.class);
        NSLog(@"maxNum pointer is %p class is %@", maxNum, maxNum.class);
    
    NSLog(@"%d %d %d", [self isTaggedPointer:number1], [self isTaggedPointer:number2], [self isTaggedPointer:number3]);
       NSLog(@"%p %p %p", number1, number2, number3);
    NSString *str1 = [NSString stringWithFormat:@"asdhjshdaadsd"];
    NSString *str2 = [NSString stringWithFormat:@"abc"];
    NSLog(@" pointer is %p==%p", str1,str2);
    //    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //
    //    for (int i =0 ; i<1000; i++) {
    //        dispatch_async(queue, ^{
    //            self.name = [NSString stringWithFormat:@"asdhjshdaadsd"];
    //        });
    //    }
    //
}

- (BOOL)isTaggedPointer:(id)pointer {
    return ((uintptr_t)pointer & _OBJC_TAG_MASK) == _OBJC_TAG_MASK;
}

@end
