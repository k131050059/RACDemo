//
//  MVProtocal.h
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MVProtocal <NSObject>
@optional
-(void)reloadTableView:(NSArray*)data;


-(void)changeColor;


- (void)loginSuccess;

@end

NS_ASSUME_NONNULL_END
