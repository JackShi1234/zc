//
//  HYModel.m
//
//
//  Created By Administrator.Fyxrhyry on 2014-02-13.
//  Copyright (c) 2014年 YNET®. All rights reserved.
//

#import "CBModel.h"

//全局状态信息，包含Session、登录用户等，此类为单例。
@implementation CBModel : NSObject

+ (CBModel *)sharedInstance
{
	static CBModel * global = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		global = [[self alloc] init];
	});
	return global;
}
@end









