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

@import WireSyncEngine;
@class MockMessage;

@interface MockMessageFactory: NSObject
+ (MockMessage *)textMessageIncludingRichMedia:(BOOL)shouldIncludeRichMedia;
+ (MockMessage *)textMessageWithText:(NSString *)text;
+ (MockMessage *)pingMessage;
+ (MockMessage *)linkMessage;
+ (MockMessage *)imageMessage;
+ (MockMessage *)videoMessage;
+ (MockMessage *)audioMessage;
+ (MockMessage *)pendingImageMessage;
+ (MockMessage *)imageMessageWithImage:(UIImage *)image;
+ (MockMessage *)systemMessageWithType:(ZMSystemMessageType)systemMessageType
                                 users:(NSUInteger)users
                               clients:(NSUInteger)numClients;
+ (MockMessage *)fileTransferMessage;
+ (MockMessage *)locationMessage;

+ (MockMessage *)expiredImageMessage;
+ (MockMessage *)expiredVideoMessage;
+ (MockMessage *)expiredAudioMessage;
+ (MockMessage *)expiredFileMessage;
+ (MockMessage *)expiredLinkMessage;
@end
