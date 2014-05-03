//
//  AppDelegate.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/1/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;

// Core data management object
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void) saveContext;
- (NSURL *)applicationDocumentsDirectory; // nice to have to reference files for core data

@end
