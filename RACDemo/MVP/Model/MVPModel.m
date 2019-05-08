//
//  MVPModel.m
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "MVPModel.h"

@implementation MVPModel
-(void)getDataSuccess:(Success)success AndFailure:(Failure)failure{
    //请求下来的数组字典
    NSArray  *result =@[@{@"title":@"我是谁",
                          @"tag":@1,
                          },
                        @{@"title":@"我从哪来",
                          @"img":@2,
                          },
                        @{@"title":@"要到哪去",
                          @"img":@3,
                          }];
    
    if (result.count > 0) {
        //注意小写
        success(@{@"data":result});
        
    }else{
        failure(@{@"error":@"no data"});
        
    }
    
}

-(void)refreshDataSuccess:(Success)success AndFailure:(Failure)failure{
    //请求下来的数组字典
   
    NSString *randomStr =  [NSString stringWithFormat:@"%.4d", (arc4random() % 10000)];
    NSString *random2 =  [NSString stringWithFormat:@"%.4d", (arc4random() % 10000)];
    NSString *random3 =  [NSString stringWithFormat:@"%.4d", (arc4random() % 10000)];
    NSArray  *result =@[@{@"title":randomStr,
                          @"tag":@1,
                          },
                        @{@"title":random2,
                          @"img":@2,
                          },
                        @{@"title":random3,
                          @"img":@3,
                          }];
    
    if (result.count > 0) {
        //注意小写
        success(@{@"data":result});
        
    }else{
        failure(@{@"error":@"no data"});
        
    }
    
}
@end
