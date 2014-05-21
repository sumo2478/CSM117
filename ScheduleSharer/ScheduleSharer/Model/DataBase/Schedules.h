//
//  Schedules.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/5/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Events;

@interface Schedules : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * is_synced;
@property (nonatomic, retain) NSSet *events;

@end

@interface Schedules (CoreDataGeneratedAccessors)

- (void)addEventsObject:(Events *)value;
- (void)removeEventsObject:(Events *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
