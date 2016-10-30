//
//  XyCachesManager.h
//  Copyright © 2016年 Xydawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XyCachesManager : NSObject

@property (nonatomic,copy) NSString *cachesPath;

@property (nonatomic,copy) NSString *cachesDomName;

+(instancetype)shareXyCachesManager;
/**
 *  设置缓存路径
 *
 *  @param string 路径字符串
 */
+(NSString *)setCachesPath:(NSString *)string;
/**
 *  设置root文件夹名称,不设置有默认值
 *
 *  @param domName 文件夹名称
 */
+(void)setDomName:(NSString *)domName;
/**
 *  获取缓存大小
 *
 *  @return 缓存大小
 */
+ (double)getCachesSize ;
/**
 *  清楚缓存
 */
+(void)deletCachesSize;
/**
 *  存储至沙盒
 *
 *  @param dict     要储存的数据
 *  @param pathName 设置缓存路径
 *
 *  @return 缓存的沙盒路径
 */
+(NSString *)setNSDocumentDirectoryWith:(id)dict withPahtName:(NSString *)pathName;
/**
 *  从沙盒中获取数据
 *
 *  @param pathName 获取缓存的路径
 *
 *  @return 缓存的数据
 */
+(id)getNSDocumentDirectoryWithPahtName:(NSString *)pathName;

@end
