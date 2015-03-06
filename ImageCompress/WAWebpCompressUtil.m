//
//  WAWebpcompressUtil.m
//  ChannelVisit
//
//  Created by KakaCompany on 20/1/15.
//  Copyright (c) 2015 yonyou. All rights reserved.
//

#import "WAWebpCompressUtil.h"
#import "WAImgCompressUtil.h"
#import "UIImage+WebP.h"

//默认画质，google官方建议画质
static CGFloat DEFAULTWEBPQUALITY = 0.75f;
//默认图片透明度
static CGFloat DEFAULTWEBPALPHA = 1.0f;

@implementation CWAWebpCompressUtil

#pragma mark 同步方式

#pragma mark towebp
+ (UIImage *)normCompressWithImage:(UIImage *)aImage
{
  NSData *normalComprssData = [CWAImgCompressUtil compressImageWAStyle:aImage];
  return [UIImage imageWithData:normalComprssData];
}

+ (NSData *)compressToWebpWithImage:(UIImage *)aImage
{
  UIImage *normCompressImage = [self normCompressWithImage:aImage];
  return [self compressToOnlyWebpWithImage:normCompressImage];
}

+ (NSData *)compressToWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality
{
  UIImage *normCompressImage = [self normCompressWithImage:aImage];
  return [self compressToWebpWithImage:normCompressImage withQuality:aQuality];
}

+ (NSData *)compressToWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality andAlpha:(CGFloat)aAlpha
{
  UIImage *normCompressImage = [self normCompressWithImage:aImage];
  return [self compressToWebpWithImage:normCompressImage withQuality:aQuality andAlpha:aAlpha];
}

+ (NSData *)compressToOnlyWebpWithImage:(UIImage *)aImage
{
  return [self compressToOnlyWebpWithImage:aImage withQuality:DEFAULTWEBPQUALITY andAlpha:DEFAULTWEBPALPHA];
}

+ (NSData *)compressToOnlyWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality
{
  return [self compressToOnlyWebpWithImage:aImage withQuality:aQuality andAlpha:DEFAULTWEBPALPHA];
}

+ (NSData *)compressToOnlyWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality andAlpha:(CGFloat)aAlpha
{
  return [UIImage imageToWebP:aImage quality:aQuality * 100 alpha:aAlpha];
}

#pragma mark fromwebp

+ (UIImage *)imageFromWebpWithData:(NSData *)aData
{
  return [UIImage imageWithWebPData:aData];
}

+ (UIImage *)imageFromWebpWithFile:(NSString *)aFile
{
  return [UIImage imageWithWebP:aFile];
}

#pragma mark 异步方式

#pragma mark towebp

+ (void)compressToWebpWithImage:(UIImage *)aImage withBlock:(TWAToWebpCompressReturnBlock)aBlock
{
  UIImage *normCompressImage = [self normCompressWithImage:aImage];
  [self compressToOnlyWebpWithImage:normCompressImage withBlock:aBlock];
}

+ (void)compressToWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality withBlock:(TWAToWebpCompressReturnBlock)aBlock
{
  UIImage *normCompressImage = [self normCompressWithImage:aImage];
  [self compressToOnlyWebpWithImage:normCompressImage withQuality:aQuality withBlock:aBlock];
}

+ (void)compressToWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality andAlpha:(CGFloat)aAlpha withBlock:(TWAToWebpCompressReturnBlock)aBlock
{
  UIImage *normCompressImage = [self normCompressWithImage:aImage];
  [self compressToOnlyWebpWithImage:normCompressImage withQuality:aQuality andAlpha:aAlpha withBlock:aBlock];
}

+ (void)compressToOnlyWebpWithImage:(UIImage *)aImage withBlock:(TWAToWebpCompressReturnBlock)aBlock
{
  [self compressToOnlyWebpWithImage:aImage withQuality:DEFAULTWEBPQUALITY andAlpha:DEFAULTWEBPALPHA withBlock:aBlock];
}

+ (void)compressToOnlyWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality withBlock:(TWAToWebpCompressReturnBlock)aBlock
{
  [self compressToOnlyWebpWithImage:aImage withQuality:aQuality andAlpha:DEFAULTWEBPALPHA withBlock:aBlock];
}

+ (void)compressToOnlyWebpWithImage:(UIImage *)aImage withQuality:(CGFloat)aQuality andAlpha:(CGFloat)aAlpha withBlock:(TWAToWebpCompressReturnBlock)aBlock
{
  [UIImage imageToWebP:aImage
               quality:aQuality *100
                 alpha:aAlpha
                preset:WEBP_PRESET_DEFAULT
       completionBlock:^(NSData *result)
   {
     aBlock(result,nil);
   }
          failureBlock:^(NSError *error)
   {
     aBlock(nil,error);
   }];
}

#pragma mark fromwebp

+ (void)imageFromWebpWithFile:(NSString *)aFile withBlock:(TWAFromWebpCompressReturnBlock)aBlock
{
  [UIImage imageWithWebP:aFile
         completionBlock:^(UIImage *result)
   {
     aBlock(result,nil);
   }
            failureBlock:^(NSError *error)
   {
     aBlock(nil,error);
   }];
}
@end
