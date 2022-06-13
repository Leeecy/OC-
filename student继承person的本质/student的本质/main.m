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


//struct Person_IMPL {
//    Class isa
//    int _age;
//};

//struct Student_IMPL {
//    struct Person_IMPL p;//继承的话 父类的成员变量放在前面 八个字节  内存对齐
//    int _age;
//};

// 16个字节
@interface Person : NSObject{
    @public
    int _age;//4
}
@end

@implementation Person

@end

//16个字节
@interface Student : Person{
    @public
    int _no;  //int 是四个字节
}
@end

@implementation Student

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Student *student = [[Student alloc]init];
        
        student->_no = 4;
        student->_age = 5;
     
    }
    return 0;
}
