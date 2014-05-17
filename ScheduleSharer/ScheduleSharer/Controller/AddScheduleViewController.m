//
//  AddScheduleViewController.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "AddScheduleViewController.h"

#import "Constants.h"
#import "CalendarManagerModel.h"
#import "ConnectionModel.h"
#import "ScheduleManagerModel.h"
#import "Schedules+Management.h"
#import "Events+Management.h"

@interface AddScheduleViewController ()

@end

@implementation AddScheduleViewController

@synthesize codeTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) download:(id)sender
{
    NSArray* keys = [NSArray arrayWithObjects:@"title", @"description", @"location", @"start_time", @"end_time", @"recurring", @"recurring_end_time", nil];
    NSArray* values = [NSArray arrayWithObjects:@"Test Event", @"Event for testing purposes", @"UCLA", @"5/12/2014 3:30", @"5/12/2014 4:30", @"2",@"5/12/2015 4:30", nil];
    NSDictionary* event = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSArray* events = [NSArray arrayWithObject:event];
    
    
    NSManagedObjectContext* context = [self managedObjectContext];
    ScheduleManagerModel* manager = [[ScheduleManagerModel alloc] initWithObjectContext:context];
    [manager addScheduleWithTitle:@"Test Schedule" Description:@"" Code:TEST_CODE Events:events];
    
    // TODO: Remove this is for testing
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [Schedules getScheduleDescriptionWithContext:context];
    [fetchRequest setEntity:entity];
    
    NSError* error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Schedules *schedule in fetchedObjects) {
        NSLog(@"Title: %@", schedule.title);
        NSLog(@"Desc: %@", schedule.desc);
        NSLog(@"Synced: %@", schedule.is_synced);
        
        NSSet* events = schedule.events;
        for (Events* event in events) {
            NSLog(@"Event title: %@", event.title);
            NSLog(@"Identifier: %@", event.identifier);
            NSLog(@"Event location: %@", event.location);
            NSLog(@"Recurring: %@", event.recurring);
            NSLog(@"Recurring end: %@", event.recurring_end_date);
        }
        
    }
    
    // Sync database entry with calendar
    [CalendarManagerModel requestAccess:^(BOOL granted, NSError *error) {
        if (granted) {
            
            // TODO: REMOVE THIS ONLY FOR TESTING //
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [Schedules getScheduleDescriptionWithContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            
            // TODO CHANGE THIS TO CORRECT PREDICATE
            NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            for (Schedules *schedule in fetchedObjects) {
                
                // For each of the fetched schedules sync it with the user's calendar
                if ([CalendarManagerModel syncScheduleWithCode:schedule.code Title:schedule.title Events:schedule.events Context:self.managedObjectContext])
                {
                    NSLog(@"Successfully added schedule");
                }
                else
                {
                    NSLog(@"Unable to save");
                }
                
                NSSet* events = schedule.events;
                for (Events* event in events) {
                    NSLog(@"Event title: %@", event.title);
                    NSLog(@"Identifier: %@", event.identifier);
                }
                
            }
            // END TODO
            
        }else{
            NSLog(@"Denied permission");
        }
    }];
    
    
    /*
    [ConnectionModel retrieveScheduleWithCode:@"3321" completion:^(NSDictionary* results) {
     
        NSString* title       = results[@"title"];
        NSString* description = results[@"description"];
        NSArray*  events      = results[@"events"];
        
        // If there was an error in the json output then display error
        if (!title || !description || !events)
        {
            NSLog(@"Error retrieving data");
        }
        // Otherwise add the new schedule into the local database
        else
        {
            NSManagedObjectContext* context = [self managedObjectContext];
            ScheduleManagerModel* manager = [[ScheduleManagerModel alloc] initWithObjectContext: context];
            
            // Save the schedule to the local database
            if (![manager addScheduleWithTitle:title Description:description Code:TEST_CODE Events:events])
            {
                [self alertWithTitle:@"Error" Message:@"Unable to save schedule"];
            }

            
            // TODO: Remove this is for testing
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [Schedules getScheduleDescriptionWithContext:context];
            [fetchRequest setEntity:entity];
            
            NSError* error;
            NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
            for (Schedules *schedule in fetchedObjects) {
                NSLog(@"Title: %@", schedule.title);
                NSLog(@"Desc: %@", schedule.desc);
                
                NSSet* events = schedule.events;
                for (Events* event in events) {
                    NSLog(@"Event title: %@", event.title);
                    NSLog(@"Identifier: %@", event.identifier);
                }
                
            }
            
        }
        
        // Sync database entry with calendar
        [CalendarManagerModel requestAccess:^(BOOL granted, NSError *error) {
            if (granted) {
                
                // TODO: REMOVE THIS ONLY FOR TESTING //
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *entity = [Schedules getScheduleDescriptionWithContext:self.managedObjectContext];
                [fetchRequest setEntity:entity];
                
                // TODO CHANGE THIS TO CORRECT PREDICATE
                NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
                for (Schedules *schedule in fetchedObjects) {
                    
                    // For each of the fetched schedules sync it with the user's calendar
                    if ([CalendarManagerModel syncScheduleWithCode:schedule.code Title:schedule.title Events:schedule.events Context:self.managedObjectContext])
                    {
                        NSLog(@"Successfully added schedule");
                    }
                    else
                    {
                        NSLog(@"Unable to save");
                    }
                    
                    NSSet* events = schedule.events;
                    for (Events* event in events) {
                        NSLog(@"Event title: %@", event.title);
                        NSLog(@"Identifier: %@", event.identifier);
                    }
                    
                }
                // END TODO

            }else{
                NSLog(@"Denied permission");
            }
        }];
        

        
    }];*/


}


@end
