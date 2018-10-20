//
//  Utils.h
//  jinRong
//
//  Created by zym on 15/12/31.
//  Copyright © 2015年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CommonCrypto/CommonDigest.h>
@interface Utils : NSObject

/**
 *  手机号码验证
 *
 *  @param MobileNumber 要验证的字符串
 *
 *  @return 是否为正确的手机格式
 */
+ (BOOL) validateMobile:(NSString *)MobileNumber;
/**
 *  邮箱验证
 *
 *  @param email 要验证的邮箱
 *
 *  @return 验证结果
 */
+ (BOOL) validateEmail:(NSString *)email;
/**
 *  身份证号验证
 *
 *  @param userID 要验证的身份证号
 *
 *  @return 验证结果
 */
+ (BOOL) validateIdentityCard: (NSString *)userID;
/**
 *  护照验证
 *
 *  @param passport 要验证的护照号
 *
 *  @return 验证结果
 */
+ (BOOL) validatePassport:(NSString *)passport;
/**
 *  港澳通行证验证
 *
 *  @param hkmacao 要验证的港澳通行证号
 *
 *  @return 验证结果
 */
+ (BOOL) validateHKMaCao:(NSString *)hkmacao;
/**
 *  台湾通行证验证
 *
 *  @param taiWan 要验证的台湾通行证号
 *
 *  @return 验证结果
 */
+ (BOOL) validateTaiWan:(NSString *)taiWan;
/**
 *  银行卡号
 *
 *  @param cardNo 要验证的银行卡号
 *
 *  @return 验证结果
 */
+ (BOOL) validateBankCardNumber:(NSString*) cardNo;
/**
 *  价格格式
 *
 *  @param price 要验证的价格
 *
 *  @return 验证结果
 */
+ (BOOL) validatePrice:(NSString*)price;
/**
 *  价格加逗号
 *
 *  @param string 要加逗号的字符串
 *
 *  @return 加完逗号的字符串
 */
+ (NSString *) addSeparatorForPriceString:(NSString *)string;
/**
 *  根据图片url获取图片尺寸(jpg.png.gif)
 *
 *  @param imageURL 图片地址
 *
 *  @return 图片的size
 */
+ (CGSize) getImageSizeWithURL:(id)imageURL;
/**
 *  给手机号中间四位加‘*’
 *
 *  @param phone 手机号
 *
 *  @return 加完‘*’的手机号
 */
+ (NSString *) addStarWithPhone:(NSString *)phone;
/**
 *  正则匹配用户密码6-18位数字和字母组合
 *
 *  @param password 要验证的密码
 *
 *  @return 验证结果
 */
+ (BOOL) checkPassword:(NSString *) password;
/**
 *  正则匹配用户密码1-10为由数字，字母汉字或者下划线组成
 *
 *  @param nickName 要验证的名称
 *
 *  @return 验证结果
 */
+ (BOOL) checkNickName:(NSString *) nickName;
/**
 *  md5加密
 *
 *  @param input 要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *) md5:(NSString *) input;
/**
 *  url编码
 *
 *  @param input 要编码的字符串
 *
 *  @return 编码后的字符串
 */
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;
/**
 *  url解码
 *
 *  @param input 要解码的字符串
 *
 *  @return 解码后的字符串
 */
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

+ (float)getTextheightWithString:(NSString *)string width:(CGFloat)width withfont:(NSInteger)fontsize;
+ (float)getTextWidthWithString:(NSString *)string width:(CGFloat)width withfont:(NSInteger)fontsize;
+ (CGFloat)tabbarHeight;
+ (CGFloat)noTabbarHeight;
@end
