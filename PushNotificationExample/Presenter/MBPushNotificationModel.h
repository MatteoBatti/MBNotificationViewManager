//
//  MBNotificationModel.h
//  Fineco
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 Wall Street On Demand. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MBNotificationViewTapHandler)();

@interface MBPushNotificationModel : NSObject

@property (nonatomic, strong) NSString *alert;
@property (nonatomic, strong) NSNumber *badge;
@property (nonatomic, strong) NSString *sound;

@property (nonatomic, copy) MBNotificationViewTapHandler tapHandler;

+(MBPushNotificationModel *)createFromNotificationInfo:(NSDictionary *)notificationUserInfo;
+(MBPushNotificationModel *)createFromNotificationInfo:(NSDictionary *)notificationUserInfo andTapHandler:(MBNotificationViewTapHandler)taphandler;
-(void)fillFromNotificationInfo:(NSDictionary *)notificationUserInfo;
-(void)fillFromNotificationInfo:(NSDictionary *)notificationUserInfo andTapHandler:(MBNotificationViewTapHandler)tapHandler;

@end
