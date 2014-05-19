//
//  Schedules.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/5/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "Schedules.h"

#import "Constants.h"
#import "Events.h"


@implementation Schedules

@dynamic code;
@dynamic desc;
@dynamic owner;
@dynamic title;
@dynamic is_synced;
@dynamic events;

+ (NSEntityDescription*) getScheduleDescriptionWithContext: (NSManagedObjectContext*) context
{
    return [NSEntityDescription entityForName:MODEL_SCHEDULE inManagedObjectContext:context];
}

@end
