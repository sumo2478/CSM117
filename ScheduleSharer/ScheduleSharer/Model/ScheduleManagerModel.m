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
#import "Events+Management.h"
#import "Schedules.h"
#import "CalendarManagerModel.h"


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

- (BOOL) addScheduleWithTitle: (NSString*) title Description: (NSString*) description Code: (NSString*) code Events: (NSArray*) events
{
    // First delete a schedule with the same code if it exists
    if (![self deleteScheduleWithCode:code]) {
        return NO;
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    NSManagedObjectContext* context = [self managedObjectContext];
    
    Schedules* schedule = [NSEntityDescription insertNewObjectForEntityForName:MODEL_SCHEDULE inManagedObjectContext:context];
    
    schedule.title = title;
    schedule.desc  = description;
    schedule.owner = @"Collin Yen";
    schedule.code  = code;
    
    // For each event in the event array
    for (NSDictionary* event in events) {
        
        // Create an event object and add it to the schedule
        NSString* e_title       = event[API_EVENT_TITLE_FIELD];
        NSString* e_description = event[API_EVENT_DESCRIPTION_FIELD];
        NSString* e_location = event[API_EVENT_LOCATION_FIELD];
        NSString* e_start_time = event[API_EVENT_START_TIME_FIELD];
        NSString* e_end_time = event[API_EVENT_END_TIME_FIELD];
        
        Events* event_object = [Events eventWithTitle:e_title Location:e_location Description:e_description StartTime:e_start_time EndTime:e_end_time Context:context];
        
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

-(BOOL) deleteScheduleWithCode: (NSString*) code
{
    NSManagedObjectContext* context = [self managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:MODEL_SCHEDULE inManagedObjectContext:context];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"code == %@", code];
    [fetchRequest setPredicate:predicate];
    
    NSError* error;
    NSArray* schedules = [context executeFetchRequest:fetchRequest error:&error];
  
    for (Schedules* schedule in schedules) {
        // Remove all calendar events if there are any
        NSSet* events = schedule.events;
        for (Events* event in events) {
            if (event.identifier) {
                [CalendarManagerModel deleteEventMatchingIdentifier:event.identifier];
            }
        }
        
        [context deleteObject:schedule];
    }
    
    if (![context save:&error]) {
        NSLog(@"Could not delete entity: %@", error);
        return NO;
    }
    
    
    return YES;
}

@end
