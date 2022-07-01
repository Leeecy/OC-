//
//  Observer.m
//  KVO
//
//  Created by app on 2022/7/1.
//

#import "Observer.h"

@implementation Observer

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    NSLog(@"Observer 监听到%@的%@属性KEY=%@",object, keyPath,change);
}
@end
