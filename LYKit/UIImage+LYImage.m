//
//  UIImage+LYImage.m
//  LYImageTool
//
//  Created by liyang on 16/9/4.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "UIImage+LYImage.h"

@implementation UIImage (LYImage)

/**
 *  图片保存到沙盒
 *
 *  @param img      要保存的图片
 *  @param saveName 保存的名字(如： imageName1)
 *
 *  @return 结果
 */
+ (BOOL)LYImageSaveImg:(UIImage *)img imgSaveName:(NSString *)saveName
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 指定图片存储路径
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",saveName]];
    
    NSLog(@"路径是: %@",path);
    
    BOOL result = [UIImageJPEGRepresentation(img, 1.0f) writeToFile:path atomically:YES];
    
    return result;
}

/**
 *  可以根据图片名获取没被渲染过的原图
 *
 *  @param imgName 图片名称
 *
 *  @return 返回一个没有被渲染的图片
 */
+ (instancetype)LYImageGetOriginalImgWithImageName:(NSString *)imgName
{
    UIImage *img = [UIImage imageNamed:imgName];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}

/**
 *  图片拉伸
 *
 *  @param stretchableImage 要被拉伸的图片
 *
 *  @return 拉伸好的图片
 */
+ (instancetype)LYImageStretchableImage:(UIImage *)stretchableImage
{
    return [stretchableImage stretchableImageWithLeftCapWidth:stretchableImage.size.width*0.5 topCapHeight:stretchableImage.size.height*0.5];
}

/**
 *  图片的压缩
 *
 *  @param img   要被压缩的图片
 *  @param width 压缩图片到的宽度
 *
 *  @return 被压缩的图片（体积明显变小，清晰度尽量保持清晰）
 */
+ (instancetype)LYImageCompressImg:(UIImage *)sourceImage toWidth:(CGFloat)targetWidth
{
    // 1、对图片进行"缩"处理
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 2、对图片进行压处理
    UIImage *resultImg = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, 0.3f)];
    
    // 3、返回结果
    return resultImg;
}

/**
 *  图片水印功能
 *
 *  @param waterMark     水印(现在只支持：文字或者图片)
 *  @param waterMarkRect 位置
 *
 *  @return 带水印的图片
 */
+ (instancetype)LYImage:(UIImage *)bjImg WaterMark:(id)waterMark toLocation:(WaterMarkLocation)waterMarkLocation
{
    // 1、创建图片的上下文
    UIGraphicsBeginImageContextWithOptions(bjImg.size, NO, 0.0f);
    
    // 2、画背景
    [bjImg drawInRect:CGRectMake(0, 0, bjImg.size.width, bjImg.size.height)];
    
    // 3、拿到水印的size
    CGSize markSize; // 水印的size
    NSDictionary *attr; // 水印如果是文字的话，属性
    CGFloat margin = 10; // 间隔
    
    if ([waterMark isKindOfClass:[NSString class]]) {
        // 3-1、设置字体的属性，这个地方一般会是固定处理的
        NSString *mark = waterMark;
        attr = @{
                 NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f],
      NSForegroundColorAttributeName: [UIColor redColor]
                               };
        // 3-2、获取文字的size
        markSize = [mark boundingRectWithSize:CGSizeMake(999, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    }else if ([waterMark isKindOfClass:[UIImage class]]){
        // 3-3、获取图片的size
        UIImage *waterImg = waterMark;
        markSize = waterImg.size;
        attr = nil;
        if (waterImg.size.height > bjImg.size.height || waterImg.size.width > bjImg.size.width) {
            NSLog(@"水印图片不能比原图大");
            return nil;
        }
    }else{
        //
        NSLog(@"未知类型");
    }
    
    // 4、确定位置
    CGRect waterRect;
    
    switch (waterMarkLocation) {
        case Middle:
        {
            CGFloat waterX = (bjImg.size.width - markSize.width) / 2;
            CGFloat waterY = bjImg.size.height - markSize.height - margin;
            
            waterRect = CGRectMake(waterX, waterY, markSize.width, markSize.height);
        }
            break;
        case LeftBottom:
        {
            CGFloat waterX = margin;
            CGFloat waterY = bjImg.size.height - markSize.height - margin;
            
            waterRect = CGRectMake(waterX, waterY, markSize.width, markSize.height);
        }
            break;
        case RightBottom:
        {
            CGFloat waterX = bjImg.size.width - markSize.width - margin;
            CGFloat waterY = bjImg.size.height - markSize.height - margin;
            
            waterRect = CGRectMake(waterX, waterY, markSize.width, markSize.height);
        }
            break;
            
        default:
            break;
    }
    
    // 5、渲染
    if ([waterMark isKindOfClass:[NSString class]]) {
        
        [waterMark drawInRect:waterRect withAttributes:attr];
        
    }else if ([waterMark isKindOfClass:[UIImage class]]){
        
        [waterMark drawInRect:waterRect];
        
    }
    
    // 6、获取上下文
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7、结束
    UIGraphicsEndImageContext();
    
    return result;
}

/**
 *  裁剪图片
 *
 *  @param originalImg 要被裁剪的图片
 *  @param cutRect     要截取的尺寸（基于当前屏幕）
 *
 *  @return 裁剪好的图片
 */
+ (instancetype)LYImageCutImage:(UIImage *)originalImg cutRect:(CGRect)cutRect
{
    CGFloat scale = [UIScreen mainScreen].scale;
    cutRect = CGRectMake(scale * cutRect.origin.x, scale * cutRect.origin.y, scale * cutRect.size.width, scale * cutRect.size.height);
    // 拿到图片
    CGImageRef imageRef = originalImg.CGImage;
    // 根据截图区域拿到小图片
    CGImageRef smallImageRef = CGImageCreateWithImageInRect(imageRef, cutRect);
    // 截图的大小
    CGSize cutSize = cutRect.size;
    // 创建位图
    UIGraphicsBeginImageContextWithOptions(cutSize, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, cutRect, smallImageRef);
    
    
    UIImage *smallImg = [UIImage imageWithCGImage:smallImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(smallImageRef);
    
    return smallImg;
}

/**
 *  屏幕截图
 *
 *  @param shotView 要被截屏的view
 *
 *  @return 结果
 */
+ (instancetype)LYImageShotImgView:(UIView *)shotView
{
    UIGraphicsBeginImageContextWithOptions(shotView.frame.size, NO, 0.0);
    
    [shotView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  裁剪圆形图片
 *
 *  @param image 要裁剪的图片名
 *
 *  @return 裁剪完成的图片
 */
+ (instancetype)LYImageWithClipImage:(UIImage *)image
{
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    //画圆：正切于上下文
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //设为裁剪区域
    [path addClip];
    //画图片
    [image drawAtPoint:CGPointZero];
    //生成一个新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  裁剪图片的四个边角
 *
 *  @param image  要被裁剪的图片
 *  @param corner 要被修正的尺寸大小（一般写5）
 *
 *  @return 裁剪图片的四个边角
 */
+ (instancetype)LYImageWithClipImage:(UIImageView *)imageView corner:(CGFloat)corner
{
    CALayer *layer = [CALayer layer];
    layer.frame = imageView.bounds;
    
    UIBezierPath *path;
    path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, 0)];
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.bounds = imageView.bounds;
    shape.path = path.CGPath;
    shape.position = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
    [layer addSublayer:shape];
    
    imageView.layer.mask = layer;
    
    return imageView.image;
}

/**
 *  给图片设置阴影效果
 *
 *  @param shadowImage 要被设置阴影的图片
 *  @param shadowColor 阴影的颜色（一般是黑色）
 *
 *  @return 设置好阴影效果的图片
 */
+ (instancetype)LYImageWithShadowImage:(UIImageView *)shadowImage
{
    shadowImage.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    shadowImage.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    shadowImage.layer.shadowOpacity = 0.6;//阴影透明度，默认0
    shadowImage.layer.shadowRadius = 3;//阴影半径，默认3
    
    return shadowImage.image;
}
@end
