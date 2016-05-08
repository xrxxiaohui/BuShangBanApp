//
//  AccessSendSmsApi.h
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/4.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "SSLXBaseRequest.h"

@interface AccessSendSmsApi : SSLXBaseRequest

-(id)initWithUserPhone:(NSString *)userPhone;

@end
