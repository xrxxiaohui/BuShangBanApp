//
//  BaseWebViewController.h
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/12.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "ArrowBackViewController.h"

@interface BaseWebViewController : ArrowBackViewController

@property (nonatomic, copy) NSString* webUrl;
@property (nonatomic, assign) BOOL isTestWeb;
@property (nonatomic, copy) NSDictionary* dataDics;
@property (nonatomic, copy) NSString* objectID;

@end
