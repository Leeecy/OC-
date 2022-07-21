//
//  CLCustomThread.h
//  runloop
//
//  Created by app on 2022/7/19.
//

#import <Foundation/Foundation.h>

typedef void (^LFSThreadTask)(void);
NS_ASSUME_NONNULL_BEGIN

@interface CLCustomThread : NSObject
-(void)run;
-(void)stop;
-(void)executeTask:(LFSThreadTask)task;
@end

NS_ASSUME_NONNULL_END
