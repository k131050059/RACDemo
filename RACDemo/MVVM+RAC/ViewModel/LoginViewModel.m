//
//  LoginViewModel.m
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginModel.h"
@implementation LoginViewModel

- (instancetype)init{
    if (self = [super init]) {
        //双向绑定
        [self initCommand];
        [self initSubscribe];
    }
    return self;
}
/*
 VIEW 中的判断按钮是否可用逻辑 挪到VM中。 如果可用 通过RACCommand 发送出去。 VIEW 中监听了RACCommand信号
 
 VIEW 中点击登录 网络请求逻辑 挪到VM中。 点击 通知VM 走登录逻辑 , 网络请求后 返回一个信号 给VIEW 
 
 */

- (void)initSubscribe {
    //监听 输入字段
    [RACObserve(self, account) subscribeNext:^(id  _Nullable x) {
        //每次输入有变动就 判断按钮是否可用逻辑放到VM中
        [self checkSubmitEnable];
    }];
    [RACObserve(self, pwd) subscribeNext:^(id  _Nullable x) {
        [self checkSubmitEnable];
    }];
}

- (void)checkSubmitEnable {
    //
    [self.loginBtnEnableCmd execute:nil];
}

- (void)initCommand {
    // 1.signalBlock必须要返回一个信号，不能传nil.
    // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
    // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
    // 4.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
    
    //创建命令
    self.loginBtnEnableCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //创建空信号，必须返回信号
        //return [RACSignal empty];
        //校验登录按钮的状态
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            //模拟：3个字符便可
            BOOL status = self.account.length == 3 && self.pwd.length == 3;
            [subscriber sendNext:@(status)];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    self.loginActionCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self racForlogin];
    }];
}
//登录操作
- (RACSignal *)racForlogin {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //模拟网络请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LoginModel *result = [LoginModel new];
            if ([self.account isEqualToString:@"123"] && [self.pwd isEqualToString:@"123"]) {
                //模拟请求结果
                result.userId = [NSString stringWithFormat:@"%@%@",self.account,self.pwd];
                result.displayName = result.userId;
                self.error = nil;
            } else {
                //模拟错误
                self.error = [NSError errorWithDomain:@"-1" code:-1 userInfo:@{@"des":@"账号密码错误"}];
            }
            self.loginModel = result;
            //结果发送给监听方
            [subscriber sendNext:self];
            //设置完成
            [subscriber sendCompleted];
        });
        return nil;
    }];
}

 
@end
