//
//  MyCustomNotificationViewClass.m
//  PushNotificationExample
//
//  Created by Matteo Battistini on 24/11/15.
//  Copyright © 2015 MB. All rights reserved.
//

#import "MyCustomNotificationViewClass.h"
#import "MBPushNotificationModelExtension.h"

@implementation MyCustomNotificationViewClass

-(void)populateViewWithNotification:(MBPushNotificationModel *)model presenter:(MBPushNotificationPresenter *)presenter
{
    [super populateViewWithNotification:model presenter:presenter];
    self.myCustomValue.text = ((MBPushNotificationModelExtension *)model).myCustomPayloadValue;
}

@end
