//
//  ScheduleManagerModel.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "ScheduleManagerModel.h"

#import "Constants.h"
#import "Schedules.h"


@interface ScheduleManagerModel()

@end

@implementation ScheduleManagerModel

@synthesize managedObjectContext;

-(id) initWithObjectContext: (NSManagedObjectContext*) objectContext {
    self = [super init];
    
    if (self) {
        self.managedObjectContext = objectContext;
    }
    
    return self;
}

- (BOOL) addScheduleWithTitle: (NSString*) title Description: (NSString*) description Events: (NSArray*) events
{
    
    NSManagedObjectContext* context = [self managedObjectContext];
    
    Schedules* schedule = [NSEntityDescription insertNewObjectForEntityForName:MODEL_SCHEDULE inManagedObjectContext:context];
    
    schedule.title = title;
    schedule.desc  = description;
    
    // For each event in the event array
        // Create an event object and add it to the schedule
    
    // Save the results
    NSError* error;
    if (![context save:&error]) {
        // TODO: Change this to proper error behavior
        NSLog(@"Error saving object: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
}

@end
