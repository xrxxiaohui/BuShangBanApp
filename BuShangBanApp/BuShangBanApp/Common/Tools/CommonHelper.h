//
//  CommonHelper.h
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/17.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/param.h>
#include <sys/mount.h>
//#import "ASIFormDataRequest.h"

#pragma mark - binary macro

#define CHECK_BIT(var, pos)         ((var) & (1 << (pos)))
#define CHECK_ENUM_BIT(var, value)  ((var) & (value))
#define SET_BIT(var, pos)           ((var) |= (1 << (pos)))
#define CLEAR_BIT(var, pos)         ((var) &= ~(1 << (pos)))
#define SET_BIT_VALUE(var, pos, value) ((value) ? SET_BIT(var, pos) : CLEAR_BIT(var, pos))
#define TOGGLE_BIT(var, pos)        ((var) ^= (1 << (pos)))

#pragma mark - math macro

#if !defined(CONTAINED)
#define CONTAINED(A,B,value) ((((A) == (value)) || ((B) == (value))) ? (YES) : (NO))
#endif

#if !defined(MAXED)
#define MAXED(A,B,value) ((((A) > (B) ? (A) : (B)) == value) ? (YES) : (NO))
#endif




@interface CommonHelper : NSObject {
    NSString *deviceIdentifier;
}

//#pragma mark - 加解密
//+ (NSString *)encrypt:(NSString *)text withKey:(NSString *)key;
//+ (NSString *)decrypt:(NSString *) text withKey:(NSString *) key;
//
//
//+ (NSData *)uncompress:(NSData *)data withUncompressedDataLength:(NSUInteger)length;
//+ (NSDictionary *)deserializeAsDictionary:(NSData *)data;
//
//+ (void) bindRequest:(ASIHTTPRequest *) request withParams:(NSDictionary *) params;
//
//+ (void) bindRequest:(ASIHTTPRequest *)request
//         usingMethod:(NSString*)method
//          withParams:(NSDictionary *)params;
//
//+ (void) bindFormRequest:(ASIHTTPRequest *)request
//             usingMethod:(NSString *)method
//              withParams:(NSDictionary *)params;
//
//+ (void) bindRequest:(ASIHTTPRequest *)request
//          withParams:(NSDictionary *)params
//            andImage:(NSData*) imageData
//        andVoiceData:(NSData *) audioData;
//
//+ (void) bindRequest:(ASIFormDataRequest *) request
//          withMethod:(NSString *) method
//          withParams:(NSDictionary *)   params
//            withData:(NSData *) imageData
//        withFileName:(NSString *) fileName
//             isImage:(BOOL) isImage;
//
//+ (void) bindRequest:(ASIFormDataRequest *)request
//          withMethod:(NSString *) method
//          withParams:(NSDictionary *)params
//            withData:(NSData *) imageData
//             isImage:(BOOL) isImage;
//
//+ (BOOL) resultOutput:(ASIHTTPRequest *)request
//           withResult:(NSDictionary **) resultDic;
//
//+ (void) bindRequest:(ASIFormDataRequest *)request
//          withMethod:(NSString *) method
//          withParams:(NSDictionary *)params
//        withFilePath:(NSString *) filePath;
//
//+ (void) bindRequest:(ASIFormDataRequest *)request
//          withMethod:(NSString *) method
//          withParams:(NSDictionary *)params
//        withFileDict:(NSDictionary *)fileDict;
//
//+(NSString *) serializeDictionary:(NSDictionary*) dic;
//
//+ (NSURL *) buildRequestUrl:(NSString *) destUrl;
//
//+ (NSString *) getMD5:(NSString *) key;
//
//+ (NSString *) getHexString:(NSData *) data;
//
+ (NSString *)stringByDecodingHTMLEntitiesInString:(NSString *)input;
+ (NSString *) stringToHtml:(NSString *) string;
+ (NSString *) stringFromHtml:(NSString *) html;
+ (NSString *)UUID;
+ (NSData *) UUIDData;
+ (NSString *) deviceIdentifier;
//
//+ (BOOL) checkResponseResult:(NSDictionary *) resultDic;
//
//+ (BOOL)checkNetCanUploading;
//
//+ (void) saveDeviceUserId:(NSString *) userId withEnvironmentId:(long long) environmentId;
//
//+ (NSString *) savedDeviceUserIdWithEnvirId:(long long) environmentId;
//
//#pragma mark - protobuf 头
//
////+ (void) bindProtobufRequest:(ASIHTTPRequest *)request
////                 usingMethod:(int)method
////                  withParams:(PBGeneratedMessage *)param;
////
////+ (BOOL) protobufResultOutput:(ASIHTTPRequest *)request
////                 withBodyData:(NSData **) data
////                withErrorCode:(int*) errorCode;
//
//#pragma mark - 多个并发方法，hang住等待完成，不知道苹果的并发做得咋样，试试
//
//+ (void) batchRequestWithWorkerName:(NSString*) workName withblocks:(NSArray *) blocks;
//
//
//
//#pragma mark - 将一个大数组按照容器容量分为n个小数组
//
//+ (NSArray *) splitArray:(NSArray *) theArray withMaxCounts:(NSUInteger) count;
//
////
//// 慎用该方法，各种判断都没有。只用于以下的sort方法。
#pragma mark - 随机数
+ (NSUInteger) randomFrom:(NSUInteger) min to:(NSUInteger) max;
//
//#pragma mark - 随机数，生成从min到max之间的一共count个不重复的随机数
//+(NSSet *) randomFrom:(int) min to:(int)max withItemCount:(int) count;
//
//#pragma mark - 各种array 拆分、合并 方法
//
////
//// 输入的是一个多个数组组合的数组，合并规则为，把这N个数组的对象按照最大值不超过maxCount的方式重新组合，合并成新的数组队列
//+ (NSArray *) combineArrayLists:(NSArray *) multiArrays withMaxCount:(int) maxCount;
//
////
//// 按照顺序，把一个object加入到一个2纬数组内，2纬数组的规则是，如果该object的key已存在，则建立新的数组。
//+ (void) addObject:(id) anObject toArrayList:(NSMutableArray *) arrays withHashSet:(NSMutableSet*) mutableSet andKey:(id) key;

+(NSString *)getDocumentPath;
+(NSString *)getCachePath;
+(NSString *)getLibraryPath;
+(NSString *)getTempPath;

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath;
+(NSString *) fileFormatSizeAtPath:(NSString *)filePath;

//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath;

+ (void)getCurrentLanguage;
+ (NSString*)getPreferredLanguage;

+ (NSString *) freeDiskSpaceInBytes;

@end
