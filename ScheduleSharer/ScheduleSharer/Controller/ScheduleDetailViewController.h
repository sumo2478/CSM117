//
//  ScheduleDetailViewController.h
//  Schedule Adder
//
//  Created by user on 2014/5/11.
//  Copyright (c) 2014年 cs117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EventDetailViewController.h"

#import "Constants.h"
#import "CalendarManagerModel.h"
#import "ConnectionModel.h"
#import "ScheduleManagerModel.h"
#import "Schedules+Management.h"
#import "Events+Management.h"

@interface ScheduleDetailViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) EventDetailViewController *eventDetailVC;

@property (strong, nonatomic) Schedules *mySchedule;
@property (strong, nonatomic) NSArray *myEvents;
@end
