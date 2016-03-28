//
//  FileManager.h
//  BuShangBanApp
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Info)(BOOL error, NSString *info);

@interface FileManager : NSObject

+ (void)saveFileWithFile:(id)file fileName:(NSString *)fileName path:(NSString *)path info:(Info)info;

+ (NSString *)documentPathWithFileName:(NSString *)fileName;

+ (UIImage *)searchFileWithFileName:(NSString *)fileName type:(NSString *)type;

+ (void)archiverObject:(id)Obj key:(NSString *)key fileName:(NSString *)fileName;

+ (instancetype)unarchiverWithKey:(NSString *)key fileName:(NSString *)fileName;

+ (void)upLoadDataToSeverWithURL:(NSString *)url post:(BOOL)post dic:(NSDictionary *)dic infor:(Info)info;
@end
