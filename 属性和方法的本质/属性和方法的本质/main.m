//
//  main.m
//  属性和方法的本质
//
//  Created by cl on 2022/6/8.
//
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

/**
 1、方法不会放在实例对象里面
 
 一个方法可以被一个对象的多个实例调用
 
 但是成员变量可以是不同的值
 */

//person
//本质

struct NSObject_IMPL{
    Class isa;
};

struct CPerson_IMPL{
    struct NSObject_IMPL NSOBJECT_IVARS;//8个字节
    int _age; //4个字节
    int _height; //4个字节
};

@interface Person : NSObject{
    @public
    int _age;
    int _height;
}

//@property (nonatomic, assign) int height;
@end

@implementation Person


@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        
//        Person *per = [[Person alloc]init];
//        [per setHeight:10];
//        [per height];
//        per->_age = 10;
//
//
//        Person *per2 = [[Person alloc]init];
//        [per2 setHeight:20];
//        per2->_age = 20;
//
//        Person *per3 = [[Person alloc]init];
//        [per3 setHeight:30];
//        per3->_age = 30;
        
        
        Person *per = [[Person alloc]init];
        
        //打印下地址 0x6000033241d0
        
        //class_getInstanceSize 实际的大小
        //malloc_size 系统分配的大小 16的倍数
        
        NSLog(@"%zd---%zd",class_getInstanceSize([Person class]),malloc_size((__bridge const void*)(per))); //16  16
        
    }
    return 0;
}
