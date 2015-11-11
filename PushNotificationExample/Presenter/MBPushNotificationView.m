//
//  MBPushNotificationView.m
//  Fineco
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 Wall Street On Demand. All rights reserved.
//

#import "MBPushNotificationView.h"
@interface MBPushNotificationView() <UIGestureRecognizerDelegate>
{
    CGFloat _firstX;
    CGFloat _firstY;
}
@end

@implementation MBPushNotificationView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_title release];
    [_info release];
    _wrapperTapHandler = nil;
    [super dealloc];
}

-(void)populateViewWithNotification:(MBPushNotificationModel *)model presenter:(MBPushNotificationPresenter *)presenter;
{
    self.presenter = presenter;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognize:)];
    [self addGestureRecognizer:pan];
    [pan release];
    
    
    self.wrapperTapHandler = ^{
        model.tapHandler();
        [presenter hideView:self];
    };
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapHandler)];
    [self addGestureRecognizer:tap];
    [tap release];
    
    self.title.text = model.alert;
    self.info.text = model.alert;
}


-(void)singleTapHandler
{
    self.wrapperTapHandler();
    self.wrapperTapHandler = nil;
}

-(void)panGestureRecognize:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translatedPoint = [recognizer translationInView:self];
    
    if ([recognizer state] == UIGestureRecognizerStateBegan) {
        self.presenter.stopAutoHiding = YES;
        _firstX = [self center].x;
        _firstY = [self center].y;
    }
    NSLog(@"first %f", _firstY);
    
    if ([recognizer state] == UIGestureRecognizerStateEnded) {
        self.presenter.stopAutoHiding = NO;
        [self.presenter hideView:self];
    }
    
    
    CGFloat velocity = 0.8;
    CGFloat newCenterY = _firstY + (translatedPoint.y*velocity);
    
    if (newCenterY > self.frame.size.height/2.0) {
        newCenterY = self.frame.size.height/2.0;
    }
    
    translatedPoint = CGPointMake(self.center.x, newCenterY);
    
    [self setCenter:translatedPoint];
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
