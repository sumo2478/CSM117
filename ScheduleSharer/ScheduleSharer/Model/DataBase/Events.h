//
//  Events.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Events : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSDate * end_time;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * start_time;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSManagedObject *schedule;

@end
