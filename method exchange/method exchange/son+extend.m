//
//  son+extend.m
//  method exchange
//
//  Created by app on 2022/7/18.
//

#import "son+extend.h"
#import <objc/runtime.h>

@implementation son (extend)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
      Method method1 = class_getInstanceMethod(self, @selector(eat));
      Method method2 = class_getInstanceMethod(self, @selector(anotherEat));
        //把原始方法名传到要改的方法
        BOOL didAddMethod =  class_addMethod(self, @selector(eat), method_getImplementation(method2), method_getTypeEncoding(method2));
        if (didAddMethod) {
            //用新的方法替换原来的方法
                class_replaceMethod(self,
                @selector(anotherEat),
                method_getImplementation(method1),
                method_getTypeEncoding(method1));
            }else{
                method_exchangeImplementations(method1, method2);
            }
      
    });
}

- (void)anotherEat{
//  NSLog(@"self:%@", self);
    if ([self isKindOfClass:[son class]]) {
        NSLog(@"-----son");
        NSLog(@"son 替换之后的吃的方法...");
    }else{
        [self anotherEat];
    }
  
  
}
@end
