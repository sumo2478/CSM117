//
//  ScheduleManagerModel.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "ScheduleManagerModel.h"

#import "Constants.h"
#import "Schedules.h"
#import "Events.h"
#import "Schedules.h"


@interface ScheduleManagerModel()

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@end

@implementation ScheduleManagerModel

@synthesize managedObjectContext;

-(id) initWithObjectContext: (NSManagedObjectContext*) objectContext {
    self = [super init];
    
    if (self) {
        self.managedObjectContext = objectContext;
    }
    
    return self;
}

- (BOOL) addScheduleWithTitle: (NSString*) title Description: (NSString*) description Events: (NSArray*) events
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    NSManagedObjectContext* context = [self managedObjectContext];
    
    Schedules* schedule = [NSEntityDescription insertNewObjectForEntityForName:MODEL_SCHEDULE inManagedObjectContext:context];
    
    schedule.title = title;
    schedule.desc  = description;
    schedule.owner = @"Collin Yen";
    
    // For each event in the event array
    for (NSDictionary* event in events) {
        
        // Create an event object and add it to the schedule
        Events* event_object = [NSEntityDescription insertNewObjectForEntityForName:MODEL_EVENT inManagedObjectContext:context];
        event_object.title = event[API_EVENT_TITLE_FIELD];
        event_object.desc  = event[API_EVENT_DESCRIPTION_FIELD];
        event_object.location = event[API_EVENT_LOCATION_FIELD];
        
        // Convert start and end times to date format

        [dateFormat setDateFormat:API_SERVER_DATE_FORMAT];
        NSDate* start_time = [dateFormat dateFromString:event[API_EVENT_START_TIME_FIELD]];
        NSDate* end_time   = [dateFormat dateFromString:event[API_EVENT_END_TIME_FIELD]];

        event_object.start_time = start_time;
        event_object.end_time = end_time;
        
        // Add in the relationships
        event_object.schedule = schedule;
        [schedule addEventsObject:event_object];
    }
    
    // Save the results
    NSError* error;
    if (![context save:&error]) {
        // TODO: Change this to proper error behavior
        NSLog(@"Error saving object: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
}

@end
