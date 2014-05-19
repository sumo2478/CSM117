//
//  Events.h
//  ScheduleSharer
//

//  Created by Collin Yen on 5/5/14.

//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Schedules;

@interface Events : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSDate * end_time;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * start_time;
@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) NSNumber * recurring;
@property (nonatomic, retain) NSDate * recurring_end_date;

@property (nonatomic, retain) Schedules *schedule;

@end
