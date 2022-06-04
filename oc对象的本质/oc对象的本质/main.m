//
//  main.m
//  oc对象的本质
//
//  Created by cl on 2022/6/4.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        NSObject *obj = [[NSObject alloc]init];
        
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
