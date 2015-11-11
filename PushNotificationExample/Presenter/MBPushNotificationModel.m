//
//  MBNotificationModel.m
//  Fineco
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 Wall Street On Demand. All rights reserved.
//

#import "MBPushNotificationModel.h"

@implementation MBPushNotificationModel

-(void)dealloc
{
    _tapHandler = nil;
    [_alert release];
    [_badge release];
    [_sound release];
    [super dealloc];
}


+(MBPushNotificationModel *)createFromNotificationInfo:(NSDictionary *)notificationUserInfo;
{
    MBPushNotificationModel *model = MBPushNotificationModel.new;
    model.alert = notificationUserInfo[@"aps"][@"alert"];
    model.badge = notificationUserInfo[@"aps"][@"badge"];
    model.sound = notificationUserInfo[@"aps"][@"sound"];
    return model;
}

+(MBPushNotificationModel *)createFromNotificationInfo:(NSDictionary *)notificationUserInfo andTapHandler:(MBNotificationViewTapHandler)taphandler;
{
    MBPushNotificationModel *model = [MBPushNotificationModel createFromNotificationInfo:notificationUserInfo];
    model.tapHandler = taphandler;
    return model;
}

-(void)fillFromNotificationInfo:(NSDictionary *)notificationUserInfo;
{
    self.alert = notificationUserInfo[@"aps"][@"alert"];
    self.badge = notificationUserInfo[@"aps"][@"badge"];
    self.sound = notificationUserInfo[@"aps"][@"sound"];
}

-(void)fillFromNotificationInfo:(NSDictionary *)notificationUserInfo andTapHandler:(MBNotificationViewTapHandler)tapHandler;
{
    [self fillFromNotificationInfo:notificationUserInfo];
    self.tapHandler = tapHandler;
}

@end
