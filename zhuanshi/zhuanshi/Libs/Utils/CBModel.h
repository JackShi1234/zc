//
//  HYModel.h
//
//
//  Created By Administrator.Fyxrhyry on 2014-02-13.
//  Copyright (c) 2014年 YNET®. All rights reserved.
//

#import <Foundation/Foundation.h>

//全局状态信息，此类为单例。可以包含Session、登录用户等。
@interface CBModel : NSObject

@property (nonatomic,strong)NSString *city;

+ (CBModel *)sharedInstance;
@end









