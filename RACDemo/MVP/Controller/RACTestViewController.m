//
//  RACTestViewController.m
//  RACDemo
//
//  Created by sjl on 2019/7/17.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "RACTestViewController.h"
#import "ReactiveObjC.h"
@interface RACTestViewController ()

@end

@implementation RACTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///BUTTON 的使用
    UIButton *racbtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 0, 60, 40)];
    [racbtn setTitle:@"racbtn" forState:UIControlStateNormal];
    [[racbtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"RACq按钮点击了");
        NSLog(@"%@",x);
    }];
    [self.view addSubview:racbtn];
    
    //信号类 只有当数据变化时，才会发送数据，但是RACSignal自己不具备发送信号能力，而是交给订阅者去发送。
    [self RACSignal];
    
    //遍历字典和数组
//    [self loopthrough];
    
    // Do any additional setup after loading the view.
}
- (void)RACSignal{
    //1创建信号 createSignal  （默认是冷信号）
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
         //2发送信号
        [subscriber sendNext:@"信号"];
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
//        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            // 执行完Block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
            
        }];
    }];
    
    //3. 订阅信号，才会激活信号。变成热信号
    [signal subscribeNext:^(id  _Nullable x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
    @weakify(self)
}

/*
 1.for in 的效率最高，但是在遍历过程中不能实时取得value所对应的index值
 2.如果要通过value查询index可以使用enumerateObjectsWithOptions，使用此方法遍历可以使用多线程遍历。但是遍历过程可以无序。效率最高。（用到了dispatch group）
 3.如果要通过遍历。通过一定的条件筛选得到一些数据。可以使用rac_sequence方法。直接获得。
 4.要想有序的遍历可以使用enumerateObjectsUsingBlock更加清晰直观。但是比for稍微慢一点。
 */
//遍历p字典和数组
- (void)loopthrough{
    NSArray *numbers =@[@1,@2,@3,@4];
    [numbers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"NSArray-----%@",x);
    }];
    
    
    //字典遍历
    NSDictionary *dict = @{@"name":@"xmg",@"age":@11};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key,NSString *value) = x;
        NSLog(@"%@ %@",key,value);
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
