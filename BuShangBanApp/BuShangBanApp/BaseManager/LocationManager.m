//
//  LocationManager.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "LocationManager.h"
//#import "EarthCoor2MarsCoor.h"

typedef struct _tagLocationRegion {
    double latitude;
    double longitude;
    double radius;
    NSString* key;
} LocationRegion;



@interface LocationManager (){
    BOOL _locationServicesEnabled;
}

@property (nonatomic, retain) CLLocationManager *locationManager;   // 定位管理器

@end


@implementation LocationManager

@synthesize locationManager = _locationManager;
@synthesize location = _location;
@synthesize initialized;

+(LocationManager *)Instance {
    
    static LocationManager *sharedLocationManagerInstance = nil;
    static dispatch_once_t onceDispatch;
    
    dispatch_once(&onceDispatch, ^{
        sharedLocationManagerInstance = [[LocationManager alloc] init];
    });
    
    return sharedLocationManagerInstance;
}

- (void) startCheckLocation {
    
    if (self.locationManager) {
        [self.locationManager stopMonitoringSignificantLocationChanges];
        [self.locationManager stopUpdatingLocation];
    }
    
//    self.location = nil;
    [self.locationManager startUpdatingLocation];
}

-(void)stopLocation {

    [self.locationManager stopUpdatingLocation];
}

- (BOOL)locationServeresEnable{
    
    return _locationServicesEnabled;
}

- (void)dealloc
{
    [_locationList release];
    if(_locationManager != nil)
    {
        [_locationManager stopUpdatingLocation];
        
        // 解决某些破解版的系统bug
        if([_locationManager respondsToSelector:@selector(stopMonitoringSignificantLocationChanges)] == YES)
        {
            [_locationManager stopMonitoringSignificantLocationChanges];
        }
        
        [_locationManager setDelegate:nil];
        [_locationManager release];
    }
    
    [_location release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setInitialized:NO];
        if ([CLLocationManager locationServicesEnabled]) {
            
            
            
            _isCanAccess = NO;
            CLLocationManager *_tempLocationManager = [[CLLocationManager alloc] init];
            //设置委托对象为自己
            [_tempLocationManager setDelegate:self];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
                
                if([_tempLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                    [_tempLocationManager requestAlwaysAuthorization]; // 永久授权   YES
                    [_tempLocationManager requestWhenInUseAuthorization]; //使用中授权  YES
                }
            }
            
            //要求CLLocationManager对象返回全部结果
            [_tempLocationManager setDistanceFilter:kCLDistanceFilterNone];
//            self.locationManager.distanceFilter = 1000.0f;
            
            //要求CLLocationManager对象的返回结果尽可能的精准
            [_tempLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            //要求CLLocationManager对象开始工作，定位设备位置
//            [_tempLocationManager startUpdatingLocation];
            
            // 设置位置管理权
            [self setLocationManager:_tempLocationManager];
            [_tempLocationManager release];
        }
        else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有授权定位" message:@"该设备没有授权定位，请在隐私设置中授权定位" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
//            [alert show];
//            [alert release];
        }
    }
    return self;
}

- (BOOL)canAccess {
    return _isCanAccess;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self setInitialized:YES];
    _isCanAccess = YES;
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckEnvironmentOver" object:nil];
    
    if (manager) {
        [manager stopMonitoringSignificantLocationChanges];
        [manager stopUpdatingLocation];
    }
    
    _locationServicesEnabled = YES;
    
    if (newLocation != nil)
    {
        
        [[self locationManager] stopUpdatingLocation];
        self.location = newLocation;
        
//        CLLocationCoordinate2D tempCoordinate2D = [EarthCoor2MarsCoor getMarsCoorWithEarthCoor:newLocation.coordinate];
//        CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:tempCoordinate2D.latitude longitude:tempCoordinate2D.longitude];
//        self.location = tempLocation;
        [[KVStoreManager sharedInstance] saveObj:@{@"Longitude":@(newLocation.coordinate.longitude),@"Latitude":@(newLocation.coordinate.latitude)} forKey:@"AddressCoordinate"];
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placemark in placemarks) {
                
                NSDictionary *_tempAddressInfo = [placemark addressDictionary];
                //  Country(国家)  State(城市)  SubLocality(区)
                NSLog(@"%@", [_tempAddressInfo objectForKey:@"State"]);
                [self setAddressInfo:_tempAddressInfo];
                
                [[KVStoreManager sharedInstance] saveObj:SafeForDictionary(_tempAddressInfo) forKey:@"AddressDictionary"];
//                [[NSNotificationCenter defaultCenter] postNotificationName:kLocalAdressCompletionNotification object:_tempAddressInfo];
            }
        }];

//        [[UserData instance] setLocation:newLocation];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerCompletionNotification
                                                            object:self
                                                          userInfo:nil];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    [self setInitialized:YES];
    _locationServicesEnabled = NO;
    [[self locationManager] stopUpdatingLocation];
    
    _isCanAccess = ([error code] != kCLErrorDenied);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckEnvironmentOver" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerCompletionNotification object:self userInfo:nil];
}

//- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
//    cinInfoLog(@"didEnterRegion! - %@", region);
//    UILocalNotification *newNotification = [[UILocalNotification alloc] init];
//    if (newNotification) {
//        newNotification.alertBody = [NSString stringWithFormat:@"您已来到了 - %@", [region identifier]];
//        newNotification.applicationIconBadgeNumber = 1;
//        newNotification.alertAction = @"关闭";
//        [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
//    }
//    [newNotification release];
//}

//- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
//    cinInfoLog(@"didExitRegion! - %@", region);
//    UILocalNotification *newNotification = [[UILocalNotification alloc] init];
//    if (newNotification) {
//        newNotification.alertBody = [NSString stringWithFormat:@"您已离开了 - %@", [region identifier]];
//        newNotification.applicationIconBadgeNumber = 1;
//        newNotification.alertAction = @"关闭";
//        [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
//    }
//    [newNotification release];
//}

#pragma mark - location init data

- (void) initLocationData {
    
}

@end
