//
//  NSObject+LYExtension.m
//  Tea
//
//  Created by liyang on 16/9/5.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "NSObject+LYExtension.h"
#import <objc/runtime.h>

@implementation NSObject (LYExtension)

+ (instancetype)objectWithDictionary:(NSDictionary *)dic
{
    id objc = [[self alloc] init];
    
    // 获取所有的成员变量属性
    unsigned int count;
    
    Ivar *ivars = class_copyIvarList(self, &count);
    
    for (unsigned int i = 0; i < count; i++)
    {
        Ivar ivar = ivars[i];
        
        // 取出成员变量属性(这时候的成员变量是带下划线的,这时候我们在做一步，去掉下划线)
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [ivarName substringFromIndex:1];
        
        // 取出字典中对应的值
        id value = dic[key];
        
        // 如果这个value是nil，执行下`replacedKeyFromPropertyName`，看看是否执行过这个代理，替换了原来的key值
        if (!value)
        {
            if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)])
            {
                // 拿到数组中真实的key
                NSString *replaceKey = [[self replacedKeyFromPropertyName] objectForKey:key];
                // 通过这个key，拿到真实值
                value = [dic objectForKey:replaceKey];
            }
        }
        
        
        // 字典嵌套字典
        if ([value isKindOfClass:[NSDictionary class]])
        {
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            NSRange range = [type rangeOfString:@"\""];
            type = [type substringFromIndex:range.location + range.length];
            range = [type rangeOfString:@"\""];
            type = [type substringToIndex:range.location];
            Class modelClass = NSClassFromString(type);
            
            if (modelClass)
            {
                value = [modelClass objectWithDictionary:value];
            }
        }
        
        // 字典嵌套数组
        if ([value isKindOfClass:[NSArray class]])
        {
            if ([self respondsToSelector:@selector(objectClassInArray)])
            {
                NSMutableArray *models = [NSMutableArray array];
                
                NSString *type = [[self objectClassInArray] objectForKey:key];
                Class classModel = NSClassFromString(type);
                for (NSDictionary *dict in value)
                {
                    id model = [classModel objectWithDictionary:dict];
                    [models addObject:model];
                }
                value = models;
            }
        }
        
        // 赋值
        if (value)
        {
            [objc setValue:value forKey:key];
        }
        
    }
    
    // 释放ivars
    free(ivars);
    
    return objc;
}

@end
