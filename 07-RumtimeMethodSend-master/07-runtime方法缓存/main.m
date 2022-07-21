//
//  main.m
//  07-runtime方法缓存
//
//  Created by 刘光强 on 2020/2/7.
//  Copyright © 2020 guangqiang.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJClassInfo.h"
#import "Person.h"
#import "Student.h"
#import "GoodStudent.h"
//#import <objc/runtime.h>
#import <objc/message.h>
#import "Book.h"
#import "English.h"
# if __arm64__
#   define ISA_MASK        0x0000000ffffffff8ULL
# elif __x86_64__
#   define ISA_MASK        0x00007ffffffffff8ULL
# endif


#if __LP64__
typedef uint32_t mask_t;
#else
typedef uint16_t mask_t;
#endif

//模拟器
typedef uint32_t mask_t;

struct lly_bucket_t {
#if __arm64__
    uintptr_t _imp;
    SEL _sel;
#else
    SEL _sel;
    uintptr_t _imp;
#endif
    
};

struct lly_cache_t {
  //模拟器、macos环境
    
    /**old
    struct lly_bucket_t * _buckets;
    mask_t _mask;
    uint16_t _flags;
    uint16_t _occupied;
     */
    
    uintptr_t _bucketsAndMaybeMask;
    union {
        struct {
            mask_t    _maybeMask;
            uint16_t                   _flags;
            uint16_t                   _occupied;
        };
    };

    // _bucketsAndMaybeMask is a buckets_t pointer
    // _maybeMask is the buckets mask

//    static constexpr uintptr_t bucketsMask = ~0ul;
//
//    struct lly_bucket_t* buckets() const
//    {
//            return (lly_bucket_t *)(_bucketsAndMaybeMask & bucketsMask);
//        }
    
    
};
struct lly_class_data_bits_t {
//    Class objc_class;
    // Values are the FAST_ flags above.
    uintptr_t bits;
};

struct lly_objc_class {
    Class ISA;
    Class superclass;
    struct lly_cache_t cache;
    struct lly_class_data_bits_t bits;
};

//void printCache(Class model) {
//    struct lly_objc_class * llyClass = (__bridge struct lly_objc_class *)(model);
//
//    struct lly_cache_t cache = llyClass->cache;
//
//    NSLog(@"_occupied = %d,_mask = %d",cache._occupied,cache._maybeMask);
//
//    for (uint32_t i = 0; i < cache._maybeMask; i++) {
//        struct lly_bucket_t bucket = cache.buckets()[i];
//        NSLog(@"method : sel = %@, imp = %p",NSStringFromSelector(bucket._sel),bucket._imp);
//    }
//
//}

void test(){
    long long a = 4;
    long long b = 5;
    long long c = 6;
    NSLog(@"%p--%p--%p",&a,&b,&c);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        test();
        Person *per = [[Person alloc]init];
        NSLog(@"==%@",[Person class]);
//        [per run];
//                Book *book = [[Book alloc]init];
//        [book run];
        NSLog(@"%p--%p",object_getClass(per),[Person class]);
        object_setClass(per, [Book class]);
        [per run];
        Student *stu = [[Student alloc]init];
//        [stu run];
//        printCache(Person.class);
//        struct objc_super mysuper;
//        English * english = [English alloc];

//        [english read];
//        mysuper.receiver = english;
//        mysuper.super_class = [Book class];
//        objc_msgSend(book,sel_registerName("read"));
//        objc_msgSendSuper(&mysuper,sel_registerName("read"));
        
//        [book read];
        
        
        
        NSLog(@"---");
    }
    return 0;
}
