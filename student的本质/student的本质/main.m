//
//  main.m
//  student的本质
//
//  Created by cl on 2022/6/7.
//


/// iOS 小端模式 高位在后面 从右往左读取数据
/// 
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

//struct NSObject_IMPL {
//    Class isa
//};


//总共16个字节 前面八个字节 isa  no 四个字节 age 四个字节 内存是连续挨着的
struct Student_IMPL {
    Class isa;//继承的话 父类的成员变量放在前面 八个字节
    int _no;
    int _age;
};

@interface Student : NSObject{
    @public
    int _no;  //int 是四个字节
    int _age;
}
@end

@implementation Student

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        
        Student *student = [[Student alloc]init];
        
        student->_no = 4;
        student->_age = 5;
        struct Student_IMPL *stu2 =(__bridge struct Student_IMPL*)student;
        
        //通过结构体也能访问student  本质就是结构体
        NSLog(@"no is %d age is %d",stu2->_no,stu2->_age);
    }
    return 0;
}
