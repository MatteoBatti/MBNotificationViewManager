//
//  MBPushNotificationView.h
//  Fineco
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 Wall Street On Demand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBPushNotificationModel.h"
#import "MBPushNotificationPresenter.h"

typedef void (^WrapperTapHandler)(void);

@interface MBPushNotificationView : UIView

@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *info;
@property (nonatomic, assign) MBPushNotificationPresenter *presenter;
@property (nonatomic, copy) WrapperTapHandler wrapperTapHandler;


-(void)populateViewWithNotification:(MBPushNotificationModel *)model presenter:(MBPushNotificationPresenter *)presenter;


@end
