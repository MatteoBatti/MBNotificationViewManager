//
//  MBPushNotificationModelExtension.m
//  Fineco
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 Wall Street On Demand. All rights reserved.
//

#import "MBPushNotificationModelExtension.h"

@implementation MBPushNotificationModelExtension

-(void)fillFromNotificationInfo:(NSDictionary *)notificationUserInfo
{
    [super fillFromNotificationInfo:notificationUserInfo];
    //
    self.myCustomPayloadValue = notificationUserInfo[@"aps"][@"myCustomPayloadValue"];
}

-(void)dealloc
{
    [_myCustomPayloadValue release];
    [super dealloc];
}

@end
