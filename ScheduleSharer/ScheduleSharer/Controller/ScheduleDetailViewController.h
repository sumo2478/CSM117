//
//  ScheduleDetailViewController.h
//  Schedule Adder
//
//  Created by user on 2014/5/11.
//  Copyright (c) 2014年 cs117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Constants.h"
#import "CalendarManagerModel.h"
#import "ConnectionModel.h"
#import "ScheduleManagerModel.h"
#import "Schedules+Management.h"
#import "Events+Management.h"

@interface ScheduleDetailViewController : BaseViewController

@property (strong, nonatomic) NSString *selectedSchedule;
@property (strong, nonatomic) IBOutlet UILabel *scheduleTitle;
@property (strong, nonatomic) IBOutlet UILabel *scheduleTime;
@property (strong, nonatomic) Schedules *mySchedule;
@end
