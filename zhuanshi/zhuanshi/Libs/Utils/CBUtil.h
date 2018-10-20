//
//  CBUtil.h
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import <Foundation/Foundation.h>
//在项目中补充公共方法
@interface CBUtil : NSObject
//判断是否是手机号
/**
 *@brief  验证是否是手机号 以13 14 15 17 18开头的有效
 *@result BOOL
 */
+(BOOL)isValidatePhoneNumber:(NSString *)phoneNumber;

//判断是否是18位的身份证
/**
 *@brief  验证是否是18位的身份证 只支持18位的

 *@result BOOL
 */
+ (BOOL)isValidateCertNo:(NSString *)certNo;

//判断是否是身份证
/**
 *@brief  验证是否是身份证
  *@result BOOL
 */
+ (BOOL)isCertNo:(NSString *)certNo;

//去除cell多余的线
/**
 *@brief  去除cell多余的线
 *@result void
 */
+(void)setExtraCellLineHidden: (UITableView *)tableView;

//获取全国所有的省和市
/**
 *@brief  获取全国所有的省和市
 *@result NSMutableArray
 */
+(NSMutableArray *)getAllProvinceAndCity;

@end
