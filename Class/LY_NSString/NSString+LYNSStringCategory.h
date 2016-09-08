//
//  NSString+LYNSStringCategory.h
//  LYNSStringCategory
//
//  Created by liyang on 16/3/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LYNSStringCategory)

/**
 *  利用正则表达式获取url中的参数对应的值
 *
 *  @param CS         url中需要解析的参数key
 *  @param webaddress url
 *
 *  @return key对应的value值
 */
+ (instancetype)stringResolutionUrlStr:(NSString *)webaddress WithKey:(NSString *)CS;

/**
 *  时间戳转年龄
 *
 *  @param totoal 时间戳
 *
 *  @return 年龄string类型
 */
+ (instancetype)stringGetAgeByTime:(long)totoal;

/**
 *  时间戳转星座
 *
 *  @param totoal 传入的时间戳
 *
 *  @return 返回结果字符串
 */
+ (instancetype)getConstellationByTime:(long)totoal;

/**
 *  判断字符串中是否有中文
 *
 *  @param str 输入字符串
 *
 *  @return 返回一个bool值
 */
+ (BOOL)stringIsContainChineseWithStr:(NSString *)str;

/**
 *  判断是否是QQ号
 *
 *  @return bool
 */
- (BOOL)stringIsQQNumber;

/**
 *  判断是否是手机号
 *
 *  @return bool
 */
- (BOOL)stringIsPhoneNumber;

/**
 *  判断是否是数字
 *
 *  @return bool
 */
- (BOOL)stringIsNumber;

/**
 *  判断是否是邮箱号
 *
 *  @return 结果
 */
- (BOOL)stringIsValidEmail;

/** 车牌号验证 */
- (BOOL)stringIsValidCarNo;

/** 网址验证 */
- (BOOL)stringIsValidUrl;

/** 邮政编码 */
- (BOOL)isValidPostalcode;


/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/** 去掉两端空格和换行符 */
- (NSString *)stringByTrimmingBlank;

/** 去掉html格式 */
- (NSString *)removeHtmlFormat;

/** 工商税号 */
- (BOOL)isValidTaxNo;

/**
 *  md5加密
 *
 *  @param str 要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (instancetype)stringWithMD5:(NSString *)str;

/**
 *  sha1加密
 *
 *  @param str 要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (instancetype)stringWithsha1:(NSString *)str;


/**
 *  获取客户端网络IP
 *
 *  @return 返回客户端网络IP
 */
+ (instancetype)stringWithIP;

/**
 *  生成任意长度的随机数
 *
 *  @param bit 长度
 *
 *  @return 随机数
 */
+ (instancetype)stringWithRandomBit:(NSInteger)bit;

/**
 *  返回url能识别的字符串
 */
- (instancetype)stringWithUTF8:(NSString *)urlStr;

@end
