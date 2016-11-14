// 
// Wire
// Copyright (C) 2016 Wire Swiss GmbH
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
// 


#import "ZMUser+Additions.h"
#import "zmessaging+iOS.h"
#import "UIColor+WAZExtensions.h"
#import "Analytics+iOS.h"


ZMUser *BareUserToUser(id bareUser) {
    ZMUser *user = nil;
    if ([bareUser isKindOfClass:[ZMSearchUser class]]) {
        user = ((ZMSearchUser *)bareUser).user;
    } else if ([bareUser isKindOfClass:[ZMUser class]]) {
        user = (ZMUser *)bareUser;
    }
    return user;
}



@implementation ZMSearchUser (Additions)

- (UIColor *)accentColor
{
    return [UIColor colorForZMAccentColor:self.accentColorValue];
}

@end




@implementation ZMUser (Additions)

- (void)toggleBlocked
{
    if (self.isBlocked) {
        [self accept];
        [[Analytics shared] tagUnblocking];
    } else {
        [self block];
        [[Analytics shared] tagBlockingAction:BlockingTypeBlock];
    }
}

- (UIColor *)accentColor
{
    return [UIColor colorForZMAccentColor:self.accentColorValue];
}

- (ZMAddressBookContact *)contact
{
    return [self matchingContact:[ZMUserSession sharedSession]];
}

+ (instancetype)selfUser
{
    Class mockUserClass = NSClassFromString(@"MockUser");
    if (mockUserClass != nil) {
        return [mockUserClass selfUserInUserSession:nil];
    }
    else {
        return [ZMUser selfUserInUserSession:[ZMUserSession sharedSession]];
    }
}

+ (ZMUser<ZMEditableUser> *)editableSelfUser
{
    return [ZMUser selfUserInUserSession:[ZMUserSession sharedSession]];
}

+ (BOOL)isSelfUserActiveParticipantOfConversation:(ZMConversation *)conversation
{
    ZMUser *selfUser = [self selfUser];
    return [conversation.activeParticipants containsObject:selfUser];
}

- (BOOL)isPendingApproval
{
    return (self.isPendingApprovalBySelfUser || self.isPendingApprovalByOtherUser);
}

+ (BOOL)selfUserHasIncompleteUserDetails;
{
    return [[[ZMUser selfUser] emailAddress] length] == 0 || [[[ZMUser selfUser] phoneNumber] length] == 0;
}

+ (ZMAccentColor)pickRandomAcceptableAccentColor
{
    ZMAccentColor accentColorValue;

    do {
        accentColorValue = arc4random_uniform(ZMAccentColorMax) + 1;
    }
    while (accentColorValue == ZMAccentColorSoftPink ||
           accentColorValue == ZMAccentColorStrongLimeGreen ||
           accentColorValue == ZMAccentColorVividRed ||
           accentColorValue == ZMAccentColorBrightYellow);

    return accentColorValue;
}

+ (ZMAccentColor)pickRandomAccentColor
{
    ZMAccentColor accentColorValue;
    
    accentColorValue = arc4random_uniform(ZMAccentColorMax) + 1;

    return accentColorValue;
}

@end
