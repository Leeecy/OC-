//
//  NSArray+Extend.m
//  method exchange
//
//  Created by app on 2022/7/18.
//

#import "NSArray+Extend.h"
#import <objc/runtime.h>
//user can ignore below define
#define AvoidCrashDefaultReturnNil  @"AvoidCrash default is to return nil to avoid crash."
#define AvoidCrashDefaultIgnore     @"AvoidCrash default is to ignore this operation to avoid crash."

@implementation NSArray (Extend)


/**
 *  对象方法的交换
 *
 *  @param anClass    哪个类
 *  @param method1Sel 方法1(原本的方法)
 *  @param method2Sel 方法2(要替换成的方法)
 */
+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {


    Method originalMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzledMethod = class_getInstanceMethod(anClass, method2Sel);

    BOOL didAddMethod =
    class_addMethod(anClass,
                    method1Sel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(anClass,
                            method2Sel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }

    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }

}


+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{


        //====================
        //   instance method
        //====================

        Class __NSArray = NSClassFromString(@"NSArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        Class NSConstantArray = NSClassFromString(@"NSConstantArray");



        //objectsAtIndexes:
        [self exchangeInstanceMethod:__NSArray method1Sel:@selector(objectsAtIndexes:) method2Sel:@selector(avoidCrashObjectsAtIndexes:)];

        [self exchangeInstanceMethod:NSConstantArray method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSContentArrayObjectAtIndex:)];
        
        //objectAtIndex:

        [self exchangeInstanceMethod:__NSArrayI method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSArrayIAvoidCrashObjectAtIndex:)];

        [self exchangeInstanceMethod:__NSSingleObjectArrayI method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSSingleObjectArrayIAvoidCrashObjectAtIndex:)];

        [self exchangeInstanceMethod:__NSArray0 method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSArray0AvoidCrashObjectAtIndex:)];


        [self exchangeInstanceMethod:__NSArrayI method1Sel:@selector(objectAtIndexedSubscript:) method2Sel:@selector(__NSArrayIAvoidCrashObjectAtIndexedSubscript:)];

        //getObjects:range:
        [self exchangeInstanceMethod:__NSArray method1Sel:@selector(getObjects:range:) method2Sel:@selector(NSArrayAvoidCrashGetObjects:range:)];

        [self exchangeInstanceMethod:__NSSingleObjectArrayI method1Sel:@selector(getObjects:range:) method2Sel:@selector(__NSSingleObjectArrayIAvoidCrashGetObjects:range:)];

        [self exchangeInstanceMethod:__NSArrayI method1Sel:@selector(getObjects:range:) method2Sel:@selector(__NSArrayIAvoidCrashGetObjects:range:)];
    });

}


//=================================================================
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)__NSArrayIAvoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;

    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        NSLog(@"%@",defaultToDo);
    }
    @finally {
        return object;
    }

}


//=================================================================
//                       objectsAtIndexes:
//=================================================================
#pragma mark - objectsAtIndexes:

- (NSArray *)avoidCrashObjectsAtIndexes:(NSIndexSet *)indexes {

    NSArray *returnArray = nil;
    @try {
        returnArray = [self avoidCrashObjectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        NSLog(@"%@",defaultToDo);

    } @finally {
        return returnArray;
    }
}



//=================================================================
//                         objectAtIndex:
//=================================================================
#pragma mark - objectAtIndex:

//__NSArrayI  objectAtIndex:
- (id)__NSArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {

//    NSLog(@"%s",__func__);
    id object = nil;

    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        NSLog(@"%@",defaultToDo);
    }
    @finally {
        return object;
    }
}



//__NSSingleObjectArrayI objectAtIndex:
- (id)__NSSingleObjectArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;

    @try {
        object = [self __NSSingleObjectArrayIAvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        NSLog(@"%@",defaultToDo);
    }
    @finally {
        return object;
    }
}

- (id)__NSContentArrayObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    if (index > self.count - 1 || !self.count) {
           @try {
               object = [self __NSContentArrayObjectAtIndex:index];
           } @catch (NSException *exception) {
               NSLog(@"不可数组0个元素越界了");
               return nil;
           } @finally {
               return object;
           }
       } else {
           return [self __NSContentArrayObjectAtIndex:index];
       }
}

//__NSArray0 objectAtIndex:
-(id)__NSArray0AvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;

    @try {
        object = [self __NSArray0AvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        NSLog(@"%@",defaultToDo);
    }
    @finally {
        return object;
    }
}


//=================================================================
//                           getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

//NSArray getObjects:range:
-(void)NSArrayAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {

    @try {
        [self NSArrayAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {

        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        NSLog(@"%@",defaultToDo);

    } @finally {

    }
}


//__NSSingleObjectArrayI  getObjects:range:
- (void)__NSSingleObjectArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {

    @try {
        [self __NSSingleObjectArrayIAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {

        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        NSLog(@"%@",defaultToDo);

    } @finally {

    }
}


//__NSArrayI  getObjects:range:
-(void)__NSArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {

    @try {
        [self __NSArrayIAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {

        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        NSLog(@"%@",defaultToDo);

    } @finally {

    }
}


/**
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method old = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method new = class_getInstanceMethod(self, @selector(WG_objectAtIndex_NSArrayI:));
        
        if (old && new) {
            method_exchangeImplementations(old, new);
        }
        
        
        old = class_getInstanceMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:));
        new = class_getInstanceMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(WG_objectAtIndex_NSSingleObjectArrayI:));
        if (old && new) {
            method_exchangeImplementations(old, new);
        }
        
        old = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(objectAtIndex:));
        new = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(WG_objectAtIndex_NSArray0:));
        if (old && new) {
            method_exchangeImplementations(old, new);
        }
        old = class_getInstanceMethod(objc_getClass("NSConstantArray"), @selector(objectAtIndex:));
        new = class_getInstanceMethod(objc_getClass("NSConstantArray"), @selector(WG_objectAtIndex_NSArrayContent:));
        if (old && new) {
            method_exchangeImplementations(old, new);
        }
        
    });
}

- (id)WG_objectAtIndex_NSArrayI:(NSUInteger)index {
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self WG_objectAtIndex_NSArrayI:index];
        } @catch (NSException *exception) {
            NSLog(@"不可数组多元素越界了");
            return nil;
        } @finally {
        }
    } else {
        return [self WG_objectAtIndex_NSArrayI:index];
    }
}

- (id)WG_objectAtIndex_NSSingleObjectArrayI:(NSUInteger)index {
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self WG_objectAtIndex_NSSingleObjectArrayI:index];
        } @catch (NSException *exception) {
            NSLog(@"不可数组一个元素越界了");
            return nil;
        } @finally {
        }
    } else {
        return [self WG_objectAtIndex_NSSingleObjectArrayI:index];
    }
}

- (id)WG_objectAtIndex_NSArray0:(NSUInteger)index {
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self WG_objectAtIndex_NSArray0:index];
        } @catch (NSException *exception) {
            NSLog(@"不可数组0个元素越界了");
            return nil;
        } @finally {
        }
    } else {
        return [self WG_objectAtIndex_NSArray0:index];
    }
}

- (id)WG_objectAtIndex_NSArrayContent:(NSUInteger)index {
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self WG_objectAtIndex_NSArrayContent:index];
        } @catch (NSException *exception) {
            NSLog(@"不可数组0个元素越界了");
            return nil;
        } @finally {
        }
    } else {
        return [self WG_objectAtIndex_NSArrayContent:index];
    }
}
 */
@end
