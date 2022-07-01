//
//  main.m
//  isa指针01
//
//  Created by app on 2022/6/20.
//
/**
 对象的isa指针指向哪里
 
 instance的isa指向class 调用对象方法时 通过instance的isa找到class
 ，最后在class存储的信息中找到对象方法进行调用
 
 class的isa指向meta-class
 
 */



#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "NSObject+Test.h"

@interface Person : NSObject<NSCopying>
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSUInteger age;
-(void)personInstanceMethod;
+(void)personClassMethod;
+(void)test;
@end

@implementation Person
-(void)personInstanceMethod{
    
}
+(void)personClassMethod{
    
}
//+(void)test{
//    NSLog(@"+[Person test] -%p",self);
//}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return  nil;
}

@end


@interface Student : Person<NSCoding>{
    @public
    int _weight;
}
@property (nonatomic, copy) NSString* score;
-(void)studentInstanceMethod;
+(void)studentClassMethod;
@end

@implementation Student
-(void)studentInstanceMethod{
    
}
+(void)studentClassMethod{
    
}
-(instancetype)initWithCoder:(NSCoder *)coder{
    return  nil;
}
-(void)encodeWithCoder:(NSCoder *)coder{

}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Person--%p",[Person class]);
        NSLog(@" NSObject ==%p",[NSObject class]);
        //只有NSObject里面存在一个 同名的对象方法时 程序不会崩溃
        /**
         本质就是给 对象发消息 消息名不会区分 + - 号方法
         objc_sendMessaget([Person class],@selector(@"test"))
         */
        [Person test];
        [NSObject test];
        
        Person *per = [[Person alloc]init];
        Student *stu = [[Student alloc]init];
        //拿到类对象
        Class personClass = [per class];
        Class personMetaClass = object_getClass(personClass);
        //p/x (long)per->isa (long) $0 = 0x01000001000083a1 实例对象isa的指针地址
        NSLog(@"person--%p",per);
        //类对象的地址 理论上isa指向的地址就是clas对象
        // 64bit开始 isa需要进行一次位运算 算出真实地址
        //(Class) $1 = 0x00000001000083a0 Person
        NSLog(@"personClass--%p",personClass);
        //(Class) $2 = 0x0000000100008378
        NSLog(@" personMetaClass ==%p",personMetaClass);
        
        //objc_msgSend)((id)per, sel_registerName("personInstanceMethod"))
        
        [per personInstanceMethod];
        
        //子类调用父类实例方法 流程 实例对象方法存在类对象中
        /**
         stu的isa指针找到自己的clas对象，查看有没有对象方法，有的话调用，没有的话就通过class里面的superclass找到 person的class对象 依次查找到NSObject的class对象
         */
        [stu personInstanceMethod];
        
        /**
         子类调用父类 类方法 流程 类方法存在元类对象中
         */
        [Student personClassMethod];
        
        //调用类方法时 通过isa找到student的meta-class 通过meta-class里面的superclass找到person的meta-class --》〉
        [Student  personClassMethod];
        
    }
    return 0;
}
