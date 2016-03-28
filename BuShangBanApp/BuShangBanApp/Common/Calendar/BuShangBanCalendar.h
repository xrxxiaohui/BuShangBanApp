//
//  BuShangBanCalendar.h
//  FDCalendarDemo
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>


//@protocol CalendarDelegate <NSObject>
//
//-(void)calenderWithDate:(NSDate *)date;
//
//@end

@interface BuShangBanCalendar : UIView

//@property(nonatomic,strong)id<CalendarDelegate> delegate;

@property (strong, nonatomic) NSDate *date;

- (instancetype)initWithCurrentDate:(NSDate *)date;

@end
