//
//  main.m
//  metaclass元类
//
//  Created by app on 2022/6/20.
//
///  元类是一个类对象的类
/**
 在运行时创建一个类只要三步：
 1、为"class pair"（类对）分配空间（使用 objc_allocateClassPair ）
 2、添加类中所需的方法和变量（这里使用 class_addMethod 添加了一个方法）
 3、注册这个类使其能够被使用（使用 objc_registerClassPair ）

 */
/**
 元类是一个类对象的类
 
 typedef struct objc_class *Class;
 struct objc_class {
     Class isa;//类的isa指针必须指向一个类结构 并且这个类结构必须包含一个方法列表使我们能够对类使用
     Class super_class;
    
 };
 */
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        defaultStringEncoding是发送消息给NSString类的
//        NSStringEncoding defaultStringEncoding = [NSString defaultStringEncoding];

        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
