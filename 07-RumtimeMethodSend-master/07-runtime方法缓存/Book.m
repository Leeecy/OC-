//
//  Book.m
//  07-runtime方法缓存
//
//  Created by app on 2022/7/13.
//  Copyright © 2022 guangqiang.liu. All rights reserved.
//

#import "Book.h"
#import <objc/runtime.h>
#import "Student.h"
@implementation Book
- (void)read{
    NSLog(@"read some book");
}
//1
//+ (BOOL)resolveClassMethod:(SEL)sel {
//    NSLog(@"1---%@",NSStringFromSelector(sel));
//    NSLog(@"1---%@",NSStringFromSelector(_cmd));
//    return NO;
//}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    NSLog(@"1---%@",NSStringFromSelector(sel));
//    NSLog(@"1---%@",NSStringFromSelector(_cmd));
//    return NO;
//}

-(id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"2---%@",NSStringFromSelector(aSelector));
    NSLog(@"2---%@",NSStringFromSelector(_cmd));
    return  nil;
    
//    if (aSelector == @selector(run)) {
//        NSLog(@"2---%@",NSStringFromSelector(aSelector));
//        NSLog(@"2---%@",NSStringFromSelector(_cmd));
//        return  nil;
//    }
//    return  [super forwardingTargetForSelector:aSelector];
}
//3.最后一步，返回方法签名
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"3---%@",NSStringFromSelector(aSelector));
    NSLog(@"3---%@",NSStringFromSelector(_cmd));
    if ([NSStringFromSelector(aSelector) isEqualToString:@"run"]) {
//        return [[Book new] methodSignatureForSelector:aSelector];
        
        return  [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}
//处理返回的方法签名
-(void)forwardInvocation:(NSInvocation *)anInvocation{

//    NSLog(@"4---%@",NSStringFromSelector(_cmd));
//    NSLog(@"4-最后一步--%@",anInvocation);
//    if ([NSStringFromSelector(anInvocation.selector) isEqualToString:@"run"]) {
//        NSLog(@"end finish");
//        anInvocation.selector = @selector(read);
//        [anInvocation invoke];
//        return;
//        }else{
//            [super forwardInvocation:anInvocation];
//        }
    
}
//触发崩溃
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"doesNotRecognizeSelector");
}
@end
