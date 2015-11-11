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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push:(id)sender {
    
    NSDictionary *not = @{ @"aps" : @{@"alert": @"prova titolo"}};
    
    __weak ViewController *weakSelf = self;
    
    [[MBPushNotificationCenter sharedInstance] presentPushNotificationWithTapHandler:not tapCompletionHandler:^{
        [weakSelf tapNotification];
    }];
    
}

-(void)tapNotification
{
    NSLog(@"tap notification");
}

@end
