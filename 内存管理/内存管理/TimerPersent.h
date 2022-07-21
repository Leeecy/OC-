//
//  TimerPersent.h
//  内存管理-定时器
//
//  Created by liuyaozong on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerPersent : NSObject
+(instancetype)initWithObject:(NSObject *)obj;
@property (nonatomic,weak) id target;
@end

NS_ASSUME_NONNULL_END
