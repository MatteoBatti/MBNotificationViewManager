//
//  MBPushNotificationCenter.h
//  Fineco
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 Wall Street On Demand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBPushNotificationModel.h"

@interface MBPushNotificationCenter : NSObject


@property (nonatomic, strong) NSString *viewNotificationClass;

+(instancetype)sharedInstance;

-(void)presentPushNotificationWithTapHandler:(NSDictionary *)notification tapCompletionHandler:(MBNotificationViewTapHandler)tapHandler;

-(void)presentPushNotificationWithModel:(MBPushNotificationModel *)notification_model tapCompletionHandler:(MBNotificationViewTapHandler)tapHandler;


@end
