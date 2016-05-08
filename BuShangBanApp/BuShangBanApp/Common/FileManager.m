//
//  FileManager.m
//
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "FileManager.h"
#import <AFNetworking.h>

const NSString *fileWriteLocalSucess = @"fileWriteLocalSucess";
const NSString *fileWriteLocalNotSucess = @"fileWriteLocalNotSucess";
const NSString *filePathNotFound = @"filePathNotFound";
const NSString *filePathFound = @"filePathFound";

const NSString *fileWriteSeverSucess = @"fileWriteSeverSucess";
const NSString *fileWriteSeverNotSucess = @"fileWriteSeverNotSucess";

@interface FileManager ()

@end

@implementation FileManager

static FileManager *fileManagerInstance = nil;

- (FileManager *)shareManager {
    static FileManager *fileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileManager = [[FileManager alloc] init];
    });
    return fileManager;
}

+ (void)saveFileWithFile:(id)file fileName:(NSString *)fileName path:(NSString *)path info:(Info)info {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *infoDic = [NSDictionary dictionary];

    if (![manager fileExistsAtPath:path]) {
        [fileManagerInstance __info:@{@"path" : path, @"error" : @YES, @"reason" : filePathFound} infoBlock:info];
        return;
    }
    path = [NSString stringWithFormat:@"%@%@", path, fileName];

    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }

    if ([NSStringFromClass([file class]) isEqualToString:NSStringFromClass([UIImage class])]) {
        NSData *imageData = UIImagePNGRepresentation((UIImage *) file);
        [imageData writeToFile:path atomically:YES];

        if (![manager fileExistsAtPath:path]) {
            infoDic = @{@"error" : @YES, @"path" : path, @"reason" : fileWriteLocalNotSucess};
        }
        else {
            infoDic = @{@"error" : @NO, @"path" : path, @"reason" : fileWriteLocalSucess};
        }
        [fileManagerInstance __info:infoDic infoBlock:info];
    }
}

+ (NSString *)documentPathWithFileName:(NSString *)fileName {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = fileName ? [path stringByAppendingString:path] : path;
    return path;
}

+ (UIImage *)searchFileWithFileName:(NSString *)fileName type:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    if (path) {
        return [UIImage imageWithContentsOfFile:path];
    }
    return nil;
}


+ (void)archiverObject:(id)Obj key:(NSString *)key fileName:(NSString *)fileName {
    NSString *userPath = [NSHomeDirectory() stringByAppendingString:fileName];
    NSMutableData *userData = [[NSMutableData alloc] init];
    NSKeyedArchiver *userArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:userData];
    [userArchiver encodeObject:Obj forKey:key];
    [userArchiver finishEncoding];
    [userData writeToFile:userPath atomically:YES];
}

+ (instancetype)unarchiverWithKey:(NSString *)key fileName:(NSString *)fileName {
    NSMutableData *data1 = [NSMutableData dataWithContentsOfFile:[self documentPathWithFileName:fileName]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data1];
    return [unarchiver decodeObjectForKey:@"kUser"];
}


+ (void)upLoadDataToSeverWithURL:(NSString *)url post:(BOOL)post dic:(NSDictionary *)dic infor:(Info)info {

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    if (post) {
        [sessionManager POST:url parameters:dic success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {

        }failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {

        }];
    }
    else {
        [sessionManager GET:url parameters:dic success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {

            
        }failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {

            
        }];
    }
}


- (void)__info:(NSDictionary *)info infoBlock:(Info)infoBlock
{
    infoBlock([[info objectForKey:@"error"] boolValue], [NSString stringWithFormat:@"%@:%@", [info objectForKey:@"path"], [info objectForKey:@"reason"]]);
}
@end
