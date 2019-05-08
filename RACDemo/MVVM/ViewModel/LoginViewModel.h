//
//  LoginViewModel.h
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *pwd;

@property (nonatomic,strong) NSError *error;

@property (nonatomic,strong) RACCommand *loginBtnEnableCmd;
@property (nonatomic,strong) RACCommand *loginActionCmd;

//VM 持有model 反之不持有
@property (nonatomic,strong) LoginModel *loginModel;

@end

NS_ASSUME_NONNULL_END
