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

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

- (BOOL) addScheduleWithTitle: (NSString*) title Description: (NSString*) description Events: (NSArray*) events;

@end