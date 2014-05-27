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
#import "CalendarManagerModel.h"


@interface ScheduleManagerModel()

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

// Saves the event to core data
- (Events*) saveEventWithData: (NSDictionary*) event Context: (NSManagedObjectContext*) context;

/**
 *  Validate an event json dictionary object
 *
 *  @param event Dictionary for the event json data
 *  -- title         -- Title of the event
 *  -- description   -- Description of the event
 *  -- location      -- Location of the event
 *  -- start_time    -- Start time of the event
 *  -- end_time      -- End time of the event
 *  -- recurring     -- Recurrence rules for the event
 *  -- recurring_end -- Recurring end time for the event
 *
 *  @return Validated event dictionary
 */
- (NSDictionary*) validateEvent: (NSDictionary*) event;

/**
 *  Validate a schedule json dictionary object
 *
 *  @param schedule Dictionary for the schedule json data
 *  -- title       -- Title of the schedule
 *  -- description -- Description of the schedule
 *  -- code        -- Code of the schedule
 *  -- owner       -- Owner name of the schedule
 *
 *  @return Validated schedule dictionary
 */
- (NSDictionary*) validateSchedule: (NSDictionary*) schedule;

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

- (Schedules*) addScheduleWithData:(NSDictionary *)data
{
    // Validate the json data object
    NSDictionary* validated_data = [self validateSchedule:data];
    
    NSString* title       = validated_data[API_ITINERARY_TITLE_FIELD];
    NSString* description = validated_data[API_ITINERARY_DESCRIPTION_FIELD];
    NSString* code        = validated_data[API_ITINERARY_CODE_FIELD];
    NSString* owner       = validated_data[API_ITINERARY_OWNER_FIELD];
    NSArray*  events      = data[API_ITINERARY_EVENTS_FIELD];
    
    //If Title, Code, or Events is not provided then return error
    if ([code isEqualToString:@""] || [title isEqualToString:@""] || !events) {
        NSLog(@"Improperly received data");
        return nil;
    }
    
    // First delete a schedule with the same code if it exists
    if (![self deleteScheduleWithCode:code]) {
        return nil;
    }
    
    // Initialize date formatter
    // TODO: Change to the appropriate timezone
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    NSManagedObjectContext* context = [self managedObjectContext];
    
    Schedules* schedule = [NSEntityDescription insertNewObjectForEntityForName:MODEL_SCHEDULE inManagedObjectContext:context];
    
    schedule.title = title;
    schedule.desc  = description;
    schedule.owner = owner;
    schedule.code  = code;
    
    // For each event in the event array
    for (NSDictionary* event in events)
    {
        Events* event_object = [self saveEventWithData:event Context:context];
        
        // Add in the relationships
        event_object.schedule = schedule;
        [schedule addEventsObject:event_object];
    }
    
    // Save the results
    NSError* error;
    if (![context save:&error]) {
        // TODO: Change this to proper error behavior
        NSLog(@"Error saving object: %@", [error localizedDescription]);
        return nil;
    }
    
    return schedule;
}

-(BOOL) deleteScheduleWithCode: (NSString*) code
{
    NSManagedObjectContext* context = [self managedObjectContext];
    NSEntityDescription* entity = [Schedules getScheduleDescriptionWithContext:context];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"code == %@", code];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError* error;
    NSArray* schedules = [context executeFetchRequest:fetchRequest error:&error];
    for (Schedules* schedule in schedules) {
        // Remove all calendar events if there are any
        NSSet* events = schedule.events;
        for (Events* event in events) {
            if (event.identifier) {
                [CalendarManagerModel requestAccess:^(BOOL granted, NSError *error) {
                    if (granted) {
                        [CalendarManagerModel deleteEventMatchingIdentifier:event.identifier];
                    }
                    else
                    {
                        // TODO: Come up with something to do if can't delete event
                    }
                }];

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

#pragma mark Helper Functions

- (Events*) saveEventWithData:(NSDictionary *)event Context:(NSManagedObjectContext *)context
{
    // Validate the event
    NSDictionary* validated = [self validateEvent:event];
    
    // Create an event object and add it to the schedule
    NSString* e_title       = validated[API_EVENT_TITLE_FIELD];
    NSString* e_description = validated[API_EVENT_DESCRIPTION_FIELD];
    NSString* e_location    = validated[API_EVENT_LOCATION_FIELD];
    NSString* e_start_time  = validated[API_EVENT_START_TIME_FIELD];
    NSString* e_end_time    = validated[API_EVENT_END_TIME_FIELD];
    
    NSNumber* recurring = [NSNumber numberWithInt:[validated[API_EVENT_RECURRING_FIELD] intValue]];
    NSString* recurring_end = nil;
    
    if ([recurring intValue] > 0) {
        recurring_end = validated[API_EVENT_RECURRING_END_TIME_FIELD];
    }

    Events* event_object = [Events eventWithTitle:e_title Location:e_location Description:e_description StartTime:e_start_time EndTime:e_end_time Recurring:recurring RecurringEnd:recurring_end Context:context];
    
    return event_object;
}

# pragma mark Validation Functions

- (NSDictionary*) validateEvent: (NSDictionary*) event
{
    NSMutableDictionary* validated_events = [NSMutableDictionary dictionary];
    
    NSString* event_title = [event[API_EVENT_TITLE_FIELD] isKindOfClass:[NSNull class]] ? @""
    : event[API_EVENT_TITLE_FIELD];
    
    NSString* event_description = [event[API_EVENT_DESCRIPTION_FIELD] isKindOfClass:[NSNull class]] ? @""
    : event[API_EVENT_DESCRIPTION_FIELD];
    
    NSString* event_location = [event[API_EVENT_LOCATION_FIELD] isKindOfClass:[NSNull class]] ? @""
    : event[API_EVENT_LOCATION_FIELD];
    
    NSString* event_start_time = [event[API_EVENT_START_TIME_FIELD] isKindOfClass:[NSNull class]] ? @""
    : event[API_EVENT_START_TIME_FIELD];
    
    NSString* event_end_time = [event[API_EVENT_END_TIME_FIELD] isKindOfClass:[NSNull class]] ? @""
    : event[API_EVENT_END_TIME_FIELD];
    
    NSString* event_recurring = [event[API_EVENT_RECURRING_FIELD] isKindOfClass:[NSNull class]] ? @""
    : event[API_EVENT_RECURRING_FIELD];
    
    // TODO: Change this to valid recurring end date
    NSString* event_recurring_end = [event[API_EVENT_RECURRING_END_TIME_FIELD] isKindOfClass:[NSNull class]] ? @""
    : event[API_EVENT_RECURRING_END_TIME_FIELD];
    
    [validated_events setValue:event_title forKeyPath:API_EVENT_TITLE_FIELD];
    [validated_events setValue:event_location forKeyPath:API_EVENT_LOCATION_FIELD];
    [validated_events setValue:event_description forKeyPath:API_EVENT_DESCRIPTION_FIELD];
    [validated_events setValue:event_start_time forKeyPath:API_EVENT_START_TIME_FIELD];
    [validated_events setValue:event_end_time forKeyPath:API_EVENT_END_TIME_FIELD];
    [validated_events setValue:event_recurring forKeyPath:API_EVENT_RECURRING_FIELD];
    [validated_events setValue:event_recurring_end forKeyPath:API_EVENT_RECURRING_END_TIME_FIELD];
    
    return validated_events;
}

- (NSDictionary*) validateSchedule:(NSDictionary *)schedule
{
    NSMutableDictionary* validated_schedule = [NSMutableDictionary dictionary];
    
    NSString* schedule_title = [schedule[API_ITINERARY_TITLE_FIELD] isKindOfClass:[NSNull class]] ? @""
    : schedule[API_ITINERARY_TITLE_FIELD];
    
    NSString* schedule_description = [schedule[API_ITINERARY_DESCRIPTION_FIELD] isKindOfClass:[NSNull class]] ? @""
    : schedule[API_ITINERARY_DESCRIPTION_FIELD];
    
    NSString* schedule_code = [schedule[API_ITINERARY_CODE_FIELD] isKindOfClass:[NSNull class]] ? @""
    : schedule[API_ITINERARY_CODE_FIELD];
    
    NSString* schedule_owner = [schedule[API_ITINERARY_OWNER_FIELD] isKindOfClass:[NSNull class]] ? @""
    : schedule[API_ITINERARY_OWNER_FIELD];
    
    [validated_schedule setValue:schedule_title forKeyPath:API_ITINERARY_TITLE_FIELD];
    [validated_schedule setValue:schedule_description forKeyPath:API_ITINERARY_DESCRIPTION_FIELD];
    [validated_schedule setValue:schedule_code forKeyPath:API_ITINERARY_CODE_FIELD];
    [validated_schedule setValue:schedule_owner forKeyPath:API_ITINERARY_OWNER_FIELD];
    
    return validated_schedule;

}

@end
