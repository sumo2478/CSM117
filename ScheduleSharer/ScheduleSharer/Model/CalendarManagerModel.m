//
//  CalendarManagerModel.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/3/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "CalendarManagerModel.h"

#import "Constants.h"
#import "Events.h"

@interface CalendarManagerModel()

// Helper functions
<<<<<<< HEAD

// Retrieve the app's calendar
+ (EKCalendar*) retrieveCalendar;

// Adds an array of events with a calendar
=======
+ (BOOL) deleteEventsMatchingCode:(NSString *)code Calendar: (EKCalendar*) calendar;
>>>>>>> origin/calendar
+ (BOOL) addEventsWithCode:(NSString *)code Events:(NSSet *)events ScheduleTitle: (NSString*) title Calendar: (EKCalendar*) calendar Context: (NSManagedObjectContext*) context;

@end

@implementation CalendarManagerModel

static EKEventStore* eventStore = nil;

+ (void)requestAccess:(void (^)(BOOL granted, NSError *error))callback
{
    if (eventStore == nil) {
        eventStore = [[EKEventStore alloc] init];
    }
    
    // request permissions
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:callback];
}

+ (BOOL) syncScheduleWithCode: (NSString*) code Title: (NSString*) title Events: (NSSet*) events Context: (NSManagedObjectContext*) context
{
<<<<<<< HEAD
    // Retrieve the calendar
    BOOL success = NO;
    EKCalendar* calendar = [self retrieveCalendar];
    
    // If the calendar exists then add the events to the calendar
    if (calendar) {
        success = [self addEventsWithCode:code Events:events ScheduleTitle:title Calendar:calendar Context:context];
    }
    
    return success;
=======
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
        NSLog(@"Creating calendar....");
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
        
        NSError* error = nil;
        
        // Save the new calendar
        if ([eventStore saveCalendar:calendar commit:YES error:&error])
        {
            [[NSUserDefaults standardUserDefaults] setObject:identifier forKey:CALENDAR_IDENTIFIER];
        }
        // Otherwise return failed
        else
        {
            NSLog(@"Unable to save calendar: %@", error);
            return NO;
        }
    }
    
    // Delete the events with the same code
    [self deleteEventsMatchingCode:code Calendar:calendar];

    // Create the events
    return [self addEventsWithCode:code Events:events ScheduleTitle:title Calendar:calendar Context:context];
    
>>>>>>> origin/calendar
}

#pragma mark Helper Functions

+ (BOOL) addEventsWithCode:(NSString *)code Events:(NSSet *)events ScheduleTitle: (NSString*) title Calendar: (EKCalendar*) calendar Context: (NSManagedObjectContext*) context
{
<<<<<<< HEAD
    // Initialize Date formatter used to set date
=======
    // Date formatter used to set date
>>>>>>> origin/calendar
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormat setDateFormat:API_SERVER_DATE_FORMAT];
    
<<<<<<< HEAD
    // Add in each event
    for (Events* event_object in events) {
        EKEvent* event = [EKEvent eventWithEventStore:eventStore];
        NSURL* url = [NSURL URLWithString:code];
        NSString* event_title = [NSString stringWithFormat:@"%@: %@", title, event_object.title];
        
        [event setCalendar:calendar];
        [event setTitle:event_title];
=======
    for (Events* event_object in events) {
        EKEvent* event = [EKEvent eventWithEventStore:eventStore];
        NSURL* url = [NSURL URLWithString:code];
        
        [event setCalendar:calendar];
        [event setTitle:event_object.title];
>>>>>>> origin/calendar
        [event setLocation:event_object.location];
        [event setStartDate:event_object.start_time];
        [event setEndDate:event_object.end_time];
        [event setNotes:event_object.desc];
        [event setURL:url];
        
<<<<<<< HEAD
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
        
        // Save the event to the calendar
        NSError* error = nil;
        if (![eventStore saveEvent:event span:EKSpanFutureEvents commit:YES error:&error]) {
=======
        // Save the event to the calendar
        NSError* error = nil;
        if (![eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&error]) {
>>>>>>> origin/calendar
            NSLog(@"Unable to save event: %@", error);
            return NO;
        }
        
<<<<<<< HEAD
        // Update the identifier in core data
=======
>>>>>>> origin/calendar
        event_object.identifier = [NSString stringWithFormat:@"%@",  [event eventIdentifier]];
        
        if (![context save:&error]) {
            NSLog(@"Error saving event identifier: %@", error);
            return NO;
        }
    }
    
    return YES;
}

<<<<<<< HEAD
+ (void) deleteEventMatchingIdentifier: (NSString*) identifier
{
    EKEvent* event = [eventStore eventWithIdentifier:identifier];
    NSError* error;
    
    if (!event) {
        NSLog(@"Event is nil");
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
=======
+ (BOOL) deleteEventsMatchingCode:(NSString *)code Calendar: (EKCalendar*) calendar
{
    // Retrieve all events in the calendar
    NSArray* calendars = [NSArray arrayWithObject:calendar];
    NSPredicate* predicate = [eventStore predicateForEventsWithStartDate:[NSDate distantPast] endDate:[NSDate distantFuture] calendars:calendars];
    NSArray* events = [eventStore eventsMatchingPredicate:predicate];
    
    NSError* error;
    
    for (EKEvent* event in events) {
        // If the code matches the event then delete the event
        if ([[event.URL absoluteString] isEqualToString:code])
        {
            if (![eventStore removeEvent:event span:EKSpanThisEvent commit:YES error:&error])
            {
                NSLog(@"Unable to delete existing event: %@", error);
                return NO;
            }
        }
    }
    
    return YES;
}

+ (void) deleteEventMatchingIdentifier: (NSString*) identifier
{
    EKEvent* event = [eventStore eventWithIdentifier:identifier];
    NSError* error;
    
    if (!event) {
        NSLog(@"Event is nil");
    }
    else
    {
        if (![eventStore removeEvent:event span:EKSpanThisEvent commit:YES error:&error])
        {
            NSLog(@"Error removing event: %@", error);
        }
    }
    

    
>>>>>>> origin/calendar
}

@end
