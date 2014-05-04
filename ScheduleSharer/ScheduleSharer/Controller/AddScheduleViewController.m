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
#import "Schedules.h"
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
    [ConnectionModel retrieveScheduleWithCode:@"3321" completion:^(NSDictionary* results) {
        NSDictionary* data = (NSDictionary*) results;
        
        NSString* title = data[@"title"];
        NSString* description = data[@"description"];
        NSArray* events = data[@"events"];
        
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
            
            // Display error message if unable to save schedule
            if (![manager addScheduleWithTitle:title Description:description Code:TEST_CODE Events:events])
            {
                [self alertWithTitle:@"Error" Message:@"Unable to save schedule"];
            }

            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription
                                           entityForName:@"Schedules" inManagedObjectContext:context];
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
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedules" inManagedObjectContext:self.managedObjectContext];
                [fetchRequest setEntity:entity];
                
                // TODO CHANGE THIS TO CORRECT PREDICATE
                NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
                for (Schedules *schedule in fetchedObjects) {
                    
                    if ([CalendarManagerModel syncScheduleWithCode:schedule.code Title:schedule.title Events:schedule.events Context:self.managedObjectContext])
                    {
                        NSLog(@"Successfully added schedule");
                    }else
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
        

        
    }];


}


@end
