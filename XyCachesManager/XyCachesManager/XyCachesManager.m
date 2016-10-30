//
//  XyCachesManager.m
//  Copyright © 2016年 Xydawn. All rights reserved.
//

#import "XyCachesManager.h"

@implementation XyCachesManager

+(instancetype)shareXyCachesManager{
    
    static XyCachesManager *cahes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cahes = [[XyCachesManager alloc]init];
        cahes.cachesDomName = @"XyMyCaches";
    });
    return cahes;
}

+(void)setDomName:(NSString *)domName{
    
    [XyCachesManager shareXyCachesManager].cachesDomName = domName;
    
}

+(NSString *)setCachesPath:(NSString *)string{
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *domName = [XyCachesManager shareXyCachesManager].cachesDomName;

    
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:domName];
    //检测MyCaches 文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:myCacheDirectory]) {
        //不存在 那么创建
        [[NSFileManager defaultManager] createDirectoryAtPath:myCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Library/Caches/%@",domName]];
    
    [XyCachesManager shareXyCachesManager].cachesPath = path;
    
    return [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",string]];

}

+ (double)getCachesSize {
    //换算为M
    //获取SD 字节大小
//    double sdSize = [[SDImageCache sharedImageCache] getSize];
    //获取自定义的缓存
    NSString *domName = [XyCachesManager shareXyCachesManager].cachesDomName;
    
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/%@",domName];
    //遍历 文件夹 得到一个枚举器
    NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
    double mySize = 0;
    for (NSString *fileName in enumerator) {
        //获取文件的路径
        NSString *filePath = [myCachePath stringByAppendingPathComponent:fileName];
        //文件属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        //统计大小
        mySize += dict.fileSize;
    }
    
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSAllDomainsMask, YES);
    NSString *path = [arr objectAtIndex:0];
    NSDirectoryEnumerator * enumerator1 = [[NSFileManager defaultManager] enumeratorAtPath:path];
    for (NSString *fileName in enumerator1) {
        //获取文件的路径
        NSString *filePath = [myCachePath stringByAppendingPathComponent:fileName];
        //文件属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        //统计大小
        mySize += dict.fileSize;
    }

    //1M = 1024k = 1024*1024Byte
//    double totalSize = (mySize+sdSize)/1024/1024;//转化为M
    double totalSize = (mySize)/1024.0/1024.0;
    return totalSize;
}

+(void)deletCachesSize {
    NSString *domName = [XyCachesManager shareXyCachesManager].cachesDomName;
//    [[SDImageCache sharedImageCache] clearMemory];
    //清除磁盘上的图片缓存
//    [[SDImageCache sharedImageCache] clearDisk];
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/%@",domName];
    [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSAllDomainsMask, YES);
    NSString *path1 = [arr objectAtIndex:0];
    [[NSFileManager defaultManager]removeItemAtPath:path1 error:nil];

}


//存储数据到 NSDocumentDirectory
+(NSString *)setNSDocumentDirectoryWith:(id)dict withPahtName:(NSString *)pathName{
    //先获取 沙盒中的Library/Caches/路径
    
    NSString *path = [XyCachesManager setCachesPath:pathName];
    NSData *data=[[NSData alloc]init];
    data=[NSKeyedArchiver archivedDataWithRootObject:dict];
    [data writeToFile:path atomically:YES];
    return path;
}
//读取数据到 NSDocumentDirectory
+(id)getNSDocumentDirectoryWithPahtName:(NSString *)pathName{
    NSString *path = [XyCachesManager setCachesPath:pathName];
    NSData *data1=[NSData dataWithContentsOfFile:path];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data1];
}




@end
