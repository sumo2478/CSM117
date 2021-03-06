//
//  ScheduleManagerModel.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "Schedules+Management.h"
#import <Foundation/Foundation.h>

@interface ScheduleManagerModel : NSObject

-(id) initWithObjectContext: (NSManagedObjectContext*) objectContext;

/**
 *  Adds a schedule to the local database
 *
 *  @param data Dictionary object containing data for the scheulde
 *  -- title       - Title of the schedule
 *  -- description - Description of the schedule
 *  -- code        - Code of the schedule
 *  -- owner       - Creator of the schedule
 *  -- events      - Array of events in the schedule
 *
 *  @return YES on success, NO on failure of saving schedule
 */

- (Schedules*) addScheduleWithData: (NSDictionary*) data;



/**
 *  Deletes a schedule from the local database with the given code as well
 *  as the schedule from the phone's calendar
 *
 *  @param code Code of the schedule to be deleted
 *
 *  @return YES on success, NO on failure of deleting schedule
 */
-(BOOL) deleteScheduleWithCode: (NSString*) code;

@end
