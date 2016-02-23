//
//  ViewController.m
//  Notification
//
//  Created by qingyun on 16/2/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)regist:(id)sender {
    
    UILocalNotification * local = [[UILocalNotification alloc]init];
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:10];
    
    local.fireDate = date;
    
    local.alertBody = @"该吃饭了";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:local];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
