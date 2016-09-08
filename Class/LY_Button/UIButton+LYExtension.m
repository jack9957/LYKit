//
//  UIButton+LYExtension.m
//  新工程
//
//  Created by liyang on 16/8/25.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "UIButton+LYExtension.h"
#import <objc/runtime.h>

static NSString *const kIndicatorViewKey = @"indicatorView";
static NSString *const kButtonTextObjectKey = @"buttonTextObject";

@implementation UIButton (LYExtension)

// 展示indicator
- (void)lyShowIndicator
{
    UIActivityIndicatorView *indicator =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [indicator startAnimating];
    
    NSString *currentButtonText = self.titleLabel.text;
    
    objc_setAssociatedObject(self, &kButtonTextObjectKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &kIndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
    [self addSubview:indicator];
}

// 隐藏indicator
- (void)lyHideIndicator
{
    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, &kButtonTextObjectKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &kIndicatorViewKey);
    
    [indicator removeFromSuperview];
    [self setTitle:currentButtonText forState:UIControlStateNormal];
    self.enabled = YES;
}

/**
 *  设置button中图片的位置
 *
 *  @param imagePosition 枚举类型，设置button中图片的位置
 *  @param spacing       图片和文字的间距
 */
- (void)lyButtonImageAtPosition:(LYButtonImagePosition)imagePosition  labelSpacing:(CGFloat)spacing
{
    CGSize titleSize    = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName : self.titleLabel.font}];
    CGSize imageSize    = self.imageView.image.size;
    CGFloat insetAmount = spacing / 2.0;
    
    if (self) {
        switch (imagePosition)
        {
            case LYButtonImagePositionLeft :
            {
                self.imageEdgeInsets   = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
                self.titleEdgeInsets   = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
                self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
            }
                break;
                
            case LYButtonImagePositionRight :
            {
                self.titleEdgeInsets   = UIEdgeInsetsMake(0, -(imageSize.width + insetAmount), 0, imageSize.width + insetAmount);
                self.imageEdgeInsets   = UIEdgeInsetsMake(0, titleSize.width + insetAmount, 0, -(titleSize.width + insetAmount));
                self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
            }
                break;
                
            case LYButtonImagePositionTop :
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width);
            }
                break;
                
            case LYButtonImagePositionBottom :
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(imageSize.height + spacing), -imageSize.width, 0, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0.0, -(titleSize.height + spacing), -titleSize.width);
            }
                break;
                
            default :
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * spacing, 0, -2 * spacing);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
                break;
        }
    }
}


@end
