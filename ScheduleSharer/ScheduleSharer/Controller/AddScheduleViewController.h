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
#import "ZBarSDK.h"

@interface AddScheduleViewController : BaseViewController <ZBarReaderDelegate>

// Text field for schedule code input
@property (nonatomic, strong) IBOutlet UITextField* codeTextField;

// Downloads the schedule using the code given in the codeTextField
-(IBAction)download:(id)sender;

// Scans a QR code in order to download an event
-(IBAction)scan:(id)sender;

@end
