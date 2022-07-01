//
//  Person.h
//  KVO
//
//  Created by app on 2022/6/30.
//

#import <Foundation/Foundation.h>
#import "Cat.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject{
    @public
    int _height;
    
//    int _sex;
//        int _isSex;
//        int sex;
//        int isSex;
}
@property(nonatomic,assign)int age;
@property(nonatomic,strong)Cat *cat;
@end

NS_ASSUME_NONNULL_END
