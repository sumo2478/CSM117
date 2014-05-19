//
//  Events+Management.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/3/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "Events.h"

@interface Events (Management)


/**
 *  Convience function to create an event Core Data Object
 *
 *  @param title         Title for the event
 *  @param location      Location for the event
 *  @param description   Description of the event
 *  @param start_time    Start time for the event
 *  @param end_date      End time for the event
 *  @param recurring     Recurring event settings: Defined in constants
 *  @param reccuring_end End date for when the event should stop recursing
 *  @param context       NSManagedObjectContext for which the event should be stored
 *
 *  @return Event object with the above data
 */
+ (Events*) eventWithTitle: (NSString*) title Location: (NSString*) location Description: (NSString*) description StartTime: (NSString*) start_time EndTime: (NSString*) end_date Recurring: (NSNumber*) recurring RecurringEnd: (NSString*) reccuring_end Context: (NSManagedObjectContext*) context;


@end
