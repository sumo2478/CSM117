//
//  CalendarManagerModel.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/3/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "CalendarManagerModel.h"

#import "Constants.h"
#import "Events+Management.h"

@interface CalendarManagerModel()

// Helper functions


// Retrieve the app's calendar
+ (EKCalendar*) retrieveCalendar;

// Adds an array of events with a calendar
+ (BOOL) addEventsWithCode:(NSString *)code Events:(NSSet *)events ScheduleTitle: (NSString*) title Calendar: (EKCalendar*) calendar Context: (NSManagedObjectContext*) context;

@end

@implementation CalendarManagerModel

static EKEventStore* eventStore = nil;

+ (void)requestAccess:(void (^)(BOOL granted, NSError *error))callback
{
    if (eventStore == nil) {
        NSLog(@"Allocating event store");
        eventStore = [[EKEventStore alloc] init];
    }
    
    // request permissions
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:callback];
}

+ (BOOL) syncScheduleWithSchedule: (Schedules*) schedule Context: (NSManagedObjectContext*) context{
    // Retrieve the calendar
    BOOL success = NO;
    EKCalendar* calendar = [self retrieveCalendar];
    
    // If the calendar exists then add the events to the calendar
    if (calendar) {
        success = [self addEventsWithCode:schedule.code Events:schedule.events ScheduleTitle:schedule.title Calendar:calendar Context:context];
    }
    
    return success;
}

#pragma mark Helper Functions

+ (BOOL) addEventsWithCode:(NSString *)code Events:(NSSet *)events ScheduleTitle: (NSString*) title Calendar: (EKCalendar*) calendar Context: (NSManagedObjectContext*) context
{
    // Initialize Date formatter used to set date
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"PST"]];
    [dateFormat setDateFormat:API_SERVER_DATE_FORMAT];
    
    // Add in each event
    for (Events* event_object in events) {
        EKEvent* event = [Events createEKEventWithEvent:event_object Code:code ScheduleTitle:title Calendar:calendar EventStore:eventStore];
        
        // Save the event to the calendar
        NSError* error = nil;
        if (![eventStore saveEvent:event span:EKSpanFutureEvents commit:YES error:&error]) {
            NSLog(@"Unable to save event: %@", error);
            return NO;
        }
        
        // Update the identifier in core data
        event_object.identifier = [NSString stringWithFormat:@"%@",  [event eventIdentifier]];
        
        if (![context save:&error]) {
            NSLog(@"Error saving event identifier: %@", error);
            return NO;
        }
    }
    
    return YES;
}

+ (BOOL) unsyncSchedule: (Schedules*) schedule
{
    
    for (Events* event in schedule.events) {
        [self deleteEventMatchingIdentifier:event.identifier];
    }
    
    return YES;
}

+ (void) deleteEventMatchingIdentifier: (NSString*) identifier
{
    EKEvent* event = [eventStore eventWithIdentifier:identifier];
    NSError* error;
    
    if (!eventStore) {
        NSLog(@"Event store is nil");
    }
    
    if (!event) {
        NSLog(@"Event is nil");
        NSLog(@"Identifier: %@", identifier);
    }
    else
    {
        if (![eventStore removeEvent:event span:EKSpanFutureEvents commit:YES error:&error])
        {
            NSLog(@"Error removing event: %@", error);
        }
    }
}

+ (EKCalendar*) retrieveCalendar
{
    EKCalendar* calendar = nil;
    NSString* calendarIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:CALENDAR_IDENTIFIER];
    
    // If the calendar exists then set the calendar to the app's calendar
    if (calendarIdentifier)
    {
        calendar = [eventStore calendarWithIdentifier:calendarIdentifier];
    }
    
    // If calendar doesn't exist create one
    if (!calendar)
    {
        calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
        
        // Set the calendar properties
        [calendar setTitle:CALENDAR_TITLE];
        
        // Retrieve the correct source for the calendar
        for (EKSource *s in eventStore.sources) {
            if (s.sourceType == EKSourceTypeLocal) {
                calendar.source = s;
                break;
            }
        }
        
        // Save identifier in NSDefaults for calendar retrieval in the future
        NSString* identifier = [calendar calendarIdentifier];
        
        // Save the new calendar
        NSError* error = nil;
        if ([eventStore saveCalendar:calendar commit:YES error:&error])
        {
            [[NSUserDefaults standardUserDefaults] setObject:identifier forKey:CALENDAR_IDENTIFIER];
        }
        // Otherwise return failed
        else
        {
            NSLog(@"Unable to save calendar: %@", error);
            calendar = nil;
        }
    }
    
    return calendar;
}

@end
