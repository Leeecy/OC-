//
//  main.m
//  oc对象的本质
//
//  Created by cl on 2022/6/4.
//

/***
 1、NSObject 对象、类基于c、c++的结构体实现（多种类型）
 2、生成cpp文件  clang -rewrite-objc main.m -o main.cpp
 
 3、xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o main-arm64.cpp
 生成xcode arm64文件
 
 4、底层实现
 @interface NSObject  {
 Class isa  ; //8个字节 指针 64位系统
 
 源码 至少16个字节  系统分配了16个字节给NSObject对象（通过malloc_size），内部只使用了八个字节的空间（64位环境）
 size_t instanceSize(size_t extraBytes) {
     size_t size = alignedInstanceSize() + extraBytes;
     // CF requires all objects be at least 16 bytes.
     if (size < 16) size = 16;
     return size;
 }
 
 读取内存
 (lldb) memory read 0x60000267c130
 0x60000267c130: 10 73 5c 05 01 00 00 00 00 00 00 00 00 00 00 00  .s\.............
 0x60000267c140: 40 c1 d6 ad 95 08 00 00 fb 07 00 00 00 00 00 00  @...............
 (lldb) 
 
}
 */



#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSObject *obj = [[NSObject alloc]init];
        
        //获得object实例类的对象的大小>>>>8个字节 实际isa分配了八个字节 总共16个字节
        NSLog(@"%zd",class_getInstanceSize([NSObject class]));//8
        
        //获得obj指针所指向的大小  16个字节 意思是分配了16个字节
        NSLog(@"%zd",malloc_size((__bridge const void *)(obj)));
        
    }

    return  0;
}
