//
//  ViewController.m
//  RACDemo
//
//  Created by sjl on 2019/3/26.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
#import "RacDelegateView.h"
#import "MVVMViewController.h"
#import "MVP/View/MVPViewController.h"
#import "shareinstane.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSDictionary *dict =@{@"大吉大利":@"今晚吃鸡",
//                          @"666666":@"999999",
//                          @"dddddd":@"aaaaaa"
//                          };
//    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    return;
    
    
    
    
    
//    NSArray *numbers = @[@1,@2,@3,@4];
//    [numbers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@ ==",x);
//    }];
//    return;
    
    
    //事件监听
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        btn.frame=CGRectMake(200, 200, 50, 100);
        NSLog(@"%@ ==",x);
        NSLog(@"btn 点击");
//        MVVMViewController *vc = [[MVVMViewController alloc]init];
//
//        [self.navigationController pushViewController:vc animated:YES];
        [[shareinstane sharedManager] logsomething];
    }];
    
    [[btn rac_valuesAndChangesForKeyPath:@"frame" options:(NSKeyValueObservingOptionNew) observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        
        NSLog(@"frame改变了%@",x);
    }] ;
    
    {
        
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"MVP" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
   
            MVPViewController *vc = [[MVPViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }
    
    //代理
    RacDelegateView *deleView = [[RacDelegateView alloc]initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, self.view.frame.size.height-120)];
//    [self.view addSubview:deleView];
    [deleView.btnClickSingle subscribeNext:^(id  _Nullable x) {
        NSLog(@"点击按钮%@ ",x);
    }];
    [[deleView rac_signalForSelector:@selector(sendValue:dic:)]subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"方法first传递%@",x.first);
        NSLog(@"方法sec传递%@",x.second);
        NSLog(@"方法third传递%@",x.third);
    }];
    
    //代替通知  and j监听文本
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(100, 20, 100, 50)];
    field.backgroundColor=[UIColor redColor];
    [self.view addSubview:field];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"键盘弹起%@ ",[x.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]);
    }];
    
    [field.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    {
        // 处理多个请求，都返回结果的时候，统一做处理.
        RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 发送请求1
            [subscriber sendNext:@"发送请求1"];
            return nil;
        }];
        
        RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 发送请求2
            [subscriber sendNext:@"发送请求2"];
            return nil;
        }];
        
        // 使用注意：几个信号，selector的方法就几个参数，每个参数对应信号发出的数据。
        // 不需要订阅:不需要主动订阅,内部会主动订阅
        [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
    }
    
    
    /*  宏*/
    {
        [RACObserve(field, text)subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, 200, 40)];
        [self.view addSubview:lab];
        RAC(lab,text) = field.rac_textSignal;
    }
    
    
    
    {
        //调用
        RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"signalA"];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"signalB"];
            [subscriber sendCompleted];
            return nil;
        }];
        // 把signalA拼接到signalB后，signalA发送完成，signalB才会被激活 顺序执行
        [[signalA concat:signalB] subscribeNext:^(id  _Nullable x) {
            //先拿到 signalA 的结果 ， 再拿到 signalB 的结果 ， 执行两次
            NSLog(@"concat result = %@", x);
        }];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}
// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@ %@",data,data1);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
