//
//  shareinstane.m
//  RACDemo
//
//  Created by sjl on 2019/5/12.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "shareinstane.h"

@implementation shareinstane
static shareinstane *defaultManager;
+(instancetype)sharedManager{
    static dispatch_once_t token;
    NSLog(@"dispatch_once_1 Token: %ld",token);
    dispatch_once(&token, ^{
        NSLog(@"dispatch_once_2 Token: %ld",token);
      
        if(defaultManager == nil) {
            NSLog(@"dispatch_once_3 Token: %ld",token);
            defaultManager = [[self alloc] init];
        }
    });
    NSLog(@"Token: %ld",token);
    NSLog(@"DefaultManager: %@",defaultManager);
    return defaultManager;
}

- (void)logsomething{
    NSLog(@"=======start=======");
  
    NSLog(@"========end======");
}
@end
