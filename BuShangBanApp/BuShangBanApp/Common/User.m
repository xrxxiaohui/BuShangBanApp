//
//  User.m
//  BuShangBanApp
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "User.h"

NSString *kUserAvatar = @"kUserAvatar";
NSString *kUserIDsign = @"kUserIDsign";
NSString *kUserNickName = @"kUserNickName";
NSString *kUserExperience = @"kUserExperience";

NSString *kUserAddress = @"kUserAddress";
NSString *kUserBirthDay = @"kUserBirthDay";
NSString *kUserOccupation = @"kUserOccupation";
NSString *kUserInterest = @"kUserInterest";

@interface User () <NSCopying>

@end


@implementation User

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        [coder decodeObjectForKey:kUserAvatar];
        [coder decodeObjectForKey:kUserIDsign];
        [coder decodeObjectForKey:kUserNickName];
        [coder decodeObjectForKey:kUserExperience];

        [coder decodeObjectForKey:kUserAddress];
        [coder decodeObjectForKey:kUserBirthDay];
        [coder decodeObjectForKey:kUserOccupation];
        [coder decodeObjectForKey:kUserInterest];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    User *user = [[[self class] allocWithZone:zone] init];

    user.nickname = [self.nickname copyWithZone:zone];
    user.avatar = [self.avatar copyWithZone:zone];
    user.UserExtend.IDsign = [self.UserExtend.IDsign copyWithZone:zone];
    user.UserExtend.experience = [self.UserExtend.experience copyWithZone:zone];

    user.address = [self.address copyWithZone:zone];
    user.birthDay = [self.birthDay copyWithZone:zone];
    user.UserExtend.occupation = [self.UserExtend.occupation copyWithZone:zone];
    user.UserExtend.interest = [self.UserExtend.interest copyWithZone:zone];

    return user;
}

- (void)modelEncodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_avatar forKey:kUserAvatar];
    [aCoder encodeObject:_UserExtend.IDsign forKey:kUserIDsign];
    [aCoder encodeObject:_nickname forKey:kUserNickName];
    [aCoder encodeObject:_UserExtend.experience forKey:kUserExperience];

    [aCoder encodeObject:_address forKey:kUserAddress];
    [aCoder encodeObject:_birthDay forKey:kUserBirthDay];
    [aCoder encodeObject:_UserExtend.occupation forKey:kUserOccupation];
    [aCoder encodeObject:_UserExtend.interest forKey:kUserInterest];
}

@end
