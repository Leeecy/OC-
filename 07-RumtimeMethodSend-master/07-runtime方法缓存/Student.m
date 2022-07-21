//
//  Student.m
//  07-runtime方法缓存
//
//  Created by 刘光强 on 2020/2/7.
//  Copyright © 2020 guangqiang.liu. All rights reserved.
//

#import "Student.h"

@implementation Student
-(void)run{
    
    
}
-(instancetype)init{
    if (self = [super init]) {
        NSLog(@"%@",self);
        NSLog(@"%@===%p", [self class],[self class]);//Student
        NSLog(@"%@", [super class]);//Student
        NSLog(@"%@", [self superclass]);//Person
        NSLog(@"%@", [super superclass]);//Person
//        [super run];
//        id cls = [self class];
//        void *obj = &cls;
    }
    return  self;
}

- (void)studentTest {
    NSLog(@"%s", __func__);
}
-(void)read{
    NSLog(@"%s", __func__);
}
@end
