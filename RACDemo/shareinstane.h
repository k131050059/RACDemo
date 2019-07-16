//
//  shareinstane.h
//  RACDemo
//
//  Created by sjl on 2019/5/12.
//  Copyright © 2019 sjl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface shareinstane : NSObject
+(instancetype)sharedManager;
- (void)logsomething;
@end


NS_ASSUME_NONNULL_END
