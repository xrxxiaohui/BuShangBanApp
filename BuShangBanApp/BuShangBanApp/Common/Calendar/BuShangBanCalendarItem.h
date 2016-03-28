#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height

@protocol CalendarItemDelegate;

@interface BuShangBanCalendarItem : UIView

@property(strong, nonatomic) NSDate *date;
@property(weak, nonatomic) id <CalendarItemDelegate> delegate;

- (NSDate *)nextMonthDate;

- (NSDate *)previousMonthDate;

@end

@protocol CalendarItemDelegate <NSObject>

- (void)calendarItem:(BuShangBanCalendarItem *)item didSelectedDate:(NSDate *)date;

@end
