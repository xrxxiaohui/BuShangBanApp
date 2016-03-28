

#import "AreaObject.h"

@implementation AreaObject

- (NSString *)description {
//    return [NSString stringWithFormat:@"%@ %@ %@ %@",self.region,self.province,self.city,self.area];
    return [NSString stringWithFormat:@"%@  %@ %@", self.provinceStr, self.cityStr, self.districtStr];
}

@end

