//
//  LocationManager.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kLocationManagerCompletionNotification      @"LocationManagerCompletionNotification"
#define kLocalAdressCompletionNotification          @"LocalAddressCompleteNotification"

@interface LocationManager : NSObject<CLLocationManagerDelegate> {

    BOOL _isCanAccess;
    NSMutableArray *_locationList;
}
@property (nonatomic, assign) BOOL initialized;
@property (nonatomic, readonly) BOOL isCanAccess;

@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) CLLocation *fakeLocation;

@property (nonatomic, retain) NSDictionary *addressInfo;

+(LocationManager *)Instance ;
-(void)startCheckLocation;
-(BOOL)locationServeresEnable;

-(void)stopLocation;

@end
