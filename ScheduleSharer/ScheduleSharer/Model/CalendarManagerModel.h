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


+ (void)requestAccess:(void (^)(BOOL granted, NSError *error))callback;

+ (BOOL) syncScheduleWithCode: (NSString*) code Title: (NSString*) title Events: (NSSet*) events Context: (NSManagedObjectContext*) context;

+ (void) deleteEventMatchingIdentifier: (NSString*) identifier;



@end
