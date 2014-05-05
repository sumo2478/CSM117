//
//  ScheduleManagerModel.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleManagerModel : NSObject

-(id) initWithObjectContext: (NSManagedObjectContext*) objectContext;

/**
 *  Adds a schedule to the local database
 *
 *  @param title       Title of the schedule
 *  @param description Description of the schedule
 *  @param events      Array of event dictionary objects for the events associated with the schedule
 *
 *  @return YES on success, NO on failure of saving schedule
 */
- (BOOL) addScheduleWithTitle: (NSString*) title Description: (NSString*) description Code: (NSString*) code Events: (NSArray*) events;

/**
 *  Deles a schedule from the local database with the given code
 *
 *  @param code Code of the schedule to be deleted
 *
 *  @return YES on success, NO on failure of deleting schedule
 */
-(BOOL) deleteScheduleWithCode: (NSString*) code;

@end
