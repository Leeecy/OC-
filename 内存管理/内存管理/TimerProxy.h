//
//  TimerProxy.h
//  内存管理
//
//  Created by app on 2022/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerProxy : NSProxy
+(instancetype)initWithTarget:(NSObject *)target;
@property (nonatomic,weak) id target;
@end

NS_ASSUME_NONNULL_END
