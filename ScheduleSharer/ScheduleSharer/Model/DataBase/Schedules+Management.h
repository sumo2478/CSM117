//
//  Schedules+Management.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/5/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "Schedules.h"

@interface Schedules (Management)

+ (NSEntityDescription*) getScheduleDescriptionWithContext: (NSManagedObjectContext*) context;

@end
