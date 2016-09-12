//
//  UIImage+LYImage.h
//  LYImageTool
//
//  Created by liyang on 16/9/4.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WaterMarkLocation) {
    Middle,
    RightBottom,
    LeftBottom
};


@interface UIImage (LYImage)


/**
 *  图片保存
 *
 *  @param img      要保存的图片
 *  @param saveName 保存的名字
 *
 *  @return 结果
 */
+ (BOOL)LYImageSaveImg:(UIImage *)img imgSaveName:(NSString *)saveName;

/**
 *  可以根据图片名获取没被渲染过的原图
 *
 *  @param imgName 图片名称
 *
 *  @return 返回一个没有被渲染的图片
 */
+ (instancetype)LYImageGetOriginalImgWithImageName:(NSString *)imgName;

/**
 *  图片拉伸
 *
 *  @param stretchableImage 要被拉伸的图片
 *
 *  @return 拉伸好的图片
 */
+ (instancetype)LYImageStretchableImage:(UIImage *)stretchableImage;

/**
 *  图片的压缩
 *
 *  @param img   要被压缩的图片
 *  @param width 压缩图片到的宽度
 *
 *  @return 被压缩的图片（体积明显变小，清晰度尽量保持清晰）
 */
+ (instancetype)LYImageCompressImg:(UIImage *)sourceImage toWidth:(CGFloat)targetWidth;

/**
 *  图片水印功能
 *
 *  @param waterMark     水印(现在只支持：文字或者图片)
 *  @param waterMarkRect 位置
 *
 *  @return 带水印的图片
 */
+ (instancetype)LYImage:(UIImage *)bjImg WaterMark:(id)waterMark toLocation:(WaterMarkLocation)waterMarkLocation;

/**
 *  裁剪图片
 *
 *  @param originalImg 要被裁剪的图片
 *  @param cutRect     要截取的尺寸（基于当前屏幕）
 *
 *  @return 裁剪好的图片
 */
+ (instancetype)LYImageCutImage:(UIImage *)originalImg cutRect:(CGRect)cutRect;


/**
 *  屏幕截图
 *
 *  @param shotView 要被截屏的view
 *
 *  @return 结果
 */
+ (instancetype)LYImageShotImgView:(UIView *)shotView;

/**
 *  裁剪圆形图片
 *
 *  @param image 要裁剪的图片名
 *
 *  @return 裁剪完成的图片
 */
+ (instancetype)LYImageWithClipImage:(UIImage *)image;

/**
 *  裁剪图片的四个边角
 *
 *  @param image  要被裁剪的图片
 *  @param corner 要被修正的尺寸大小（一般写5）
 *
 *  @return 裁剪图片的四个边角
 */
+ (instancetype)LYImageWithClipImage:(UIImageView *)imageView corner:(CGFloat)corner;

/**
 *  给图片设置阴影效果
 *
 *  @param shadowImage 要被设置阴影的图片
 *  @param shadowColor 阴影的颜色（一般是黑色）
 *
 *  @return 设置好阴影效果的图片
 */
+ (instancetype)LYImageWithShadowImage:(UIImageView *)shadowImage;

@end
