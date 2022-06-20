//
//  main.m
//  class对象
//
//  Created by cl on 2022/6/12.
//
/**
 保存的信息
 class isa 继承来的isa指针
 类对象⾥⾯存储了类的⽗类、
 属性、实例⽅法、
 协议、
 成员变量、
 ⽅法缓存 cache等等
 */


#import <Foundation/Foundation.h>
#import <objc/runtime.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSObject *obj = [[NSObject alloc]init]; //实例对象
        NSObject *obj2 = [[NSObject alloc]init];

        Class objectClass1 = [obj class];
        Class objectClass2 = [obj2 class];
        Class objectClass4= [NSObject class];
        //获取类对象
        Class objectClass3 = object_getClass(obj);

        // 指向同一个地址 nsobject的class对象
        //class对象[23131:1019409] 0x1e23f6eb0 0x1e23f6eb0 0x1e23f6eb0 0x1e23f6eb0
        
        NSLog(@"%p %p %p %p",objectClass1,objectClass2,objectClass3,objectClass4);
        NSLog(@"Hello, World!");
    }
    return 0;
}
