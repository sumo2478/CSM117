//
//  ScheduleDetailViewController.m
//  Schedule Adder
//
//  Created by user on 2014/5/11.
//  Copyright (c) 2014年 cs117. All rights reserved.
//

#import "ScheduleDetailViewController.h"

@interface ScheduleDetailViewController ()

@end

@implementation ScheduleDetailViewController

@synthesize selectedSchedule, scheduleTime, scheduleTitle;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
