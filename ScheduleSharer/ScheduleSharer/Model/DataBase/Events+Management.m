//
//  Events+Management.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/3/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "Events+Management.h"
#import "Constants.h"

@implementation Events (Management)

+ (Events*) eventWithTitle: (NSString*) title Location: (NSString*) location Description: (NSString*) description StartTime: (NSString*) start_time EndTime: (NSString*) end_time Recurring: (NSNumber*) recurring RecurringEnd: (NSString*) recurring_end Context: (NSManagedObjectContext*) context
{
    Events* event = [NSEntityDescription insertNewObjectForEntityForName:MODEL_EVENT inManagedObjectContext:context];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"PST"]];
    [dateFormat setDateFormat:API_SERVER_DATE_FORMAT];
    NSDate* start = [dateFormat dateFromString:start_time];
    NSDate* end   = [dateFormat dateFromString:end_time];
    event.title      = title;
    event.desc       = description;
    event.location   = location;
    event.start_time = start;
    event.end_time   = end;
    event.recurring  = recurring;

    if ([recurring intValue]) {
        event.recurring_end_date = [dateFormat dateFromString:recurring_end];
    }
    
    return event;
}

+ (NSString*) recurrenceRuleToString: (NSNumber*) recurrence_rule
{
    NSString* rule;
    
    switch ([recurrence_rule intValue]) {
        case RECURRANCE_NONE:
            rule = @"None";
            break;
        case RECURRANCE_WEEKLY:
            rule = @"Weekly";
            break;
        case RECURRANCE_MONTHLY:
            rule = @"Monthly";
            break;
        case RECURRANCE_YEARLY:
            rule = @"Yearly";
            break;
        default:
            break;
    }
    
    return rule;
}

+ (EKEvent*) createEKEventWithEvent: (Events*) event_object Code: (NSString*) code ScheduleTitle: (NSString*) schedule_title Calendar: (EKCalendar*) calendar EventStore: (EKEventStore*) eventStore
{
    EKEvent* event = [EKEvent eventWithEventStore:eventStore];
    NSURL* url = [NSURL URLWithString:code];
    NSString* event_title = [NSString stringWithFormat:@"%@: %@", schedule_title, event_object.title];
    
    [event setCalendar:calendar];
    [event setTitle:event_title];
    [event setLocation:event_object.location];
    [event setStartDate:event_object.start_time];
    [event setEndDate:event_object.end_time];
    [event setNotes:event_object.desc];
    [event setURL:url];
    
    // Set the recurrence rules
    if ([event_object.recurring intValue]) {
        EKRecurrenceEnd* recurrence_end = [EKRecurrenceEnd recurrenceEndWithEndDate:event_object.recurring_end_date];
        EKRecurrenceRule* recurrence_rule = nil;
        
        switch ([event_object.recurring intValue]) {
            case RECURRANCE_DAILY:
                recurrence_rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyDaily interval:1 end:recurrence_end];
                break;
            case RECURRANCE_WEEKLY:
                recurrence_rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyWeekly interval:1 end:recurrence_end];
                break;
            case RECURRANCE_MONTHLY:
                recurrence_rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyMonthly interval:1 end:recurrence_end];
                break;
            case RECURRANCE_YEARLY:
                recurrence_rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyYearly interval:1 end:recurrence_end];
                break;
                
            default:
                break;
        }
        
        [event setRecurrenceRules:[NSArray arrayWithObject:recurrence_rule]];
    }
    
    return event;
}

@end
