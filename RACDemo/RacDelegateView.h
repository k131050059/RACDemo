//
//  RacDelegateView.h
//  RACDemo_Example
//
//  Created by sjl on 2019/3/27.
//  Copyright © 2019 soooner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"
NS_ASSUME_NONNULL_BEGIN

@interface RacDelegateView : UIView
@property (nonatomic,strong) RACSubject *btnClickSingle;

-(void)sendValue:(NSString*)str dic:(NSDictionary*)dic;
@end

NS_ASSUME_NONNULL_END
