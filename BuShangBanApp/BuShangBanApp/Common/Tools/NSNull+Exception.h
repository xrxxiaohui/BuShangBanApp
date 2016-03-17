//
//  NSNull+Exception.h
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/30.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (Exception)

-(void)safeString;
-(void)safeArray;
-(void)safeDictionary;
-(void)safeNumber;
-(void)rangeOfCharacterFromSet:(id)idSet;
-(void)length;

@end
