//
//  TimerProxy.m
//  内存管理
//
//  Created by app on 2022/7/21.
//

#import "TimerProxy.h"

@implementation TimerProxy
+(instancetype)initWithTarget:(NSObject *)target {
    TimerProxy *proxy = [TimerProxy alloc];
    proxy.target = target;
    return  proxy;
}
//-(id)forwardingTargetForSelector:(SEL)aSelector{
//
//    return  self.target;
//}
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return  [self.target methodSignatureForSelector:aSelector];
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{    
    [anInvocation invokeWithTarget:self.target];
}
@end
