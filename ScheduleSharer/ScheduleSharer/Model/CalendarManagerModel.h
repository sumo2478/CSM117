//
//  CalendarManagerModel.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/3/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface CalendarManagerModel : NSObject

/**
 *  Requests access to the calendar of the user's phone
 *
 *  @param callback Function to be executed if access is granted
 */
+ (void)requestAccess:(void (^)(BOOL granted, NSError *error))callback;

/**
 *  Syncs iPhone calendar with core data schedule
 *
 *  @param code    Code for the schedule to be synced with
 *  @param title   Title of the schedule
 *  @param events  Set of all the events associated with the schedule
 *  @param context NSManaged object context used to save identifier for the event into Core Data
 *
 *  @return Success of the operation
 */
+ (BOOL) syncScheduleWithCode: (NSString*) code Title: (NSString*) title Events: (NSSet*) events Context: (NSManagedObjectContext*) context;

/**
 *  Deletes an event from the calendar matching an event identifier
 *
 *  @param identifier Identifier of the event to delete
 */
+ (void) deleteEventMatchingIdentifier: (NSString*) identifier;



@end
