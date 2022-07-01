//
//  Person.m
//  KVO
//
//  Created by app on 2022/6/30.
//

#import "Person.h"

@implementation Person
-(void)setAge:(int)age{
    _age = age;

    NSLog(@"setAge");
}

-(void)willChangeValueForKey:(NSString*)key{
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey");
}
-(void)didChangeValueForKey:(NSString *)key{
    NSLog(@"didChangeValueForKey start");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey end");

}
//允许访问成员变量
+ (BOOL)accessInstanceVariablesDirectly{
    return YES;
}

@end
