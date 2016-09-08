//
//  NSObject+LYExtension.h
//  Tea
//
//  Created by liyang on 16/9/5.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYKeyValue <NSObject>

@optional

/**
 *  数组中需要转换的模型类
 *
 *  @return key:数组名 value:模型Class名 (比如:@"personArray":@"Person")
 */
+ (NSDictionary *)objectClassInArray;

/**
 *  处理和系统关键字冲突的自定义key
 *
 *  @return key:自定义的key名 value:和系统冲突的key名 (@"p_id":@"id")
 */
+ (NSDictionary *)replacedKeyFromPropertyName;

@end




@interface NSObject (LYExtension)<LYKeyValue>

/**
 *  模型快速赋值，可以解决的问题有：1、数据字典中嵌套模型（直接使用就可以） 2、数据字典中有和系统关键字冲突的key（需要遵循代理） 3、数据字典中嵌套数组（需要遵循代理）
 *
 *  @param dic 数据
 *
 *  @return 返回赋值好的模型
 */
+ (instancetype)objectWithDictionary:(NSDictionary *)dic;

@end
