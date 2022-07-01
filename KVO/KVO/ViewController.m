//
//  ViewController.m
//  KVO
//
//  Created by app on 2022/6/30.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"
#import "Observer.h"
@interface ViewController ()
@property(nonatomic,strong)Person *person;
@property(nonatomic,strong)Person *person2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc]init];
    self.person.age = 10;
    self.person->_height = 11;
    self.person2 = [[Person alloc]init];
    self.person2.age = 20;
    
    self.person.cat.weight = 29;
    
    
    Observer *obser = [[Observer alloc]init];
    
    
    //KVC
    [self.person setValue:@46 forKey:@"age"];
    self.person.cat = [[Cat alloc]init];
    //cat必须要有值
    [self.person setValue:@49 forKeyPath:@"cat.weight"];
//    NSLog(@"person添加kvo之前-%@ %@", objc_getClass(self.person), objc_getClass(self.person2));
    
    NSLog(@"监听之前%p --%p",[self.person methodForSelector:@selector(setAge:)],[self.person2 methodForSelector:@selector(setAge:)]);
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    
    [self.person addObserver:self forKeyPath:@"age" options:options context:NULL];
    
    [self.person setValue:@48 forKey:@"age"];
    
//    [self.person setValue:@68 forKey:@"sex"];
    
    NSLog(@"监听之后%p --%p",[self.person methodForSelector:@selector(setAge:)],[self.person2 methodForSelector:@selector(setAge:)]);
    NSLog(@"-%s %s", object_getClassName(self.person), object_getClassName(self.person2));
    NSLog(@"-%@ %@", [self.person class], [self.person2 class]);
    
    NSLog(@"-%@ %@", object_getClass(self.person), object_getClass(self.person2));
    
    NSLog(@"age=%d",self.person.age);
    NSLog(@"cat=%d",self.person.cat.weight);
}

-(void)dealloc{
    [self.person removeObserver:self forKeyPath:@"age"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self printClassAllMethod:object_getClass(self.person)];
    
    [self printClassAllMethod:object_getClass(self.person2)];
    NSLog(@"监听到%@的%@属性KEY=%@",object, keyPath,change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.person.age = 20;
    
//    [self.person setAge:21];
//    self.person2.age = 30;
    
    //手动触发KVO willChangeValueForKey要加入 是因为可能didChangeValueForKey要使用它做判断 不然不会响应
    [self.person willChangeValueForKey:@"age"];
    [self.person didChangeValueForKey:@"age"];
    
    //不会触发kvo 没有重写set方法
    self.person->_height = 31;
    
   
}
- (void)printClassAllMethod:(Class)cls{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i<count; i++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        IMP imp = class_getMethodImplementation(cls, sel);
        NSLog(@"%@=====%p",NSStringFromSelector(sel),imp);
    }
    free(methodList);
}

@end
