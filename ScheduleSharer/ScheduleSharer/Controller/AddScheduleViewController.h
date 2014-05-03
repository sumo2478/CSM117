//
//  AddScheduleViewController.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//
//  View controller handles the downloading of a schedule to the phone

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AddScheduleViewController : BaseViewController

// Text field for schedule code input
@property (nonatomic, strong) IBOutlet UITextField* codeTextField;

// Downloads the schedule using the code given in the codeTextField
-(IBAction)download:(id)sender;

@end
