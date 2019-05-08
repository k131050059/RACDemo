//
//  MVPresenter.h
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVProtocal.h"
NS_ASSUME_NONNULL_BEGIN

@interface MVPresenter : NSObject

//和已经实现了协议的view建立联系，以便在本类调用实现的协议
-(void)attatchView:(id<MVProtocal>)view;

//从model拿到数据，交给view的协议方法
-(void)getData;

- (void)refreshData;

- (void)loginAction;
@end

NS_ASSUME_NONNULL_END
