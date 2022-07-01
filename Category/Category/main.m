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
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *per = [[Person alloc]init];
        [per test];
        [per run];
        [per eat];
    }
    return 0;
}
