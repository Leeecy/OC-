//
//  main.m
//  class对象
//
//  Created by cl on 2022/6/12.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSObject *obj = [[NSObject alloc]init];
        NSObject *obj2 = [[NSObject alloc]init];

        Class objectClass1 = [obj class];
        Class objectClass2 = [obj2 class];
        
        Class objectClass3 = object_getClass(obj);

        // 指向同一个地址 nsobject的class对象
        NSLog(@"%p %p %p",objectClass1,objectClass2,objectClass3);
        NSLog(@"Hello, World!");
    }
    return 0;
}
