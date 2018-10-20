//
//  CBUtil.m
//  CarBusess
//
//  Created by 呵呵 on 2018/4/12.
//  Copyright © 2018年 呵呵. All rights reserved.
//

#import "CBUtil.h"

@implementation CBUtil

//判断手机号是否有效
+(BOOL)isValidatePhoneNumber:(NSString *)phoneNumber
{
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    
    if ([regexTestMobile evaluateWithObject:phoneNumber]) {
        
        return YES;
        
    }else {
        
        return NO;
    }
}
//判断是否是18位的身份证
+ (BOOL)isValidateCertNo:(NSString *)certNo
{
    BOOL retBool = [self isCertNo:certNo];
    
    if (retBool == YES) {
        if (certNo.length != 18) {
            retBool = NO;
        }
    }
    
    return retBool;
}
//判断是否是身份证
+ (BOOL)isCertNo:(NSString *)certNo
{
    NSString *realNameRegex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *realNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",realNameRegex];
    return [realNameTest evaluateWithObject:certNo];
}
//去除cell多余的线
+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}

+(NSMutableArray *)getAllProvinceAndCity
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"province_data" ofType:@"json"];
    NSData *cityData = [[NSData alloc]initWithContentsOfFile:path];
    NSDictionary *dictdata = [NSJSONSerialization JSONObjectWithData:cityData options:NSJSONReadingAllowFragments error:nil];
    for ( NSDictionary *dict in dictdata[@"province"]) {
        [array addObject:dict[@"provinceName"]];
        for (NSDictionary *dictCity in dict[@"cityList"]) {
            [array addObject:dictCity[@"cityName"]];
        }
    }
    return array;
}

@end
