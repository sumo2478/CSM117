//
//  ConnectionModel.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionModel : NSObject

/**
 * Retrieves a schedule
 * @param {NSString}    code: 6 character code for the schedule
 * @param {block} completion: Function to be executed when the request is complete
 */
+(void) retrieveScheduleWithCode: (NSString*) code completion:(void (^)(NSDictionary* results))completion;

@end
