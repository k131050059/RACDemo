//
//  MVPModel.h
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^Success)(NSDictionary *dic);
typedef void(^Failure)(NSDictionary *dic);
@interface MVPModel : NSObject

//获取数据，成功失败
-(void)getDataSuccess:(Success)success AndFailure:(Failure)failure;

-(void)refreshDataSuccess:(Success)success AndFailure:(Failure)failure;
@end

NS_ASSUME_NONNULL_END
