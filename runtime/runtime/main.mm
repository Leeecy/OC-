//
//  main.m
//  runtime
//
//  Created by app on 2022/7/11.
//
/**
 BOOL 四个字节 0 1 int型
 */


#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/runtime.h>
#import "ClassInfo.h"
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

    static constexpr uintptr_t bucketsMask = ~0ul;
//
    struct lly_bucket_t* buckets() const
    {
            return (lly_bucket_t *)(_bucketsAndMaybeMask & bucketsMask);
        }
    
    
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

void printCache(Class model) {
    struct lly_objc_class * llyClass = (__bridge struct lly_objc_class *)(model);

    struct lly_cache_t cache = llyClass->cache;

    NSLog(@"_occupied = %d,_mask = %d",cache._occupied,cache._maybeMask);

    for (uint32_t i = 0; i < cache._maybeMask; i++) {
        struct lly_bucket_t bucket = cache.buckets()[i];
        NSLog(@"method : sel = %@, imp = %p",NSStringFromSelector(bucket._sel),bucket._imp);
    }

}

struct Direction {
    BOOL left;
    BOOL right;
    BOOL front;
    BOOL back;
};
struct HPDirection {
    BOOL left : 1;
    BOOL right : 1;
    BOOL front : 1;
    BOOL back : 1;
};
union Date{
    int year;
    int month;
    int day;
};
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *per = [[Person alloc]init];
        
        NSLog(@"%s",@encode(int));
        mj_objc_class *cls = (__bridge mj_objc_class*)[Person class];
        class_rw_t *data = cls->data();

        Class cls1 = [Person class];
        
        printCache(cls1);
        [per test];
        printCache(cls1);
//        per.rich = NO;
//        NSLog(@"%zd",class_getInstanceSize([Person class]));
        struct HPDirection hpDir;
        hpDir.left = YES;
        hpDir.right = YES;
        hpDir.front = YES;
        hpDir.back = YES;
       
        struct Direction dir;
        dir.left = YES;
        dir.right = YES;
        dir.front = YES;
        dir.back = YES;
        
        union Date date;
        NSLog(@"%zd---%zu date=%zd",sizeof(dir),sizeof(hpDir),sizeof(date));
    }
    return 0;
}
