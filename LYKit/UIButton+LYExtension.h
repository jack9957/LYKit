//
//  UIButton+LYExtension.h
//  新工程
//
//  Created by liyang on 16/8/25.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, LYButtonImagePosition)
{
    LYButtonImagePositionLeft = 1,
    LYButtonImagePositionRight,
    LYButtonImagePositionTop,
    LYButtonImagePositionBottom
};

@interface UIButton (LYExtension)

/** 展示标识符 */
- (void)lyShowIndicator;
/** 隐藏标识符 */
- (void)lyHideIndicator;

/**
 *  设置button中图片的位置
 *
 *  @param imagePosition 枚举类型，设置button中图片的位置
 *  @param spacing       图片和文字的间距
 */
- (void)lyButtonImageAtPosition:(LYButtonImagePosition)imagePosition  labelSpacing:(CGFloat)spacing;
@end
