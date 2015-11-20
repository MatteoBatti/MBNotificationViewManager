//
//  MBPushNotificationPresenter.m
//  Fineco
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 Wall Street On Demand. All rights reserved.
//

#import "MBPushNotificationPresenter.h"
#import "MBPushNotificationView.h"
@interface MBPushNotificationPresenter()
{
    UIView *_currentPresentingView;
}
@end


@implementation MBPushNotificationPresenter

-(void)dealloc
{
    self.completion = nil;
    [super dealloc];
}

-(void)presentNotificationView:(NSString *)view withNotification:(MBPushNotificationModel *)notification completionHandler:(MPPresenterCompletion)presenterCompletion;
{
    self.completion = presenterCompletion;
    
    MBPushNotificationView *pushNotificationView = [[[NSBundle mainBundle] loadNibNamed:view owner:nil options:nil] lastObject];
    if (!pushNotificationView) {
        pushNotificationView = [NSClassFromString(view) new];
    }
    
    if (pushNotificationView) {
        
        self.presentingView = pushNotificationView;
        
        [pushNotificationView populateViewWithNotification:notification presenter:self];
        
        pushNotificationView.alpha = 0.0;
        pushNotificationView.frame = CGRectMake(0, -pushNotificationView.frame.size.height, pushNotificationView.frame.size.width, pushNotificationView.frame.size.height);
        [[UIApplication sharedApplication].keyWindow addSubview:pushNotificationView];
        [self showView];
    }
    
}

-(void)showView
{
    self.presentingView.alpha = 1.0;
    [UIView animateWithDuration:0.2 animations:^{
        self.stopAutoHiding = NO;
        self.presentingView.frame = CGRectMake(0, 0, self.presentingView.frame.size.width, self.presentingView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self performSelector:@selector(hideView:) withObject:self.presentingView afterDelay:1.0];
        }
    }];
}

-(void)hideView:(UIView *)view;
{
    if (!self.stopAutoHiding && [self.presentingView isEqual:view]) {
        [self.presentingView setCenter:view.center];
        [UIView animateWithDuration:0.2 animations:^{
            view.frame = CGRectMake(0, - self.presentingView.frame.size.height , self.presentingView.frame.size.width, self.presentingView.frame.size.height);
        } completion:^(BOOL finished) {
            if (finished) {
                view.alpha = 0.0;
                if (self.completion) {
                    self.completion();
                    self.completion = nil;
                }
            }
        }];
    }
}

-(void)hideViewFromSwipe:(UIView *)view;
{
    if ([self.presentingView isEqual:view]) {
        [self.presentingView setCenter:view.center];
        [UIView animateWithDuration:0.1 animations:^{
            view.frame = CGRectMake(0, - self.presentingView.frame.size.height , self.presentingView.frame.size.width, self.presentingView.frame.size.height);
        } completion:^(BOOL finished) {
            if (finished) {
                view.alpha = 0.0;
                if (self.completion) {
                    self.completion();
                    self.completion = nil;
                }
            }
        }];
    }
}

-(void)showViewFromSwipe:(UIView *)view;
{
    if ([self.presentingView isEqual:view]) {
        [self.presentingView setCenter:view.center];
        [UIView animateWithDuration:0.1 animations:^{
            view.frame = CGRectMake(0, 0 , self.presentingView.frame.size.width, self.presentingView.frame.size.height);
        } completion:nil];
    }
}

-(void)finishPresentingView;
{
    self.presentingView.alpha = 0.0;
    if (self.completion) {
        self.completion();
        self.completion = nil;
    }
}

@end
