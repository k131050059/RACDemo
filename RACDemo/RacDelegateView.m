//
//  RacDelegateView.m
//  RACDemo_Example
//
//  Created by sjl on 2019/3/27.
//  Copyright © 2019 soooner. All rights reserved.
//

#import "RacDelegateView.h"

@implementation RacDelegateView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        //创建一个按钮
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 70, 70)];
        btn.backgroundColor = [UIColor blueColor];
        [self addSubview:btn];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            [self.btnClickSingle sendNext:[NSObject new]];
            [self sendValue:@"str1234" dic:@{@"key":@"value"}];
        }];
 
    }
    return self;
}
-(RACSubject *)btnClickSingle{
    if (!_btnClickSingle) {
        _btnClickSingle = [RACSubject subject];
    }
    return _btnClickSingle;
}
 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
