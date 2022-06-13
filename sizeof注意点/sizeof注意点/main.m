//
//  main.m
//  sizeof注意点
//
//  Created by cl on 2022/6/12.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        //sizeof 实际就是运算符 运行的时候直接变成8（double）编译的就确定类型
        NSObject *obj = [[NSObject alloc]init];
        NSLog(@"%zd",sizeof(double));
        //obj是一个指针类型，在OC中指针的大小为8字节,所以sizeof(obj)输出为8字节

        NSLog(@"%zd",sizeof(obj));

        
        
    }
    return 0;
}
