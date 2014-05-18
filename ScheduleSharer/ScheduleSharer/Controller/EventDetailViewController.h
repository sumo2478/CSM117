//
//  EventDetailViewController.h
//  ScheduleSharer
//
//  Created by user on 2014/5/17.
//  Copyright (c) 2014年 Collin Yen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


#import "Constants.h"
#import "CalendarManagerModel.h"
#import "ConnectionModel.h"
#import "ScheduleManagerModel.h"
#import "Schedules+Management.h"
#import "Events+Management.h"

@interface EventDetailViewController : BaseViewController
@property (strong, nonatomic) Events *myEvent;

@end
