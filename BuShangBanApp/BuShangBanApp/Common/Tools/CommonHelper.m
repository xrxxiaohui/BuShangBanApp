//
//  CommonHelper.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/17.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "CommonHelper.h"
//#import "zlib.h"
//#import "CJSONDeserializer.h"
//#import "CJSONSerializer.h"
//#import "zlib.h"
//#import "Configure.h"
//#import "CinLogger.h"
//#import "CinNetworkObserver.h"
//#import "JSONKit.h"
#import <UICKeyChainStore.h>

//#import "ProtobufferBuilder.h"

#ifndef kMinPackageDataSize
#define kMinPackageDataSize (9)
#endif

static NSString * globalDevcieIdentifier = nil;
@implementation CommonHelper

//+(NSString *) serializeDictionary:(NSDictionary*) dic {
////#if DEBUG
////    NSString *string1 = nil;
////    NSString *string2 = nil;
////    
////    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
////    string1 = [[[NSString alloc] initWithData:[dic JSONData] encoding:NSUTF8StringEncoding] autorelease];
////    NSTimeInterval escapedTime1 = [[NSDate date] timeIntervalSince1970] - startTime;
////    
////    startTime = [[NSDate date] timeIntervalSince1970];
////    string2 = [[CJSONSerializer serializer] serializeDictionary:dic];
////    NSTimeInterval escapedTime2 = [[NSDate date] timeIntervalSince1970] - startTime;
////    
////    BOOL result = [string1 isEqualToString:string2];
////    
////    if (!result)
////        cinWarnLog(@"JSON result is not equal %@, %@", string1, string2);
////    cinInfoLog(@"string1 using JSONKit, using %f, string2 using %f", escapedTime1, escapedTime2);
////#endif
////    return [[[NSString alloc] initWithData:[dic JSONData] encoding:NSUTF8StringEncoding] autorelease];
//    
//    
//    return [[CJSONSerializer serializer] serializeDictionary:dic];
//}
//
//+ (void) ayncPerformMultiTask:(NSArray*) tasks {
//    dispatch_queue_t workerQueue = dispatch_queue_create("randomWorkerQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_group_t groupQueue = dispatch_group_create();
//    for (dispatch_block_t task in tasks) {
//        dispatch_group_async(groupQueue, workerQueue, task);
//    }
//    dispatch_group_wait(groupQueue, DISPATCH_TIME_FOREVER);
//    dispatch_release(workerQueue);
//    dispatch_release(groupQueue);
//}
//
//+ (NSString *) getHexString:(NSData *) data {
//    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
//    
//    if (!dataBuffer)
//        return [NSString string];
//    
//    NSUInteger          dataLength  = [data length];
//    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
//    
//    for (int i = 0; i < dataLength; ++i)
//        [hexString appendString:[NSString stringWithFormat:@"%02lX", (unsigned long)dataBuffer[i]]];
//    
//    return [NSString stringWithString:hexString];
//}
//
//+ (BOOL) checkResponseResult:(NSDictionary *) resultDic {
//    if (resultDic) {
//        NSDictionary *bStatus = [resultDic objectForKey:@"bStatus"];
//        if (bStatus && [[bStatus objectForKey:@"code"] intValue] == 0)
//            return YES;
//    }
//    return NO;
//}
//
//+ (void) saveDeviceUserId:(NSString *) userId withEnvironmentId:(long long) environmentId {
//    if (userId) {
//        NSString *service = @"com.qunar.lvtu.lvtuSDK";
//        NSString *key = [NSString stringWithFormat:@"MyDeviceUserId-%lld", environmentId];
//        
//        [UICKeyChainStore setString:userId forKey:key service:service];
//    }
//}
//
//+ (NSString *) savedDeviceUserIdWithEnvirId:(long long) environmentId {
//    NSString *service = @"com.qunar.lvtu.lvtuSDK";
//    NSString *key = [NSString stringWithFormat:@"MyDeviceUserId-%lld", environmentId];
//    
//    return [[[UICKeyChainStore stringForKey:key service:service] copy] autorelease];
//}
//
+ (NSString *) deviceIdentifier {
    @synchronized (self) {
        NSString *service = @"com.shunshunliuxue.shunshun";
        NSString *key = @"deviceIdentifier";
        
        if (globalDevcieIdentifier == nil) {
            globalDevcieIdentifier = [[UICKeyChainStore stringForKey:key service:service] copy];
            if (!globalDevcieIdentifier) {
                globalDevcieIdentifier = [[CommonHelper UUID] retain];
                [UICKeyChainStore setString:globalDevcieIdentifier forKey:key service:service];
            }
        }
    }
    return globalDevcieIdentifier;
}
//
//+ (NSString *) decrypt:(NSString *) text withKey:(NSString *) key {
//    //
//    // 先把字符串变成byte数组
//    NSString *result = nil;
//    
//    int len = (int)[text length] / 2;
//    uint8_t *buf = calloc(len, sizeof(uint8_t));
//    uint8_t *whole_byte = buf;
//    char byte_chars[3] = {'\0','\0','\0'};
//    
//    for (int i = 0; i < len; i++) {
//        byte_chars[0] = [text characterAtIndex:i * 2];
//        byte_chars[1] = [text characterAtIndex:i * 2 + 1];
//        *whole_byte = strtol(byte_chars, NULL, 16);
//        whole_byte++;
//    }
//    
//    long crc = (long) (buf[0] & 0xff) + ((long) (buf[1] & 0xff) << 24) + ((long) (buf[2] & 0xff) << 8) + (((long) (buf[3] & 0xff)) << 16);
//    //    crc = (long) (pItem[0] & 0xff) + ((long) (pItem[1] & 0xff) << 24) + (((long) (pItem[2] & 0xff)) << 16) + ((long) (pItem[3] & 0xff) << 8);
//    
//    uint32_t crc32Value = (uint32_t)crc32(0L, Z_NULL, 0);
//    crc32Value = (uint32_t)crc32(crc32Value, buf + 4, (len - sizeof(uint32_t)));
//    
//    if (crc32Value == crc) {
//        //
//        // 说明可以搞
//        // 加密字
//        NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
//        NSUInteger keyLength = [keyData length];
//        Byte *keyBytes = (Byte *)[keyData bytes];
//        
//        for (int i = sizeof(uint32_t); i < len - sizeof(uint32_t); i++) {
//            
//            buf[i]  -= keyBytes[(i - sizeof(uint32_t)) % keyLength];
//            buf[i] ^= 91;
//            
//            //
//            // 之前抄错了。这个好像是另一套算法。
//            //            theData = (int)(*(pItem + i)) -  keyLength;
//            //            theData = (int)(*(pItem + i)) - keyBytes[(i - sizeof(uLong) % keyLength];
//            //            theData ^= 91;
//            //            [resultData appendBytes:&theData length:sizeof(Byte)];
//        }
//        //
//        // 到这儿，就算是完事儿了。
//        
//        NSData *resultData = [NSData  dataWithBytes:buf + sizeof(uint32_t) length:len - sizeof(uint32_t)];
//        result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
//    }
//    free(buf);
//    return [result autorelease];
//}
//
//+ (NSString *)encrypt:(NSString *)text withKey:(NSString *)key
//{
//	// 加密字
//	NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
//	NSUInteger keyLength = [keyData length];
//	Byte *keyBytes = (Byte *)[keyData bytes];
//	
//	// 旧的数据
//	NSData *srcData = [text dataUsingEncoding:NSUTF8StringEncoding];
//	NSUInteger srcLength = [srcData length];
//	Byte* srcBytes = (Byte *)[srcData bytes];
//	
//	// 新的数据
//	NSUInteger destLength = sizeof(uint32_t) + srcLength;
//	Byte* destBytes = (Byte *)malloc(sizeof(Byte) * destLength);
//	memcpy(destBytes + sizeof(uint32_t), srcBytes, sizeof(Byte) * srcLength);
//	
//	// 加密
//	for(NSUInteger i = 0; i < srcLength; i++)
//	{
//		destBytes[i + sizeof(uint32_t)] ^= 91;
//		destBytes[i + sizeof(uint32_t)] += keyBytes[i % keyLength];
//	}
//	
//	// 计算CRC32
//	uint32_t crc32Value = (uint32_t)crc32(0L, Z_NULL, 0);
//    crc32Value = (uint32_t)crc32(crc32Value, destBytes + sizeof(uint32_t), sizeof(Byte) * (uint)srcLength);
//	
//	// 加密CRC32
//	destBytes[0] = (Byte)crc32Value;
//	destBytes[1] = (Byte)(crc32Value >> 24);
//	destBytes[2] = (Byte)(crc32Value >> 8);
//	destBytes[3] = (Byte)(crc32Value >> 16);
//	
//	// 通过字节数组得到字符串
//	NSMutableString *destString = [[NSMutableString alloc] initWithString:@""];
//	for(NSUInteger i = 0; i < destLength; i++)
//	{
//		Byte destByte = destBytes[i] & 0xFF;
////		Byte destHexFirst = destByte / 16;
////		Byte destHexSecond = destByte % 16;
//        [destString appendFormat:@"%02X", destByte];		
////		[destString appendFormat:@"%x%x", destHexFirst, destHexSecond];
//	}
//#if DEBUG
////    NSMutableString *destString2 = [[NSMutableString alloc] initWithCapacity:100];
////    
////    for(NSUInteger i = 0; i < destLength; i++)
////	{
////		Byte destByte = destBytes[i] & 0xFF;
//////		Byte destHexFirst = destByte / 16;
//////		Byte destHexSecond = destByte % 16;
////		[destString2 appendFormat:@"%02X", destByte];
//////		[destString appendFormat:@"%x%x", destHexFirst, destHexSecond];
////	}
////    
////    if ([destString2 isEqualToString:[destString uppercaseString]]) {
////        cinInfoLog(@"OK");
////    }
////    cinAssert(![destString isEqualToString:destString2]);
////    [destString2 release];
//#endif
//	free(destBytes);
//	
//	return [destString autorelease];
//}
//
//+ (NSData *)uncompress:(NSData *)data withUncompressedDataLength:(NSUInteger)length
//{
//    if([data length] == 0)
//	{
//		return data;
//	}
//	else
//	{
//		// 分配解压空间
//		NSMutableData *decompressedData = [NSMutableData dataWithLength:length];
//		
//		// 设置解压参数
//		z_stream stream;
//		stream.next_in = (Bytef *)[data bytes];
//		stream.avail_in = (uint)[data length];
//		stream.total_in = 0;
//		stream.next_out = (Bytef *)[decompressedData mutableBytes];
//		stream.avail_out = (uint)[decompressedData length];
//		stream.total_out = 0;
//		stream.zalloc = Z_NULL;
//		stream.zfree = Z_NULL;
//		stream.opaque = Z_NULL;
//		
//		// 初始化
//		if(inflateInit(&stream) == Z_OK)
//		{
//			// 解压缩
//			int status = inflate(&stream, Z_SYNC_FLUSH);
//			if(status == Z_STREAM_END)
//			{
//				// 清除
//				if(inflateEnd(&stream) == Z_OK)
//				{
//					return decompressedData;
//				}
//			}
//		}
//	}
//	
//	return nil;
//}
//
//+ (NSDictionary *)deserializeAsDictionary:(NSData *)data
//{
//    NSDictionary* dictionary = nil;
//    
//    if((data == nil) || ([data length] < kMinPackageDataSize))
//    {
//        return nil;
//    }
//    
//    NSUInteger dataLen = [data length];
//    NSUInteger curIndex = 0;
//    
//    int dataValid;
//    [data getBytes:&dataValid range:NSMakeRange(curIndex, sizeof(int))];
//    curIndex += sizeof(int);
//    
//    if(dataValid != 0)
//    {
//        return nil;
//    }
//    
//    int serviceType;
//    [data getBytes:&serviceType range:NSMakeRange(curIndex, sizeof(int))];
//    curIndex += sizeof(int);
//    
//    int errorCode;
//    [data getBytes:&errorCode range:NSMakeRange(curIndex, sizeof(int))];
//    curIndex += sizeof(int);
//    
////    if(errorCode != 0)
////    {
////        return nil;
////    }
//    
//    if(curIndex >= dataLen)
//    {
//        return nil;
//    }
//    
//    int dataCompressed;
//    [data getBytes:&dataCompressed range:NSMakeRange(curIndex, sizeof(int))];
//    curIndex += sizeof(int);
//    
//    int jsonLen = 0;
//    NSData *infoData = nil;
//    if(dataCompressed == 2)
//    {
//        int decompressedDataSize;
//        if(curIndex >= dataLen)
//        {
//            return nil;
//        }
//        
//        [data getBytes:&decompressedDataSize range:NSMakeRange(curIndex, sizeof(int))];
//        curIndex += sizeof(int);
//        
//        int compressedDataSize;
//        if(curIndex >= dataLen)
//        {
//            return nil;
//        }
//        
//        [data getBytes:&compressedDataSize range:NSMakeRange(curIndex, sizeof(int))];
//        curIndex += sizeof(int);
//        
//        NSData *compressedData = [data subdataWithRange:NSMakeRange(curIndex, compressedDataSize)];
//        infoData = [self uncompress:compressedData withUncompressedDataLength:decompressedDataSize];
//        curIndex = 0;
//        jsonLen = decompressedDataSize;
//    }
//    else
//    {
//        infoData = data;
//        if(curIndex >= dataLen)
//        {
//            return nil;
//        }
//        
//        [infoData getBytes:&jsonLen range:NSMakeRange(curIndex, sizeof(int))];
//        curIndex += sizeof(int);
//    }
//    
//    NSData *jsonData = [infoData subdataWithRange:NSMakeRange(curIndex, jsonLen)];
//    dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
//    
//    return dictionary;
//}
//
//+ (void) bindRequest:(ASIHTTPRequest *)request
//          withParams:(NSDictionary *)params
//            andImage:(NSData*) imageData
//        andVoiceData:(NSData *) audioData {
//    // =============================================================
//	// 发送网络请求
//	// =============================================================
//    // 服务类型
//    
//    // 版本号
//    [params setValue:[[ApplicationManager instance] internalVersion] forKey:@"vid"];
//	
//	// 程序号
//    [params setValue:kNetworkTaskDIP forKey:@"pid"];
//	
//	// 渠道号
//    [params setValue:[[ApplicationManager instance] appChannelId] forKey:@"cid"];
//	
//	// 用户ID
//	NSString *deviceID = [CommonHelper deviceIdentifier];//[[UIDevice currentDevice] uniqueIdentifier];
//    [params setValue:deviceID forKey:@"did"];
//	
//    // 序列化Param
//    NSDictionary *dictionaryParam = [params objectForKey:@"param"];
//    if(dictionaryParam != nil)
//    {
//        NSString *paramJson = [[CJSONSerializer serializer] serializeDictionary:dictionaryParam];
//        [params setValue:paramJson forKey:@"param"];
//    }
//    
//    // 获取Key
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *curDate = [[NSDate alloc] init];
//    NSString *curDateText = [dateFormatter stringFromDate:curDate];
//    [curDate release];
//    [dateFormatter release];
//    
//    // key
//    [params setValue:curDateText forKey:@"ke"];
//    
//    // 是否需要加密
//    NSString *key = [params valueForKey:@"ke"];
//    if (key != nil && [key length] != 0)
//    {
//        // 业务参数
//        NSString *paramJson = [params valueForKey:@"param"];
//        if (paramJson != nil && [paramJson length] != 0)
//        {
//            // 参数
//            NSString *encryptParamJson = [CommonHelper encrypt:paramJson withKey:key];
//            
//            // 用密文替换明文
//            [params setValue:encryptParamJson forKey:@"param"];
//        }
//    }
//    
//    // =============================================================
//	// 获取POST的内容
//	// =============================================================
//    
//	NSMutableString *destPostString = [[NSMutableString alloc] initWithFormat:@"%@", [[CJSONSerializer serializer] serializeDictionary:params]];
//    
//    NSString *boundary = @"---------------------------14737809831466499882746641449";
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//    
//    NSMutableData *body = [NSMutableData data];
//    
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"Content-Disposition: form-data; name=reqJson\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"%@", destPostString] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    if (imageData != nil || audioData != nil) {
//        if (imageData != nil) {
//            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_0\"; filename=\"%@\"\r\n",  @"photo.jpg"]] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[NSData dataWithData:imageData]];
//            [body appendData:[[NSString stringWithFormat:@"\r\n--%@",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        }
//        
//        if (audioData != nil) {
//            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_1\"; filename=\"%@\"\r\n",  @"voice.amr"]] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[NSData dataWithData:audioData]];
//            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        }
//        else {
//            [body appendData:[[NSString stringWithFormat:@"--\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        }
//        
//    }
//    else {
//        [body appendData:[[NSString stringWithFormat:@"--\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    [destPostString release];
//    
//    [request setPostBody:body];
//    
//    [request setRequestMethod:@"POST"];
//    [request addRequestHeader:@"Content-type" value:contentType];
//    
//    [[request requestHeaders] setValue:@"Close" forKey:@"Connection"];
//    
//    [[request requestHeaders] setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forKey:@"Content-Length"];
//    request.timeOutSeconds = 300;
//    [request setNumberOfTimesToRetryOnTimeout:2];
//}
//
//+ (NSString *) getMD5:(NSString *) key {
//    NSMutableString *result = nil;
//    if (key != nil && [key length] > 0) {
//        unsigned char md5Key[CC_MD5_DIGEST_LENGTH];
//        const char* strings = [key UTF8String];
//        CC_MD5(strings, (CC_LONG)strlen(strings), md5Key);
//        result = [NSMutableString string];
//        for (int i = 0; i < 16; i++)
//            [result appendFormat:@"%02X", md5Key[i]];
//        return [result uppercaseString];
//    }
//    return result;
//}
//
//+ (void) bindRequest:(ASIFormDataRequest *)request
//          withMethod:(NSString *) method
//          withParams:(NSDictionary *)params
//        withFilePath:(NSString *) filePath {
//    
//    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:10];
//    [requestDic setValue:[[ApplicationManager instance] internalVersion] forKey:@"vid"];
//    [requestDic setValue:kNetworkTaskDIP forKey:@"pid"];
//    [requestDic setValue:[[ApplicationManager instance] appChannelId] forKey:@"cid"];
//    [requestDic setValue:[CommonHelper deviceIdentifier] forKey:@"did"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"re"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"cp"];
//    [requestDic setValue:method forKey:@"t"];
//    
//    cinInfoLog(@"bindRequest with method:%@ and params: %@", method, params);
//    
//    NSString *extra = [[CJSONSerializer serializer] serializeDictionary:params];
//    NSString *key = [CommonHelper UUID];
//    [requestDic setValue:key forKey:@"ke"];
//    // 是否需要加密
//    if (key != nil && [key length] != 0)
//    {
//        // 业务参数
//        if (extra != nil && [extra length] != 0)
//        {
//            // 参数
//            NSString *encryptParamJson = [self encrypt:extra withKey:key];
//            
//            // 用密文替换明文
//            [requestDic setValue:encryptParamJson forKey:@"param"];
//        }
//    } else {
//        [requestDic setValue:extra forKey:@"param"];
//    }
//    
//    NSString *postString = [[CJSONSerializer serializer] serializeDictionary:requestDic];
//    
//    [request addPostValue:postString forKey:@"reqJson"];
////    if (filePath) {
//        [request addFile:filePath withFileName:[filePath lastPathComponent] andContentType:@"application/octet-stream" forKey:@"file_0"];
////    }
//    
//    [requestDic release];
//  
//}
//
//+ (void) bindRequest:(ASIFormDataRequest *)request
//          withMethod:(NSString *) method
//          withParams:(NSDictionary *)params
//        withFileDict:(NSDictionary *)fileDict {
//    
//    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:10];
//    [requestDic setValue:[[ApplicationManager instance] internalVersion] forKey:@"vid"];
//    [requestDic setValue:kNetworkTaskDIP forKey:@"pid"];
//    [requestDic setValue:[[ApplicationManager instance] appChannelId] forKey:@"cid"];
//    [requestDic setValue:[CommonHelper deviceIdentifier] forKey:@"did"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"re"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"cp"];
//    [requestDic setValue:method forKey:@"t"];
//    
//    cinInfoLog(@"bindRequest with method:%@ and params: %@", method, params);
//    
//    NSString *extra = [[CJSONSerializer serializer] serializeDictionary:params];
//    NSString *key = [CommonHelper UUID];
//    [requestDic setValue:key forKey:@"ke"];
//    // 是否需要加密
//    if (key != nil && [key length] != 0)
//    {
//        // 业务参数
//        if (extra != nil && [extra length] != 0)
//        {
//            // 参数
//            NSString *encryptParamJson = [self encrypt:extra withKey:key];
//            
//            // 用密文替换明文
//            [requestDic setValue:encryptParamJson forKey:@"param"];
//        }
//    } else {
//        [requestDic setValue:extra forKey:@"param"];
//    }
//    
//    NSString *postString = [[CJSONSerializer serializer] serializeDictionary:requestDic];
//    
//    // 字典转为plist格式的NSData 二进制
//    CFDataRef dataRef = CFPropertyListCreateData(NULL, fileDict, kCFPropertyListXMLFormat_v1_0, 0, NULL);
////    NSString *str = [[NSString alloc] initWithData:(NSData *)dataRef encoding:NSUTF8StringEncoding];
////    NSLog(@"appInstallPlist: %@",str);
//    
//    if (fileDict) {
//        [request addPostValue:postString forKey:@"reqJson"];
//        [request addData:(NSData *)dataRef withFileName:[NSString stringWithFormat:@"%@.plist",[[UserData instance] userId]] andContentType:@"application/octet-stream" forKey:@"file_0"];
//    }
//    
//    [requestDic release];
//    
//}
//
//+ (void) bindFormRequest:(ASIHTTPRequest *)request
//             usingMethod:(NSString *)method
//              withParams:(NSDictionary *)params {
//    @autoreleasepool {
//        NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:10];
//        [requestDic setValue:[[ApplicationManager instance] internalVersion] forKey:@"vid"];
//        [requestDic setValue:kNetworkTaskDIP forKey:@"pid"];
//        [requestDic setValue:[[ApplicationManager instance] appChannelId] forKey:@"cid"];
//        [requestDic setValue:[CommonHelper deviceIdentifier] forKey:@"did"];
//        [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"re"];
//        [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"cp"];
//        [requestDic setValue:method forKey:@"t"];
//        
//        NSString *extra = [CommonHelper serializeDictionary:params];
//        NSString *key = [CommonHelper UUID];
//        [requestDic setValue:key forKey:@"ke"];
//        // 是否需要加密
//        if (key != nil && [key length] != 0)
//        {
//            // 业务参数
//            if (extra != nil && [extra length] != 0)
//            {
//                // 参数
//                NSString *encryptParamJson = [self encrypt:extra withKey:key];
//                
//                // 用密文替换明文
//                [requestDic setValue:encryptParamJson forKey:@"param"];
//            }
//        } else {
//            [requestDic setValue:extra forKey:@"param"];
//        }
//        
//        cinInfoLog(@"bindRequest, destPostDict is :%@", requestDic);
//        // =============================================================
//        // 获取POST的内容
//        // =============================================================
//        
//        NSMutableString *destPostString = [[NSMutableString alloc] initWithFormat:@"%@",
//                                           [[CJSONSerializer serializer] serializeDictionary:requestDic]];
//        [requestDic release];
//        
//        NSString *boundary = [@"0xKhTmLbOuNdArY-" stringByAppendingString:[CommonHelper UUID]];
//        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//        
//        NSMutableData *body = [NSMutableData data];
//        
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[@"Content-Disposition: form-data; name=reqJson\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"%@", destPostString] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [body appendData:[[NSString stringWithFormat:@"--\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [destPostString release];
//        
//        [request setPostBody:body];
//        
//        [request setRequestMethod:@"POST"];
//        [request addRequestHeader:@"Content-type" value:contentType];
//        
//        [[request requestHeaders] setValue:@"Close" forKey:@"Connection"];
//        
//        [[request requestHeaders] setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forKey:@"Content-Length"];
//        [request setTimeOutSeconds:300];
//        [request setNumberOfTimesToRetryOnTimeout:2];
//    }
//}
//
//+ (void) bindRequest:(ASIFormDataRequest *) request
//          withMethod:(NSString *) method
//          withParams:(NSDictionary *)   params
//            withData:(NSData *) imageData
//        withFileName:(NSString *) fileName
//             isImage:(BOOL) isImage {
//    
//    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:10];
//    [requestDic setValue:[[ApplicationManager instance] internalVersion] forKey:@"vid"];
//    [requestDic setValue:kNetworkTaskDIP forKey:@"pid"];
//    [requestDic setValue:[[ApplicationManager instance] appChannelId] forKey:@"cid"];
//    [requestDic setValue:[CommonHelper deviceIdentifier] forKey:@"did"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"re"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"cp"];
//    [requestDic setValue:method forKey:@"t"];
//    
//    cinInfoLog(@"bindRequest with method:%@ and params: %@", method, params);
//    
//    NSString *extra = [[CJSONSerializer serializer] serializeDictionary:params];
//    NSString *key = [CommonHelper UUID];
//    [requestDic setValue:key forKey:@"ke"];
//    // 是否需要加密
//    if (key != nil && [key length] != 0)
//    {
//        // 业务参数
//        if (extra != nil && [extra length] != 0)
//        {
//            // 参数
//            NSString *encryptParamJson = [self encrypt:extra withKey:key];
//            
//            // 用密文替换明文
//            [requestDic setValue:encryptParamJson forKey:@"param"];
//        }
//    } else {
//        [requestDic setValue:extra forKey:@"param"];
//    }
//    
//    NSString *postString = [[CJSONSerializer serializer] serializeDictionary:requestDic];
//    
//    [request addPostValue:postString forKey:@"reqJson"];
//    NSString *fileKey = isImage ? @"file_0" : @"file_1";
//    [request addData:imageData withFileName:fileName andContentType:@"application/octet-stream" forKey:fileKey];
//    [requestDic release];
//
//}
//
//+ (void) bindRequest:(ASIFormDataRequest *)request
//          withMethod:(NSString *) method
//          withParams:(NSDictionary *)params
//            withData:(NSData *) imageData
//             isImage:(BOOL) isImage {
//    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:10];
//    [requestDic setValue:[[ApplicationManager instance] internalVersion] forKey:@"vid"];
//    [requestDic setValue:kNetworkTaskDIP forKey:@"pid"];
//    [requestDic setValue:[[ApplicationManager instance] appChannelId] forKey:@"cid"];
//    [requestDic setValue:[CommonHelper deviceIdentifier] forKey:@"did"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"re"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"cp"];
//    [requestDic setValue:method forKey:@"t"];
//    
//    cinInfoLog(@"bindRequest with method:%@ and params: %@", method, params);
//    
//    NSString *extra = [[CJSONSerializer serializer] serializeDictionary:params];
//    NSString *key = [CommonHelper UUID];
//    [requestDic setValue:key forKey:@"ke"];
//    // 是否需要加密
//    if (key != nil && [key length] != 0)
//    {
//        // 业务参数
//        if (extra != nil && [extra length] != 0)
//        {
//            // 参数
//            NSString *encryptParamJson = [self encrypt:extra withKey:key];
//            
//            // 用密文替换明文
//            [requestDic setValue:encryptParamJson forKey:@"param"];
//        }
//    } else {
//        [requestDic setValue:extra forKey:@"param"];
//    }
//    
//    NSString *postString = [[CJSONSerializer serializer] serializeDictionary:requestDic];
//    
//    [request addPostValue:postString forKey:@"reqJson"];
//    NSString *fileKey = isImage ? @"file_0" : @"file_1";
//    
//    [request addData:imageData withFileName:@"imageData" andContentType:@"application/octet-stream" forKey:fileKey];
//    [requestDic release];
//    
//    
////    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:10];
////    [requestDic setValue:kNetworkTaskDIV forKey:@"vid"];
////    [requestDic setValue:kNetworkTaskDIP forKey:@"pid"];
////    [requestDic setValue:[[ApplicationManager instance] appChannelId] forKey:@"cid"];
////    [requestDic setValue:[CommonHelper deviceIdentifier] forKey:@"did"];
////    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"re"];
////    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"cp"];
////    [requestDic setValue:method forKey:@"t"];
////    
////    NSString *extra = [[CJSONSerializer serializer] serializeDictionary:params];
////    NSString *key = [CommonHelper UUID];
////    [requestDic setValue:key forKey:@"ke"];
////    // 是否需要加密
////    if (key != nil && [key length] != 0)
////    {
////        // 业务参数
////        if (extra != nil && [extra length] != 0)
////        {
////            // 参数
////            NSString *encryptParamJson = [self encrypt:extra withKey:key];
////            
////            // 用密文替换明文
////            [requestDic setValue:encryptParamJson forKey:@"param"];
////        }
////    } else {
////        [requestDic setValue:extra forKey:@"param"];
////    }
////    
////    cinInfoLog(@"bindRequest, destPostDict is :%@", requestDic);
////    // =============================================================
////	// 获取POST的内容
////	// =============================================================
////	NSMutableString *destPostString = [[NSMutableString alloc] initWithFormat:@"reqJson=%@", [[CJSONSerializer serializer] serializeDictionary:requestDic]];
////    [requestDic release];
////    
////    cinInfoLog(@"bindRequest, destPostString is :%@", destPostString);
////    
////	// 获取UTF8编码Data
////	NSData *postData = [destPostString dataUsingEncoding:NSUTF8StringEncoding];
////	[destPostString release];
////    
////    
////    [request addRequestHeader:@"Content-type" value:@"application/x-www-form-urlencoded;"];
////    
////    [[request requestHeaders] setValue:@"Close" forKey:@"Connection"];
////    [[request requestHeaders] setValue:[NSString stringWithFormat:@"%d", [postData length]] forKey:@"Content-Length"];
////    [request appendPostData:postData];
////    
////    [request addData:imageData forKey:@"file_0"];
//}
//
//+ (BOOL) resultOutput:(ASIHTTPRequest *)request withResult:(NSDictionary **) resultDic {
//    NSError *error = [request error];
//    if (!error) {
//        NSData *responseData = [request responseData];
//        *resultDic = [[CommonHelper deserializeAsDictionary:responseData] retain];
//    } else {
//        *resultDic = [[NSDictionary alloc] initWithObjectsAndKeys:error, @"error", nil];
//    }
//    cinInfoLog(@"request :%@, result is %@, error is %@", [[request url] description], *resultDic, error);
//    return error == nil;
//}
//
//+ (void) bindRequest:(ASIHTTPRequest *)request
//         usingMethod:(NSString*)method
//          withParams:(NSDictionary *)params {
//    
//    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:10];
//    [requestDic setValue:[[ApplicationManager instance] internalVersion] forKey:@"vid"];
//    [requestDic setValue:kNetworkTaskDIP forKey:@"pid"];
//    [requestDic setValue:[[ApplicationManager instance] appChannelId] forKey:@"cid"];
//    [requestDic setValue:[CommonHelper deviceIdentifier] forKey:@"did"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"re"];
//    [requestDic setValue:[NSNumber numberWithInt:0] forKey:@"cp"];
//    [requestDic setValue:method forKey:@"t"];
//    
//    NSString *extra = [[CJSONSerializer serializer] serializeDictionary:params];
//    NSString *key = [CommonHelper UUID];
//    [requestDic setValue:key forKey:@"ke"];
//    
//    cinInfoLog(@"bindRequest, method is %@, destPostDict is :%@", method, params);
//    
//    // 是否需要加密
//    if (key != nil && [key length] != 0)
//    {
//        // 业务参数
//        if (extra != nil && [extra length] != 0)
//        {
//            // 参数
//            NSString *encryptParamJson = [self encrypt:extra withKey:key];
//            
//            // 用密文替换明文
//            [requestDic setValue:encryptParamJson forKey:@"param"];
//        }
//    } else {
//        [requestDic setValue:extra forKey:@"param"];
//    }
//    
//    // =============================================================
//	// 获取POST的内容
//	// =============================================================
//	NSMutableString *destPostString = [[NSMutableString alloc] initWithFormat:@"reqJson=%@", [[CJSONSerializer serializer] serializeDictionary:requestDic]];
//    [requestDic release];
//    
//    cinInfoLog(@"bindRequest, destPostString is :%@", destPostString);
//    
//	// 获取UTF8编码Data
//	NSData *postData = [destPostString dataUsingEncoding:NSUTF8StringEncoding];
//	[destPostString release];
//    
//    
//    [request addRequestHeader:@"Content-type" value:@"application/x-www-form-urlencoded;"];
//    
//    [[request requestHeaders] setValue:@"Close" forKey:@"Connection"];
//    [[request requestHeaders] setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forKey:@"Content-Length"];
//    [request appendPostData:postData];
//}
//
//+ (void) bindRequest:(ASIHTTPRequest *) request withParams:(NSDictionary *) params {
//    // 版本号
//    if (![[params allKeys] containsObject:@"vid"])
//        [params setValue:[[ApplicationManager instance] internalVersion] forKey:@"vid"];
//	
//	// 程序号
//    if (![[params allKeys] containsObject:@"pid"])
//        [params setValue:kNetworkTaskDIP forKey:@"pid"];
//	
//	// 渠道号
//    if (![[params allKeys] containsObject:@"cid"])
//        [params setValue:[[ApplicationManager instance] appChannelId] forKey:@"cid"];
//	
//	// 用户ID
//    if (![[params allKeys] containsObject:@"did"]) {
//        NSString *deviceID = [CommonHelper deviceIdentifier];//[[UIDevice currentDevice] uniqueIdentifier];
//        [params setValue:deviceID forKey:@"did"];
//    }
//    
//    if (![[params allKeys] containsObject:@"re"])
//        [params setValue:[NSNumber numberWithInt:0] forKey:@"re"];
//    
//    if (![[params allKeys] containsObject:@"cp"])
//        [params setValue:[NSNumber numberWithInt:0] forKey:@"cp"];
//    
//    cinInfoLog(@"bindRequest, destPostDict is :%@", params);
//    
//    // 附加参数
//    NSDictionary *extraParam = [params objectForKey:@"param"];
//    if(extraParam != nil)
//    {
//        NSString *extra = [[CJSONSerializer serializer] serializeDictionary:extraParam];
//        [params setValue:extra forKey:@"param"];
//    }
//    
//    // 获取Key
////    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
////    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
////    NSDate *curDate = [[NSDate alloc] init];
//    NSString *curDateText = [CommonHelper UUID];//   [dateFormatter stringFromDate:curDate];
////    [curDate release];
////    [dateFormatter release];
//    
//    // key
//    [params setValue:curDateText forKey:@"ke"];
//    
//    // 是否需要加密
//    NSString *key = curDateText;
//    if (key != nil && [key length] != 0)
//    {
//        // 业务参数
//        NSString *paramJson = [params valueForKey:@"param"];
//        if (paramJson != nil && [paramJson length] != 0)
//        {
//            // 参数
//            NSString *encryptParamJson = [self encrypt:paramJson withKey:key];
//            
//            // 用密文替换明文
//            [params setValue:encryptParamJson forKey:@"param"];
//        }
//    }
////    
//    // =============================================================
//	// 获取POST的内容
//	// =============================================================
//	NSMutableString *destPostString = [[NSMutableString alloc] initWithFormat:@"reqJson=%@", [[CJSONSerializer serializer] serializeDictionary:params]];
//    
//    cinInfoLog(@"bindRequest, destPostString is :%@", destPostString);
//    
//	// 获取UTF8编码Data
//	NSData *postData = [destPostString dataUsingEncoding:NSUTF8StringEncoding];
//	[destPostString release];
//    
//    
//    [request addRequestHeader:@"Content-type" value:@"application/x-www-form-urlencoded;"];
//    
//    [[request requestHeaders] setValue:@"Close" forKey:@"Connection"];
//    [[request requestHeaders] setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forKey:@"Content-Length"];
//    [request appendPostData:postData];
//}
//
//+ (NSURL *) buildRequestUrl:(NSString *) destUrl {
//    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kNetworkTaskServer, destUrl]];
//}
//
+ (NSString *)stringByDecodingHTMLEntitiesInString:(NSString *)input {
    NSMutableString *results = [NSMutableString string];
    NSScanner *scanner = [NSScanner scannerWithString:input];
    [scanner setCharactersToBeSkipped:nil];
    while (![scanner isAtEnd]) {
        NSString *temp;
        if ([scanner scanUpToString:@"&" intoString:&temp]) {
            [results appendString:temp];
        }
        if ([scanner scanString:@"&" intoString:NULL]) {
            BOOL valid = YES;
            unsigned c = 0;
            NSUInteger savedLocation = [scanner scanLocation];
            if ([scanner scanString:@"#" intoString:NULL]) {
                // it's a numeric entity
                if ([scanner scanString:@"x" intoString:NULL]) {
                    // hexadecimal
                    unsigned int value;
                    if ([scanner scanHexInt:&value]) {
                        c = value;
                    } else {
                        valid = NO;
                    }
                } else {
                    // decimal
                    int value;
                    if ([scanner scanInt:&value] && value >= 0) {
                        c = value;
                    } else {
                        valid = NO;
                    }
                }
                if (![scanner scanString:@";" intoString:NULL]) {
                    // not ;-terminated, bail out and emit the whole entity
                    valid = NO;
                }
            } else {
                if (![scanner scanUpToString:@";" intoString:&temp]) {
                    // &; is not a valid entity
                    valid = NO;
                } else if (![scanner scanString:@";" intoString:NULL]) {
                    // there was no trailing ;
                    valid = NO;
                } else if ([temp isEqualToString:@"amp"]) {
                    c = '&';
                } else if ([temp isEqualToString:@"quot"]) {
                    c = '"';
                } else if ([temp isEqualToString:@"lt"]) {
                    c = '<';
                } else if ([temp isEqualToString:@"gt"]) {
                    c = '>';
                } else {
                    // unknown entity
                    valid = NO;
                }
            }
            if (!valid) {
                // we errored, just emit the whole thing raw
                [results appendString:[input substringWithRange:NSMakeRange(savedLocation, [scanner scanLocation]-savedLocation)]];
            } else {
                [results appendFormat:@"%C", (unichar)c];
            }
        }
    }
    return results;
}

+ (NSString *) stringToHtml:(NSString *) string {
    
    if ([string isEqual:[NSNull null]]) {
        return nil;
    }
    
    NSString *result = nil;
    result = [string stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    result = [result stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    result = [result stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    result = [result stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    return result;
}

+ (NSString *) stringFromHtml:(NSString *) html {
    NSString *result = nil;
    
    if ([html isEqual:[NSNull null]]) {
        return nil;
    }
    
    result = [html stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    result = [result stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    result = [result stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    result = [result stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    result = [result stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    result = [result stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    result = [result stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    
    result = [result stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"&iexcl;" withString:@"¡"];
    result = [result stringByReplacingOccurrencesOfString:@"&cent;" withString:@"¢"];
    result = [result stringByReplacingOccurrencesOfString:@"&pound;" withString:@"£"];
    result = [result stringByReplacingOccurrencesOfString:@"&curren;" withString:@"¤"];
    result = [result stringByReplacingOccurrencesOfString:@"&yen;" withString:@"¥"];
    result = [result stringByReplacingOccurrencesOfString:@"&brvbar;" withString:@"¦"];
    
    result = [result stringByReplacingOccurrencesOfString:@"&sect;" withString:@"§"];
    result = [result stringByReplacingOccurrencesOfString:@"&uml;" withString:@"¨"];
    result = [result stringByReplacingOccurrencesOfString:@"&copy;" withString:@"©"];
    result = [result stringByReplacingOccurrencesOfString:@"&ordf;" withString:@"ª"];
    result = [result stringByReplacingOccurrencesOfString:@"&laquo;" withString:@"«"];
    result = [result stringByReplacingOccurrencesOfString:@"&not;" withString:@"¬"];
    result = [result stringByReplacingOccurrencesOfString:@"&shy;" withString:@" "];
    
    result = [result stringByReplacingOccurrencesOfString:@"&reg;" withString:@"®"];
    result = [result stringByReplacingOccurrencesOfString:@"&macr;" withString:@"¯"];
    result = [result stringByReplacingOccurrencesOfString:@"&deg;" withString:@"°"];
    result = [result stringByReplacingOccurrencesOfString:@"&plusmn;" withString:@"±"];
    result = [result stringByReplacingOccurrencesOfString:@"&sup2;" withString:@"²"];
    result = [result stringByReplacingOccurrencesOfString:@"&sup3;" withString:@"³"];
    result = [result stringByReplacingOccurrencesOfString:@"&acute;" withString:@"´"];
    result = [result stringByReplacingOccurrencesOfString:@"&micro;" withString:@"µ"];
    result = [result stringByReplacingOccurrencesOfString:@"&para;" withString:@"¶"];
    result = [result stringByReplacingOccurrencesOfString:@"&spades;" withString:@"♠"];
    result = [result stringByReplacingOccurrencesOfString:@"&clubs;" withString:@"♣"];
    result = [result stringByReplacingOccurrencesOfString:@"&hearts;" withString:@"♥"];
    result = [result stringByReplacingOccurrencesOfString:@"&diams;" withString:@"♦"];
    
    result = [result stringByReplacingOccurrencesOfString:@"&euro;" withString:@"€"];
    result = [result stringByReplacingOccurrencesOfString:@"&permil;" withString:@"‰"];
    result = [result stringByReplacingOccurrencesOfString:@"&lsaquo;" withString:@"‹"];
    result = [result stringByReplacingOccurrencesOfString:@"&rsaquo;" withString:@"›"];
    result = [result stringByReplacingOccurrencesOfString:@"&euro;" withString:@"€"];
    
    result = [result stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"‘"];
    result = [result stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"’"];
    result = [result stringByReplacingOccurrencesOfString:@"&sbquo;" withString:@"‚"];
    result = [result stringByReplacingOccurrencesOfString:@"&bull;" withString:@"•"];
    
    result = [result stringByReplacingOccurrencesOfString:@"&hellip;" withString:@"…"];
    result = [result stringByReplacingOccurrencesOfString:@"&prime;" withString:@"′"];
    result = [result stringByReplacingOccurrencesOfString:@"&Prime;" withString:@"″"];
    result = [result stringByReplacingOccurrencesOfString:@"&oline;" withString:@"‾"];
    result = [result stringByReplacingOccurrencesOfString:@"&frasl;" withString:@"⁄"];
    
    result = [result stringByReplacingOccurrencesOfString:@"&weierp;" withString:@"℘"];
    result = [result stringByReplacingOccurrencesOfString:@"&image;" withString:@"ℑ"];
    result = [result stringByReplacingOccurrencesOfString:@"&real;" withString:@"ℜ"];
    result = [result stringByReplacingOccurrencesOfString:@"&trade;" withString:@"™"];
    result = [result stringByReplacingOccurrencesOfString:@"&alefsym;" withString:@"ℵ"];
    
    result = [result stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
    
    
    return result;
}

+ (NSData *) UUIDData {
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    CFUUIDBytes bytes = CFUUIDGetUUIDBytes(UUID);
    NSData *data = [[NSData alloc] initWithBytes:(void*)&bytes length:sizeof(bytes)];
    return [data autorelease];
}

+ (NSString *) OriginalUUID {
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUIDString = CFUUIDCreateString(kCFAllocatorDefault, UUID);
    NSString *result = [[NSString alloc] initWithString:(NSString*)UUIDString];
    if (UUID)
        CFRelease(UUID);
    if (UUIDString)
        CFRelease(UUIDString);
    return [result autorelease];
}

+ (NSString *)UUID {
    
//    CFUUIDRef theUUID = CFUUIDCreate(NULL);
//    NSString *uuidString = (NSString *) CFUUIDCreateString(NULL, theUUID);
//    CFRelease(theUUID);
//    return uuidString;
    
    return [[CommonHelper OriginalUUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
//
//+ (BOOL)checkNetCanUploading {
//    if ([[CinNetworkObserver Instance] getCurrentStatus] == NotReachable) {
//        return NO;
//    } else if ([[CinNetworkObserver Instance] getCurrentStatus] == ReachableViaWWAN){
//        return NO;
//    }
//    return YES;
//}
//
////#pragma mark - protobuf 头
////
////+ (void) bindProtobufRequest:(ASIHTTPRequest *)request
////                 usingMethod:(int)method
////                  withParams:(PBGeneratedMessage *)param {
////    
////    NSData *postData = [ProtobufferBuilder buildRequest:param
////                                           withMethodId:method
////                                           withDeviceId:[CommonHelper deviceIdentifier]
////                                     andInternalVersion:[[[ApplicationManager instance] internalVersion] longLongValue]];
////    
////    [request addRequestHeader:@"Content-type" value:@"application/qunarlvtustream;"];
//////    [request addRequestHeader:@"protoVersion" value:@"1"];
////    
////    [[request requestHeaders] setValue:@"Close" forKey:@"Connection"];
////    [[request requestHeaders] setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forKey:@"Content-Length"];
////    cinInfoLog(@"bindProtobufRequest, method is %@, param is %@, len is %d, data is %@", [[[request url] description] lastPathComponent], param, [postData length], postData);
////    [request appendPostData:postData];
////}
////
////+ (BOOL) protobufResultOutput:(ASIHTTPRequest *)request
////                 withBodyData:(NSData **) data
////                withErrorCode:(int*) errorCode {
////    if (errorCode)
////        *errorCode = -1;
////    NSError *error = nil;
////    @try {
////        error = [request error];
////        if (!error && [request responseStatusCode] == 200) {
////            NSData *responseData = [request responseData];
////            *data = [[ProtobufferBuilder bodyBufferWithFullBuffer:responseData
////                                                   withErrorCode:errorCode] retain];
////        } else {
////            cinWarnLog(@"request failed! %@ error is %@", [request url], error
////                       );
////        }
////    }
////    @catch (NSException *exception) {
////        
////    }
////    @finally {
////        return (error == nil) && (*errorCode == 0) && ([request responseStatusCode] == 200);
////    }
////}
//
//#pragma mark - 多个并发方法，hang住等待完成，不知道苹果的并发做得咋样，试试
//
//+ (void) batchRequestWithWorkerName:(NSString*) workName withblocks:(NSArray *) blocks {
//    dispatch_queue_t workerQueue = dispatch_queue_create([workName UTF8String], DISPATCH_QUEUE_CONCURRENT);
//    dispatch_group_t groupQueue = dispatch_group_create();
//    
//    for (dispatch_block_t worker in blocks) {
//        dispatch_group_async(groupQueue, workerQueue, ^{
//            worker();
//        });
//    }
//    dispatch_group_wait(groupQueue, DISPATCH_TIME_FOREVER);
//    dispatch_release(workerQueue);
//    dispatch_release(groupQueue);
//}
//
//#pragma mark - 将一个大数组按照容器容量分为n个小数组
//
//+ (NSArray *) splitArray:(NSArray *) theArray withMaxCounts:(NSUInteger) count {
//    NSMutableArray *theResult = nil;
//    if (theArray) {
//        if ([theArray count] > count) {
//            theResult = [[NSMutableArray alloc] initWithCapacity:5];
//            int pos = 0;
//            while (pos < [theArray count]) {
//                int remainning = (int)[theArray count] - pos;
//                int steps = count > remainning ? remainning : (int)count;
//                [theResult addObject:[theArray subarrayWithRange:(NSMakeRange(pos, steps))]];
//                pos += steps;
//            }
//        } else {
//            theResult = [[NSMutableArray alloc] initWithCapacity:5];
//            [theResult addObject:theArray];
//        }
//    }
//    return [theResult autorelease];
//}
//
//
//+(NSSet *) randomFrom:(int) min to:(int)max withItemCount:(int) count {
//    int total = max - min;
//    int realCount = total > count ? count : total;
//    NSMutableSet *resultSet = [[NSMutableSet alloc] initWithCapacity:realCount];
//    
//    while ([resultSet count] < realCount) {
//        [resultSet addObject:[NSNumber numberWithInteger:[CommonHelper randomFrom:min to:max]]];
//    }
//    return [resultSet autorelease];
//}
//
////
// 慎用该方法，各种判断都没有。只用于以下的sort方法。
+ (NSUInteger) randomFrom:(NSUInteger) min to:(NSUInteger) max {
    if (min >= max) return min;
    int value = (arc4random() % (max - min)) + 1;
//    int value = arc4random() % max;
    NSUInteger result = value + min;
//    cinInfoLog(@"random value from %d to %d, result is %d", min, max, result);
    return result;
}
//
//
//#pragma mark - 各种array 拆分、合并 方法
//
//
////if (lastArray == nil) {
////    [result addObject:theArray];
////} else {
////    if ([theArray count] + [lastArray count] < maxCount) {
////        [lastArray addObjectsFromArray:theArray];
////    } else {
////        [result addObject:theArray];
////    }
////}
//
////
//// 输入的是一个多个数组组合的数组，合并规则为，把这N个数组的对象按照最大值不超过maxCount的方式重新组合，合并成新的数组队列
//+ (NSArray *) combineArrayLists:(NSArray *) multiArrays withMaxCount:(int) maxCount {
//    NSMutableArray *resultArray = nil;
//    if (multiArrays && [multiArrays count] > 0) {
//        resultArray = [[NSMutableArray alloc] initWithCapacity:10];
//        for (NSArray *theArray in multiArrays) {
//            NSMutableArray *perArray = [NSMutableArray arrayWithArray:theArray];
//            NSMutableArray *lastArray = [resultArray lastObject];
//            if (lastArray == nil) {
//                [resultArray addObject:perArray];
//            } else {
//                if ([perArray count] + [lastArray count] < maxCount) {
//                    [lastArray addObjectsFromArray:perArray];
//                } else {
//                    [resultArray addObject:perArray];
//                }
//            }
//        }
//    }
//    return [resultArray autorelease];
//}
//
////
//// 按照顺序，把一个object加入到一个2纬数组内，2纬数组的规则是，如果该object的key已存在，则建立新的数组。
//+ (void) addObject:(id) anObject toArrayList:(NSMutableArray *) arrays withHashSet:(NSMutableSet*) mutableSet andKey:(id) key {
//    if (mutableSet && arrays && anObject) {
//        if (![mutableSet containsObject:key] || [arrays count] <= 0) {
//            [arrays addObject:[NSMutableArray arrayWithCapacity:10]];
//            [mutableSet addObject:key];
//        }
//        NSMutableArray *lastArray = [arrays lastObject];
//        [lastArray addObject:anObject];
//    }
//}
//
//#pragma mark - 时间函数
//#pragma mark - 判断某个时间的区间范围

//+ (NSRange)rangeOfWeek:(unsigned long long)timestamp {
//    NSDate *now = [NSDate dateWithTimeIntervalSince1970:timestamp];
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *comps = [cal
//                               components:NSYearCalendarUnit| NSMonthCalendarUnit| NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit
//                               fromDate:now];
//    if (comps.weekday <2)
//    {
//        comps.week = comps.week-1;
//    }
//    comps.weekday = 2;
//    NSDate *firstDay = [cal dateFromComponents:comps];
//}
//
//+ (NSRange)rangeOfQuarter:(unsigned long long)timestamp {
//}
//
//+ (NSRange)rangeOfMonth:(unsigned long long)timestamp {
//}
//
//+ (NSRange) rangeOfDay:(unsigned long long) timestamp {
//}

+(NSString *)getDocumentPath {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSString *)getCachePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSString *)getLibraryPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSString *)getTempPath {
    
    return NSTemporaryDirectory();
}

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+(NSString *) fileFormatSizeAtPath:(NSString *)filePath {

    NSString *_fileSizeFormat = @"0B";
    
    long long _fileSize = [CommonHelper fileSizeAtPath:filePath];
    if (_fileSize < 1024) {
        _fileSizeFormat = [NSString stringWithFormat:@"%lldB",_fileSize];
    }
    else if (_fileSize < 1024* 1024) {
        _fileSizeFormat = [NSString stringWithFormat:@"%.2fKB",_fileSize/1024.0f];
    }
    else if (_fileSize < 1024*1024*1024) {
        _fileSizeFormat = [NSString stringWithFormat:@"%.2fMB",_fileSize/(1024.0f*1024)];
    }
    else {
        _fileSizeFormat = [NSString stringWithFormat:@"%.2fGB",_fileSize/(1024*1024*1024.0f)];
    }
    
    return _fileSizeFormat;
}

//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

+ (void)getCurrentLanguage
{
//    [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages safe_objectAtIndex:0];
    NSLog( @"%@" , currentLanguage);
}

+ (NSString*)getPreferredLanguage
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    NSLog(@"当前语言:%@", preferredLang);
    return preferredLang;
}

+ (NSString *) freeDiskSpaceInBytes {
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return [NSString stringWithFormat:@"%qi GB" ,freespace/1024/1024/1024];
}

- (NSString *) platformString{
    // Gets a string with the device model
    
    return nil;

//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
//    free(machine);
//    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
//    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
//    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
//    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
//    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
//    
//    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
//    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
//    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
//    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
//    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
//    
//    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
//    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
//    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
//    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
//    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
//    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
//    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
//    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
//    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
//    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
//    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
//    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
//    
//    if ([platform isEqualToString:@"i386"])         return @"Simulator";
//    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
//    return platform;
}

@end
