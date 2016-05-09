//
//  APIRequestManager.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "APIRequestManager.h"
//#import "MiPushSDK.h"
#import "LocationManager.h"

static id _apiRequestInstance;

@implementation APIRequestManager

// 单例
+(instancetype)sharedInstance {
    
    static dispatch_once_t onceDispatch;
    
    dispatch_once(&onceDispatch, ^{
        _apiRequestInstance = [[APIRequestManager alloc] init];
    });
    
    return _apiRequestInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //onceToken是GCD用来记录是否执行过 ，如果已经执行过就不再执行(保证执行一次）
        _apiRequestInstance = [super allocWithZone:zone];
    });
    return _apiRequestInstance;
}

-(id)copyWithZone:(NSZone *)zone {
    
    return _apiRequestInstance;
}

-(void)postDeviceTokenReq {

    // 请求
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    //    [_urlParamsReq setUrlString:@"/college/api/get_highschool/"];
    //    [_urlParamsReq setUrlString:@"/college/api/get_undergradudate/"];
    [_urlParamsReq setUrlString:@"/account/api/add_users_device/"];
    
    //    NSString *_skeyString = kServerKeyString;
    //    [self setDataInfo:@{@"id":@"1"}];
    
    NSDictionary *_tempTokenInfo = [[KVStoreManager sharedInstance] getObjWithKey:kDeviceToken];
    NSString *_tempTokenString = [_tempTokenInfo objectForKey:kDeviceToken];
    
    if (!_tempTokenString) {
        _tempTokenString = [CommonHelper deviceIdentifier];
    }
    
//    CLLocationCoordinate2D _tempCoordinate = [LocationManager Instance].location.coordinate;
    
//    NSDictionary *_coordinateInfo = [[KVStoreManager sharedInstance] getObjWithKey:@"AddressCoordinate"];
//    NSString *_longitudeString = [NSString stringWithFormat:@"%@",[_coordinateInfo objectForKey:@"Longitude"]];
//    NSString *_latitudeString = [NSString stringWithFormat:@"%@",[_coordinateInfo objectForKey:@"Latitude"]];
//    
//    NSDictionary *_addressInfo = [[KVStoreManager sharedInstance] getObjWithKey:@"AddressDictionary"];
    
//    <__NSArrayI 0x134ec6ff0>(
//                             SubLocality,
//                             Street,
//                             State,
//                             CountryCode,
//                             Thoroughfare,=========
//                             Name,
//                             Country,
//                             FormattedAddressLines,
//                             City
//                             )
    
//    NSDictionary *_tempParam = @{@"bid":@"888888",@"token":SafeForString([[UserAccountManager sharedInstance] getCurrentToken]),@"cid":SafeForString(_tempTokenString)/*,@"platform":@"ios"*/,@"longitude":SafeForString(_longitudeString),@"latitude":SafeForString(_latitudeString),@"province":SafeForString([_addressInfo objectForKey:@"State"]),@"city":SafeForString([_addressInfo objectForKey:@"City"]),@"sublocality":SafeForString([_addressInfo objectForKey:@"SubLocality"]),@"street":SafeForString([_addressInfo objectForKey:@"Street"])};//@{@"token":tokenStr};
//    
//    NSMutableArray *_subScibeArray = [[NSMutableArray alloc] initWithCapacity:0];
//    
//    if ([[_addressInfo objectForKey:@"State"] isKindOfClass:[NSString class]]) {
//        [_subScibeArray addObject:SafeForString([_addressInfo objectForKey:@"State"])];
//    }
//    if ([[_addressInfo objectForKey:@"City"] isKindOfClass:[NSString class]]) {
//        [_subScibeArray addObject:SafeForString([_addressInfo objectForKey:@"City"])];
//    }
//    if ([[_addressInfo objectForKey:@"SubLocality"] isKindOfClass:[NSString class]]) {
//        [_subScibeArray addObject:SafeForString([_addressInfo objectForKey:@"SubLocality"])];
//    }
//    if ([[_addressInfo objectForKey:@"Street"] isKindOfClass:[NSString class]]) {
//        [_subScibeArray addObject:SafeForString([_addressInfo objectForKey:@"Street"])];
//    }
//    
//    if ([[_subScibeArray copy] count] > 0) {
//       // [MiPushSDK subscribe:[[_subScibeArray copy] componentsJoinedByString:@","]];
//    }
//    
//    [_urlParamsReq setParamsDict:_tempParam];
    
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        NSDictionary *_resultInfo = [_successInfo objectForKey:@"result"];
        NSDictionary *_businessData = [_resultInfo objectForKey:@"businessData"];
        
        NSLog(@"result: %@",_businessData);
        
    } failureBlock:^(SSLXResultRequest *failReq){
        
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        if (_errorMsg) {
            
            [MBProgressHUD showError:_errorMsg];
            
            //            UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:nil message:_errorMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            //            [_alertView show];
        }
        else {
            [MBProgressHUD showError:kMBProgressErrorTitle];
        }
    }];
}

@end
