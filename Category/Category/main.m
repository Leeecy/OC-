//
//  main.m
//  Category
//
//  Created by app on 2022/7/1.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+Eat.h"
#import "Person+Run.h"
#import <objc/runtime.h>
#import "Student.h"
#import "Jack.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        [Person test];
        Person *per = [[Person alloc]init];
//        printClassAllMethod(object_getClassName([Person class]));
//        [per test];
        [per setAge:@"20"];
        per.name = @"mark";
        NSLog(@"age==%@ %f %@", per.age,per.height,per.name);
//        [per run];
//        [per eat];
//        [Person alloc];
        [Jack load];
        
    }
    return 0;
}
void printClassAllMethod (Class cls){
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i<count; i++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        IMP imp = class_getMethodImplementation(cls, sel);
        NSLog(@"%@=====%p",NSStringFromSelector(sel),imp);
    }
    free(methodList);
}


