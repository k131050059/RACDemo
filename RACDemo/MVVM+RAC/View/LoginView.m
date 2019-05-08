//
//  LoginView.m
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "LoginView.h"
#import "ReactiveObjC.h"
#import "LoginViewModel.h"

@interface LoginView()
@property (strong, nonatomic)  UITextField *txtAccount;
@property (strong, nonatomic)  UITextField *txtPwd;
@property (strong, nonatomic)  UIButton *btnSubmit;
@property (strong, nonatomic)  UILabel *lblResult;

@property (strong,nonatomic) LoginViewModel *viewModel;
@end

@implementation LoginView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        //双向绑定
        [self initCommand];
        //接收信号
        [self initSubscribe];
    }
    return self;
}
- (void)initCommand {
    //关联赋值
    RAC(self.viewModel,account) = self.txtAccount.rac_textSignal;
    RAC(self.viewModel,pwd) = self.txtPwd.rac_textSignal;
}

- (void)initSubscribe {
    //VM内部处理按钮的可用状态 直接将结果告诉V
    // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [[self.viewModel.loginBtnEnableCmd.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        self.btnSubmit.enabled = [x boolValue];
        self.lblResult.text = @"";
    }];
    
    //监听当前命令是否正在执行executing
    //监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    //x:YES 当前cmd正在触发执行
    //x:NO 当前cmd不处于执行状态/或已处理完成
    [[self.viewModel.loginActionCmd.executing skip:1] subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在请求");
            self.lblResult.text=@"正在请求";
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
    }];
    
    //监听登录回调
    [[self.viewModel.loginActionCmd.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        LoginViewModel *loginViewModel = x;
        if (!loginViewModel) {
            return ;
        }
        if (loginViewModel.error) {
            //错误信息自行处理
            self.lblResult.text = [NSString stringWithFormat:@"%@",loginViewModel.error.userInfo[@"des"]];
            NSLog(@"登录失败");
            self.lblResult.text=@"登录失败";
        } else {
            self.lblResult.text = loginViewModel.loginModel.userId;
            NSLog(@"登录成功");
            self.lblResult.text=@"登录成功即将返回";
            [self pushToMainController];
        }
    }];
}

-(LoginViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [LoginViewModel new];
    }
    return _viewModel;
}







- (void)setupViews {
    self.txtAccount = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    self.txtAccount.backgroundColor = [UIColor grayColor];
    [self addSubview:self.txtAccount];
    
    self.txtPwd = [[UITextField alloc]initWithFrame:CGRectMake(100, 160, 100, 50)];
    self.txtPwd.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.txtPwd];
    
    self.btnSubmit = [[UIButton alloc]initWithFrame:CGRectMake(100, 220, 100, 50)];
    [self addSubview:self.btnSubmit];
    
    self.btnSubmit.enabled = NO;
    [self.btnSubmit setBackgroundImage:[self createImageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
    [self.btnSubmit setBackgroundImage:[self createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    
    [[self.btnSubmit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //VM调用登录方法
        [self.viewModel.loginActionCmd execute:nil];
        
    }];
    
    self.lblResult = [[UILabel alloc]initWithFrame:CGRectMake(100, 280, 200, 50)];
    self.lblResult.textColor=[UIColor blackColor];
    [self addSubview:self.lblResult];
}

-(UIImage*)createImageWithColor:(UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end
