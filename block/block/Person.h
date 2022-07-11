//
//  Person.h
//  block
//
//  Created by app on 2022/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^AAABlock)(void);
@interface Person : NSObject

@property(nonatomic,assign)int age;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)AAABlock  pBlock;
@end

NS_ASSUME_NONNULL_END
