//
//  Events+Management.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/3/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "Events.h"
#import <EventKit/EventKit.h>

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


/**
 *  Converts recurrence rule integer to english language
 *
 *  @param recurrence_rule The integer value of the recurrence rule
 *
 *  @return String containing the recurrence rule
 */
+ (NSString*) recurrenceRuleToString: (NSNumber*) recurrence_rule;


/**
 *  Creates an EKEvent from a database Events object
 *
 *  @param event      The database Events object
 *  @param eventStore The EKEventStore to associate the event to
 *
 *  @return The EKEvent created with the data of the Events object
 */

/**
 *  Creates an EKEvent from a database Events object
 *
 *  @param event_object   The database Events object
 *  @param code           The code for the schedule
 *  @param schedule_title The title of the schedule associated with the event
 *  @param calendar       The calendar to be associated with the event
 *  @param eventStore     The EKEventStore to associate the event to
 *
 *  @return The EKEvent created with the data of the Events object
 */
+ (EKEvent*) createEKEventWithEvent: (Events*) event_object Code: (NSString*) code ScheduleTitle: (NSString*) schedule_title Calendar: (EKCalendar*) calendar EventStore: (EKEventStore*) eventStore;


@end
