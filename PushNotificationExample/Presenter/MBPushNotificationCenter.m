//
//  MBPushNotificationCenter.m
//  Fineco
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 Wall Street On Demand. All rights reserved.
//

#import "MBPushNotificationCenter.h"
#import "MBPushNotificationPresenter.h"

@interface MBPushNotificationCenter ()
{
    NSMutableArray *_notificationQueue;
    NSObject *_mutexObj;
    NSLock *_mutexLock;
    MBPushNotificationPresenter *_presenter;
}

@end


@implementation MBPushNotificationCenter

+(instancetype)sharedInstance
{
    static MBPushNotificationCenter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MBPushNotificationCenter alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _notificationQueue = [NSMutableArray new];
        _mutexObj = [NSObject new];
        _mutexLock = [NSLock new];
        _viewNotificationClass = [NSString new];
        _presenter = [MBPushNotificationPresenter new];
        _viewNotificationClass = @"MBPushNotificationView";
    }
    return self;
}

-(void)presentPushNotificationWithTapHandler:(NSDictionary *)notification tapCompletionHandler:(MBNotificationViewTapHandler)tapHandler;
{
    MBPushNotificationModel *newNot = [MBPushNotificationModel createFromNotificationInfo:notification andTapHandler:tapHandler];
    [self enqueueNotification:newNot];
}

-(void)presentPushNotificationWithModel:(MBPushNotificationModel *)notification_model tapCompletionHandler:(MBNotificationViewTapHandler)tapHandler;
{
    notification_model.tapHandler = tapHandler;
    [self enqueueNotification:notification_model];
}

-(void)enqueueNotification:(MBPushNotificationModel *)notification
{
    @synchronized(_mutexObj) {
        [_notificationQueue addObject:notification];
    }
    [self presentNotificationView];
}

-(MBPushNotificationModel *)dequeueNotification
{
    MBPushNotificationModel *notification = nil;
    @synchronized(_mutexObj) {
        if (_notificationQueue.count > 0) {
            notification = [_notificationQueue objectAtIndex:0];
            [_notificationQueue removeObjectAtIndex:0];
        }
    }
    return notification;
}

-(void)presentNotificationView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_mutexLock tryLock]) {
            MBPushNotificationModel *not = [self dequeueNotification];
            if (not) {
                __weak MBPushNotificationCenter *weakSelf = self;
                [_presenter presentNotificationView:_viewNotificationClass withNotification:not completionHandler:^{
                    [_mutexLock unlock];
                    [not release];
                    [weakSelf presentNotificationView];
                }];
            } else {
                [_mutexLock unlock];
            }
        }
    });
}


@end
