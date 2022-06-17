//
//  main.m
//  instance对象
//
//  Created by app on 2022/6/17.
//
/**
 oc对象
 instanc对象 通过类 alloc出来的对象 每次alloc都会产生新的instance对象
 
 class对象（类对象）
 
 meta-class对象（元类）
 */
#import <Foundation/Foundation.h>


@interface kPerson : NSObject<NSCopying>{
    int _age;
    int _height;
    int _no;
}

@end

@interface kStudent : kPerson{
    int _weight;
}

@end

@implementation kPerson

-(id)copyWithZone:(NSZone *)zone{
    //新建对象 返回地址不一样
    kPerson * p = [[kPerson alloc]init];
    return  p;
    
//    返回self 内存地址一样
//    return self;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        /**
         存储信息包括
         isa
         成员变量
         
         */
        kPerson *ob1 = [[kPerson alloc]init];
        NSLog(@"%@",ob1);
        NSLog(@"%@",[ob1 copy]);
        NSObject *ob2 = [[NSObject alloc]init];
        
    }
    return 0;
}
