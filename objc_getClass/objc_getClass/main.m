//
//  main.m
//  objc_getClass
//
//  Created by app on 2022/6/20.
//

/**
 1.Class objc_getClass(const char *aClassName)
 1> 传入字符串类名
 2> 返回对应的类对象
 
 
 2.Class object_getClass(id obj) -》得到的是他的 isa 指向的地址
 1> 传入的obj可能是instance对象、class对象、meta-class对象
 2> 返回值
 a) 如果是instance对象，返回class对象
 b) 如果是class对象，返回meta-class对象
 c) 如果是meta-class对象，返回NSObject（基类）的meta-class对象
 
 3.- (Class)class、+ (Class)class
 1> 返回的就是类对象

 (Class)class {
 return self->isa;
 }
 (Class) class {
 return self;
 }
 
 */


#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Son : NSObject

@end

@implementation Son


@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSObject *p1 = [[NSObject alloc]init];
        Class c1 = [p1 class];
        Class class2 =  object_getClass(p1);
        const char *className = object_getClassName(class2);

        //传入字符串类名 返回对应的类名
        Class class1 =  objc_getClass(className);
//        Class class1  = objc_getClass(NSClassFromString(@"class2"));
        NSLog(@"c1=%p class2 =%p class1=%p",c1,class2,class1);
        
        Son *sonObject = [Son new];
        Class currentClass = [sonObject class];
        
        const char *class_name = object_getClassName(currentClass);
        
        
        for (int i =0; i<4; i++) {
            NSLog(@"class:%p-----className:%s-------superClass:%@\n",currentClass,class_name,[currentClass superclass]);
            
            currentClass = object_getClass(currentClass);
            className = object_getClassName(currentClass);

        }
        
       

        
    }
    return 0;
}
