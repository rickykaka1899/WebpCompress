/*!
 @header	WAWebpcompressUtil.h
 @abstract  图片转换为webp格式util，以及将webp格式图片转换为UIImage
 @discussion
 @author	houlzh
 @copyright	yonyou
 @version	1.0 2015-01-20 13:17:54 Creation
 */

/**
 使用说明：
 1.提供了两套实现方案，同步和异步方式
 2.两套方案中分别实现了将UIImage转换为webp和将webp转换为UIImage
 3.两套方案中，将UIImage转换为webp格式提供了两套api，分别是：
  1）经过已有的压缩方案(CWAImgCompressUtil)后，再转换为webp格式
  2）原图片直接转换为webp格式
 4.两套方案中，将UIImage转换为webp格式时，可以设置图片的画质和透明度，默认分别为1.0，1.0
 5.采用异步方案实现时，需要实现block
 **/

#import <Foundation/Foundation.h>

/*!
 	@abstract	webp异步压缩block
 	@discussion
 	@param 	 	result  返回压缩data  
  @param    error   错误信息
 */
typedef void  (^TWAToWebpCompressReturnBlock) (NSData *resultData, NSError *error);
/*!
 	@abstract	读取webp格式图片block
 	@discussion
  @param 	 	result webp格式返回image
  @param    error   错误信息
 */
typedef void  (^TWAFromWebpCompressReturnBlock) (UIImage *returnImage, NSError *error);

@interface CWAWebpCompressUtil : NSObject

#pragma mark 同步方式
#pragma mark 图片压缩后转换为webp格式

/*!
 	@method
 	@abstract	图片先压缩，然后转换为webp格式，默认画质0.75和透明度1.0
            有损压缩
 	@discussion
 	@param 	aImage  需要压缩的原图片
 	@result 转换为webp格式后的二进制流，返回值不需要释放
 */
+ (NSData *)compressToWebpWithImage:(UIImage *)aImage;

/*!
 	@method
  @abstract	图片先压缩，然后转换为webp格式，默认透明度1.0，可变画质
            有损压缩
 	@discussion
 	@param 	aImage 	需要压缩的原图片
 	@param 	aQuality 	画质，范围0.0-1.0
 	@result	转换为webp格式后的二进制流，返回值不需要释放
 */
+ (NSData *)compressToWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality;

/*!
 	@method
  @abstract	图片先压缩，然后转换为webp格式，默认透明度1.0，可变画质
            有损压缩
 	@discussion
 	@param 	aImage 	需要压缩的原图片
 	@param 	aQuality 	画质，范围0.0-1.0
 	@param 	aAlpha 	透明度，范围0.0-1.0
 	@result	转换为webp格式后的二进制流，返回值不需要释放
 */
+ (NSData *)compressToWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality andAlpha:(CGFloat)aAlpha;

#pragma mark 原图转换为webp格式
/*!
 @method
 @abstract	图片直接转换为webp格式，默认画质0.75和透明度1.0
 有损压缩
 @discussion
 @param 	aImage  需要压缩的原图片
 @result 转换为webp格式后的二进制流，返回值不需要释放
 */
+ (NSData *)compressToOnlyWebpWithImage:(UIImage *)aImage;
/*!
 @method
 @abstract	图片直接转换为webp格式，默认透明度1.0，可变画质
 有损压缩
 @discussion
 @param 	aImage 	需要压缩的原图片
 @param 	aQuality 	画质，范围0.0-1.0
 @result	转换为webp格式后的二进制流，返回值不需要释放
 */
+ (NSData *)compressToOnlyWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality;
/*!
 @method
 @abstract	图片直接转换为webp格式，默认透明度1.0，可变画质
 有损压缩
 @discussion
 @param 	aImage 	需要压缩的原图片
 @param 	aQuality 	画质，范围0.0-1.0
 @param 	aAlpha 	透明度，范围0.0-1.0
 @result	转换为webp格式后的二进制流，返回值不需要释放
 */
+ (NSData *)compressToOnlyWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality andAlpha:(CGFloat)aAlpha;

#pragma mark webp格式图片读取
/*!
 @method
 @abstract	将二进制data流的webp格式转换为UIImage
 @discussion
 @param 	aData 	webp格式图片二进制流
 @result	UIImage格式，返回值不需要释放
 */
+ (UIImage *)imageFromWebpWithData:(NSData *)aData;

/*!
 @method
 @abstract	将文件中的webp格式图片转换为UIImage
 @discussion
 @param 	aFile 	webp格式图片文件路径
 @result	UIImage格式，返回值不需要释放
 */
+ (UIImage *)imageFromWebpWithFile:(NSString *)aFile;

#pragma mark 异步方式

#pragma mark 图片压缩后转换为webp格式
/*!
 @method
 @abstract	图片先压缩，然后转换为webp格式，默认透明度1.0，默认画质1.0
 @discussion
 @param 	aImage 	需要压缩的图片
 @param 	aBlock 	异步请求block
 @result
 */
+ (void)compressToWebpWithImage:(UIImage *)aImage
                          withBlock:(TWAToWebpCompressReturnBlock)aBlock;

/*!
 @method
 @abstract	图片先压缩，然后转换为webp格式，默认透明度1.0，画质可变
 @discussion
 @param 	aImage 	需要压缩的图片
 @param 	aQuality 	画质
 @param 	aBlock 	异步请求block
 @result
 */
+ (void)compressToWebpWithImage:(UIImage *)aImage
                        withQuality:(CGFloat)aQuality
                          withBlock:(TWAToWebpCompressReturnBlock)aBlock;


/*!
 @method
 @abstract	图片先压缩，然后转换为webp格式，透明度可变，画质可变
 @discussion
 @param 	aImage 	需要压缩的图片
 @param 	aQuality 	画质
 @param 	aAlpha 	透明度
 @param 	aBlock 	异步请求block
 @result
 */
+ (void)compressToWebpWithImage:(UIImage *)aImage
                        withQuality:(CGFloat)aQuality
                           andAlpha:(CGFloat)aAlpha
                          withBlock:(TWAToWebpCompressReturnBlock)aBlock;

#pragma mark 原图转换为webp格式
/*!
 	@method
 	@abstract	图片直接转换为webp格式，默认透明度1.0，默认画质1.0
 	@discussion
 	@param 	aImage 	需要压缩的图片
 	@param 	aBlock 	异步请求block
 	@result
 */
+ (void)compressToOnlyWebpWithImage:(UIImage *)aImage
                          withBlock:(TWAToWebpCompressReturnBlock)aBlock;

/*!
 	@method
 	@abstract	图片直接转换为webp格式，默认透明度1.0，画质可变
 	@discussion
 	@param 	aImage 	需要压缩的图片
 	@param 	aQuality 	画质
 	@param 	aBlock 	异步请求block
 	@result
 */
+ (void)compressToOnlyWebpWithImage:(UIImage *)aImage
                        withQuality:(CGFloat)aQuality
                          withBlock:(TWAToWebpCompressReturnBlock)aBlock;


/*!
 	@method
 	@abstract	图片直接转换为webp格式，透明度可变，画质可变
 	@discussion
 	@param 	aImage 	需要压缩的图片
 	@param 	aQuality 	画质
 	@param 	aAlpha 	透明度
 	@param 	aBlock 	异步请求block
 	@result
 */
+ (void)compressToOnlyWebpWithImage:(UIImage *)aImage
                        withQuality:(CGFloat)aQuality
                           andAlpha:(CGFloat)aAlpha
                          withBlock:(TWAToWebpCompressReturnBlock)aBlock;


#pragma mark webp格式图片读取
/*!
 @method
 @abstract	将二进制data流的webp格式转换为UIImage
 @discussion
 @param 	aData 	webp格式图片二进制流
 @result	UIImage格式，返回值不需要释放
 */
+ (void)imageFromWebpWithFile:(NSString *)aFile
                    withBlock:(TWAFromWebpCompressReturnBlock)aBlock;

@end
