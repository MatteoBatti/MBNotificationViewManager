//
//  MBPushNotificationUtils.m
//  PushNotificationExample
//
//  Created by Matteo Battistini on 30/11/15.
//  Copyright © 2015 MB. All rights reserved.
//

#import "MBPushNotificationUtils.h"

@implementation MBPushNotificationUtils


+(CGFloat)screenWidth;
{
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        return [UIScreen mainScreen].bounds.size.width;
    } else {
        return [UIScreen mainScreen].bounds.size.height;
    }
}

@end
