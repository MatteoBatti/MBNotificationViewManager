//
//  MBPushNotificationPresenter.h
//  Fineco
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 Wall Street On Demand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBPushNotificationModel.h"

typedef void (^MPPresenterCompletion)(void);

@interface MBPushNotificationPresenter : NSObject


@property (nonatomic, assign) UIView *presentingView;
@property (nonatomic, copy) MPPresenterCompletion completion;
@property (nonatomic, assign) BOOL stopAutoHiding;

-(void)presentNotificationView:(NSString *)view withNotification:(MBPushNotificationModel *)notification completionHandler:(MPPresenterCompletion)presenterCompletion;
-(void)hideView:(UIView *)view;
-(void)finishPresentingView;

@end
