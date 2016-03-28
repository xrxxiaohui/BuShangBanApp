#import <UIKit/UIKit.h>


@interface BuShangBanCalendar : UIView


@property(strong, nonatomic) NSDate *date;

- (instancetype)initWithCurrentDate:(NSDate *)date;

@end
