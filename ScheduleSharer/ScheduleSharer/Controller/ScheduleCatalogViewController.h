//
//  ScheduleCatalogViewController.h
//  Schedule Adder
//
//  Created by user on 2014/5/11.
//  Copyright (c) 2014年 cs117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleDetailViewController.h"
#import "BaseViewController.h"
#import "AddScheduleViewController.h"

#import "Constants.h"
#import "CalendarManagerModel.h"
#import "ConnectionModel.h"
#import "ScheduleManagerModel.h"
#import "Schedules+Management.h"
#import "Events+Management.h"

@interface ScheduleCatalogViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ScheduleDetailViewController *scheduleDetailVC;
//- (IBAction)openScheduleDetail:(id)sender;
@property (strong,nonatomic) NSMutableArray *scheduleCatalogArray;
@property (strong, nonatomic)NSDictionary *scheduleCatalogDictionary;

@end
