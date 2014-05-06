//
//  Schedules+Management.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/5/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "Schedules+Management.h"
#import "Constants.h"

@implementation Schedules (Management)

+ (NSEntityDescription*) getScheduleDescriptionWithContext: (NSManagedObjectContext*) context
{
    return [NSEntityDescription entityForName:MODEL_SCHEDULE inManagedObjectContext:context];
}

@end
