//
//  ViewController.m
//  PushNotificationExample
//
//  Created by Matteo Battistini on 27/10/15.
//  Copyright © 2015 MB. All rights reserved.
//

#import "ViewController.h"
#import "MBPushNotificationCenter.h"

@interface ViewController ()
{
    NSUInteger counter;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    counter = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push:(id)sender {
    
    
    NSString *msg = [NSString stringWithFormat:@"push view n. %li", counter];
    NSDictionary *not = @{ @"aps" : @{@"alert": msg}};
    
    __weak ViewController *weakSelf = self;
    
    [[MBPushNotificationCenter sharedInstance] presentPushNotificationWithTapHandler:not tapCompletionHandler:^{
        [weakSelf tapNotification];
    }];
    
    counter ++;
    
}

-(void)tapNotification
{
    NSLog(@"tap notification");
}

@end
