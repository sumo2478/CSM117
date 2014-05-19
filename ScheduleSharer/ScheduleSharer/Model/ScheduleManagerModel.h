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
 *  @param data Dictionary object containing data for the scheulde
 *  -- title       - Title of the schedule
 *  -- description - Description of the schedule
 *  -- code        - Code of the schedule
 *  -- owner       - Creator of the schedule
 *  -- events      - Array of events in the schedule
 *
 *  @return YES on success, NO on failure of saving schedule
 */

- (BOOL) addScheduleWithData: (NSDictionary*) data;



/**
 *  Deles a schedule from the local database with the given code
 *
 *  @param code Code of the schedule to be deleted
 *
 *  @return YES on success, NO on failure of deleting schedule
 */
-(BOOL) deleteScheduleWithCode: (NSString*) code;

@end
