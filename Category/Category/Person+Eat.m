//
//  Person+Eat.m
//  Category
//
//  Created by app on 2022/7/1.
//

#import "Person+Eat.h"
#import <objc/runtime.h>
NSString *_age;

@implementation Person (Eat)
static const char NameKey;
//-(void)eat{
//    NSLog(@"eat");
//}
//-(void)test{
//    NSLog(@"test+eat");
//}
-(void)setName:(NSString *)name{
    
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
    return  objc_getAssociatedObject(self, _cmd);
}
-(void)setHeight:(CGFloat)height{
    height = 10.0;
}
-(CGFloat)height{
    return 10.0;
}
-(NSString *)age{
    return  _age;
}
-(void)setAge:(NSString *)age{
    _age = age;
}
//+(void)test{
//    NSLog(@"PersonEat(+) test");
//}

//+(void)load{
//    NSLog(@"Eat + load");
//}
+(void)initialize{
    NSLog(@"Eat+initialize");
}
@end
