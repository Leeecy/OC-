//
//  UIControl+Extend.m
//  method exchange
//
//  Created by app on 2022/7/18.
//

#import "UIControl+Extend.h"
#import <objc/runtime.h>
@implementation UIControl (Extend)
+(void)load{
    SEL selA = @selector(sendAction:to:forEvent:);
    //转换的方法(基于系统自己写的)
    SEL selB = @selector(mySendAction:to:forEvent:);
    
    Method thodA = class_getInstanceMethod(self, selA);
    Method thodB = class_getInstanceMethod(self, selB);
    //添加方法
    BOOL addB = class_addMethod(self, selA, method_getImplementation(thodB), method_getTypeEncoding(thodB));
    if (addB) {
        //添加成功说明方法在原类中不存在 也就是本类中thodA不存在 用下面的方法替换其实现
        
        NSLog(@"如果方法已经添加,则替换");
//        如果方法已经添加,则替换
        class_replaceMethod(self, selB, method_getImplementation(thodA), method_getTypeEncoding(thodA));
    }else{
        NSLog(@"否则直接交换方法");
        method_exchangeImplementations(thodA, thodB);
    }
    
    
}
-(void)mySendAction:(SEL)action to:(id)target forEvent:(UIControlEvents *)event{
    NSLog(@"%s",__func__);
    //这个是判断是为了防止别的事件也走此方法
    if([NSStringFromClass(self.class)isEqualToString:@"UIButton"]) {
        NSLog(@"只拦截uibutton");
    }
    [self mySendAction:action to:target forEvent:event];
}
@end
