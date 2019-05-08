//
//  MVPresenter.m
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "MVPresenter.h"
#import "MVPModel.h"

@interface MVPresenter()

//model数据源
@property(nonatomic,strong) MVPModel *mmodel;
//p和v相互持有，互有对象，所以通过weak打破循环引用
@property(nonatomic,weak)id<MVProtocal> attachView;
@end

@implementation MVPresenter

-(void)attatchView:(id<MVProtocal>)view{
    self.attachView = view;
    self.mmodel = [MVPModel new];
}

-(void)getData{
    [self.mmodel getDataSuccess:^(NSDictionary * _Nonnull dic) {
        NSArray * arr = [dic valueForKey:@"data"];
        [self.attachView reloadTableView:arr];
        
    } AndFailure:^(NSDictionary * _Nonnull dic) {
        NSLog(@"%@",dic[@"error"]);
    }];
}

- (void)refreshData{
    [self.mmodel refreshDataSuccess:^(NSDictionary * _Nonnull dic) {
        NSArray * arr = [dic valueForKey:@"data"];
        [self.attachView reloadTableView:arr];
        [self.attachView changeColor];
    } AndFailure:^(NSDictionary * _Nonnull dic) {
         NSLog(@"%@",dic[@"error"]);
    }];
}
- (void)loginAction{
    [self.attachView loginSuccess];
    
}
@end
