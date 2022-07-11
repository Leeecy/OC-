//
//  main.m
//  block
//
//  Created by app on 2022/7/8.
//

#import <Foundation/Foundation.h>
#import "Person.h"
struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};
struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
};
struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
    int age;
};

void(^bBlock)(void);
void test(void){
    int aa = 30;
    static int dd = 40;
    bBlock = ^{
        NSLog(@"auto ivar test %d",aa);
        NSLog(@"static ivar test %d",dd);
    };
    
//    aa = 33;
//    dd = 56;
}

typedef void (^AABlock)(void);
typedef void (^CCBlock)(void);
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *per = [[Person alloc]init];
        __weak typeof(per) weakP = per;
        per.age = 10;
        per.name = @"hell";
        per.pBlock = ^{
            NSLog(@"%d",weakP.age);
//            NSLog(@"---------30");
            NSLog(@"%@",weakP.name);
        };
//        per.pBlock();
        
        NSLog(@"%@",[per.pBlock class]);
        NSLog(@"CFGetRetainCount= %ld",CFGetRetainCount((CFTypeRef)(per)));
        NSLog(@"---------");
        
        /**
        NSObject *obj = [[NSObject alloc]init];
        
        AABlock aBc = ^{
            NSLog(@"%p",obj);
        };
        
        aBc();
        NSLog(@"type1=  %@ %@",[aBc class],[[aBc class] superclass]);
        
        AABlock aaBlock;
        __block Person *per = [[Person alloc]init];
        __strong Person* weakP = per;
        per.age = 20;
            __weak typeof(Person) *weakP = per;
        aaBlock = ^{
            
            NSLog(@"age====%@",weakP);
            per = nil;
        };
        aaBlock();
         */
      
    
        /**
        __block int ee = 10;
        CCBlock bloc = ^{
            NSLog(@"ee is %d",ee);
        };
        
        bloc();
        test();
        bBlock();
        
        auto int c = 30;
        static int d = 40;
        
        void(^block)(int,int)= ^(int a,int b){
            NSLog(@"this is block %d",a+b);
            NSLog(@"auto ivar %d",c);
            NSLog(@"static ivar %d",d);
        };
        
        c =50;
        d = 80;
        block(10,20);
        
        auto int aaa =10;
        void(^cblock)(void)= ^(){
         
            NSLog(@"this is cblock %d",aaa);
            
        };
        
        struct __main_block_impl_0 *blockStuct = ( __bridge struct __main_block_impl_0 *)block;
        
        NSLog(@"type1=  %@ %@",[block class],[[block class] superclass]);
        NSLog(@"type2=  %@ %@",[bBlock class],[[block class] superclass]);
        
        //ARC自动 copy操作了
        NSLog(@"type3=  %@ %@",[cblock class],[[cblock class] superclass]);
        
        NSLog(@"type4=  %@ %@",[[^{NSLog(@"1111=%d",c);} copy] class],[[^{NSLog(@"1111=%d",c);} class] superclass]);
        NSLog(@"type5=  %@ %@",[^{NSLog(@"1111=%d",c);}  class],[[^{NSLog(@"1111=%d",c);} class] superclass]);
         */
    }
    return 0;
}
