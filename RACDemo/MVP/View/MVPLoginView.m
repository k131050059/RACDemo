//
//  MVPLoginView.m
//  RACDemo
//
//  Created by sjl on 2019/5/9.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "MVPLoginView.h"
#import "ReactiveObjC.h"
@interface MVPLoginView()
@property (strong, nonatomic)  UITextField *txtAccount;
@property (strong, nonatomic)  UITextField *txtPwd;
@property (strong, nonatomic)  UIButton *btnSubmit;
@property (strong, nonatomic)  UILabel *lblResult;

@end

@implementation MVPLoginView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
  
    }
    return self;
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
    
 
    [self.btnSubmit setBackgroundImage:[self createImageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
    [self.btnSubmit setBackgroundImage:[self createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    
    [[self.btnSubmit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //VM调用登录方法
        [self.presenter loginAction];
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
