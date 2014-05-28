//
//  ScheduleDetailViewController.m
//  Schedule Adder
//
//  Created by user on 2014/5/11.
//  Copyright (c) 2014年 cs117. All rights reserved.
//

#import "ScheduleDetailViewController.h"

@interface ScheduleDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *scheduleDetailTableView;

- (IBAction)schedule_sync:(id)sender;

@end

@implementation ScheduleDetailViewController

@synthesize mySchedule, myEvents, eventDetailVC;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return [self.mySchedule.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //5.1 you do not need this if you have set SettingsCell as identifier in the storyboard (else you can remove the comments on this code)
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    //Schedules *schedule = [self.scheduleCatalogArray objectAtIndex:indexPath.row];
    
    
    Events* myEvent = [myEvents objectAtIndex:indexPath.row];

    [cell.textLabel setText:myEvent.title];
    
    //[cell.textLabel setText:[self.scheduleCatalogArray objectAtIndex:indexPath.row]];
    //[cell.detailTextLabel setText:@"publisher"];
    
    /*
     UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
     [button addTarget:self action: @selector(addbuttonTapped:withEvent:) forControlEvents:UIControlEventTouchUpInside];
     //button.tag = indexPath.row;
     cell.accessoryView = button;
     //cell.accessoryType = UITableViewCellAccessoryCheckmark;
     */
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"select");
    
    //NSString *title = [self.scheduleCatalogArray objectAtIndex:indexPath.row];
    //scheduleDetailVC.scheduleTitle.text = title;
    //scheduleDetailVC.scheduleTime.text = scheduleCatalogDictionary[title];
    eventDetailVC.managedObjectContext = self.managedObjectContext;
    //eventDetailVC.mySchedule = [self.scheduleCatalogArray objectAtIndex:indexPath.row];
    
    eventDetailVC.myEvent = myEvents[indexPath.row];
    [self.navigationController pushViewController:self.eventDetailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     
}

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
    // Do any additional setup after loading the view from its nib.
    self.title = mySchedule.title;
    myEvents = [mySchedule.events allObjects];
    self.scheduleDetailTableView.dataSource = self;
    self.scheduleDetailTableView.delegate = self;
    if (!eventDetailVC) {
        eventDetailVC = [[EventDetailViewController alloc]initWithNibName:nil bundle:nil];
    }
    
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    NSString* sync_title = [Schedules syncTitle:self.mySchedule.is_synced];
    UIBarButtonItem* sync_button = [[UIBarButtonItem alloc] initWithTitle:sync_title style:UIBarButtonItemStylePlain target:self action:@selector(schedule_sync:)];
    self.navigationItem.rightBarButtonItem = sync_button;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)schedule_sync:(id)sender
{
    
    
    
    // Gain access to the calendar
    [CalendarManagerModel requestAccess:^(BOOL granted, NSError *error) {
        if (granted)
        {
            // Unsync the schedule from the iPhone calendar
            if ([self.mySchedule.is_synced intValue]) {
                [CalendarManagerModel unsyncSchedule:self.mySchedule];
                
                // Set the schedule to be unsynced
                self.mySchedule.is_synced = [NSNumber numberWithBool:NO];
                
                // Save the results
                NSError* error;
                if (![self.managedObjectContext save:&error]) {
                    // Error saving the schedule
                    NSLog(@"Error saving object: %@", [error localizedDescription]);
                    self.mySchedule.is_synced = [NSNumber numberWithBool:YES];
                    return;
                }
                
                // Change the title of the sync button
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationItem.rightBarButtonItem setTitle:@"Sync"];
                });

            }
            // Sync the schedule
            else
            {
                if ([CalendarManagerModel syncScheduleWithSchedule:self.mySchedule Context:self.managedObjectContext])
                {
                    NSLog(@"Successfully added schedule");
                    
                    // Set the schedule to be synced
                    self.mySchedule.is_synced = [NSNumber numberWithBool:YES];
                    
                    // Save the results
                    if (![self.managedObjectContext save:&error]) {
                        // Error saving the schedule
                        NSLog(@"Error saving object: %@", [error localizedDescription]);
                        self.mySchedule.is_synced = [NSNumber numberWithBool:NO];
                        return;
                    }
                    
                    // Change the title of the sync button
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationItem.rightBarButtonItem setTitle:@"Unsync"];
                    });
                }
                else
                {
                    NSLog(@"Unable to save");
                }
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self alertWithTitle:@"Permission Denied" Message:@"Unable to save schedule to your calendar. Please check your privacy settings"];
            });
        }
    }];
    
}

@end
