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
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
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

@end
