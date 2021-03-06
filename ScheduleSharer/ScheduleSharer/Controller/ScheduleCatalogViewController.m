//
//  ScheduleCatalogViewController.m
//  Schedule Adder
//
//  Created by user on 2014/5/11.
//  Copyright (c) 2014年 cs117. All rights reserved.
//

#import "ScheduleCatalogViewController.h"
#import "ScheduleCatalogTableViewCell.h"

@interface ScheduleCatalogViewController ()
@property (weak, nonatomic) IBOutlet UITableView *scheduleCatalogTableView;

@end

@implementation ScheduleCatalogViewController

@synthesize scheduleDetailVC, scheduleCatalogArray, scheduleCatalogDictionary;

/*
- (ScheduleDetailViewController *)sceduleDetailVC{
    if (!scheduleDetailVC) {
        NSLog(@"lazily instantiated scheduleDetailVC");
        scheduleDetailVC = [[ScheduleDetailViewController alloc]initWithNibName:nil bundle:nil];
        scheduleDetailVC.title = @"Schedule Detail";
    }
    NSLog(@"point");
    return scheduleDetailVC;
}
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63; // edit this return value to your liking
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    return [self.scheduleCatalogArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ScheduleCatalogCell";
    
    ScheduleCatalogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ScheduleCatalogTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScheduleCatalogCell" ];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }

   
    Schedules *schedule = [self.scheduleCatalogArray objectAtIndex:indexPath.row];
    
    [cell.scheduleTitle setText:schedule.title];
    [cell.description setText:schedule.desc];
    [cell.scheduleID setText:schedule.code];
    if (![[Schedules syncTitle:schedule.is_synced]  isEqual: @"Sync"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    /*
    [cell.textLabel setText:schedule.title];
     
    //[cell.textLabel setText:[self.scheduleCatalogArray objectAtIndex:indexPath.row]];
    NSSet *events = schedule.events;
    NSMutableString *eventsString = [NSMutableString stringWithString: @" "];
    
    for (Events* event in events) {
        [eventsString appendString:event.title];
    }
    [cell.detailTextLabel setText:eventsString];
    */
  
    return cell;

}
-(IBAction)addSchedule:(id)sender
{
    NSLog(@"add schedule");
    
    AddScheduleViewController* addScheduleVC = [[AddScheduleViewController alloc]initWithNibName:@"AddScheduleView" bundle:nil];
    
    addScheduleVC.managedObjectContext = self.managedObjectContext;
    
    
    

    
    [self.navigationController pushViewController:addScheduleVC animated:YES];
}
/*
- (void)openScheduleDetail
{
    if (!scheduleDetailVC) {
        NSLog(@"lazily instantiated scheduleDetailVC");
        scheduleDetailVC = [[ScheduleDetailViewController alloc]initWithNibName:nil bundle:nil];
        scheduleDetailVC.title = @"Schedule Detail";
    }
    
    
    [self.navigationController pushViewController:self.scheduleDetailVC animated:YES];
}
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"select");
    
    //NSString *title = [self.scheduleCatalogArray objectAtIndex:indexPath.row];
    //scheduleDetailVC.scheduleTitle.text = title;
    //scheduleDetailVC.scheduleTime.text = scheduleCatalogDictionary[title];
    scheduleDetailVC.managedObjectContext = self.managedObjectContext;
    scheduleDetailVC.mySchedule = [self.scheduleCatalogArray objectAtIndex:indexPath.row];
    
    
    [self.navigationController pushViewController:self.scheduleDetailVC animated:YES];
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
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewdidappear");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSManagedObjectContext* context = [self managedObjectContext];
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [Schedules getScheduleDescriptionWithContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    scheduleCatalogArray = [NSMutableArray arrayWithArray:fetchedObjects];
    
    /*
     scheduleCatalogArray = @[@"CS111",@"EE116L",@"STATS105",@"CS117"];
     scheduleCatalogDictionary  = @{
     @"CS111": @"M W 2pm to 4pm",
     @"EE116L": @"M W 12pm to 2pm",
     @"STATS105": @"T TR 8am to 10am",
     @"CS117": @"T TR 4pm to 6pm"
     };
     */
    if (!scheduleDetailVC) {
        scheduleDetailVC = [[ScheduleDetailViewController alloc]initWithNibName:nil bundle:nil];
        
        
    }
    [self.scheduleCatalogTableView reloadData];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"My Schedules";
    self.scheduleCatalogTableView.dataSource = self;
    self.scheduleCatalogTableView.delegate = self;
    
    
    
    NSManagedObjectContext* context = [self managedObjectContext];
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [Schedules getScheduleDescriptionWithContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    scheduleCatalogArray = [NSMutableArray arrayWithArray:fetchedObjects];
     
    /*
    scheduleCatalogArray = @[@"CS111",@"EE116L",@"STATS105",@"CS117"];
    scheduleCatalogDictionary  = @{
                        @"CS111": @"M W 2pm to 4pm",
                        @"EE116L": @"M W 12pm to 2pm",
                        @"STATS105": @"T TR 8am to 10am",
                        @"CS117": @"T TR 4pm to 6pm"
                        };
    */
    if (!scheduleDetailVC) {
        scheduleDetailVC = [[ScheduleDetailViewController alloc]initWithNibName:nil bundle:nil];
        
        
    }
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"add"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(addSchedule:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Editing
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.scheduleCatalogTableView setEditing:editing animated:YES];
    
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the schedule from the phone's data
        Schedules* schedule = [self.scheduleCatalogArray objectAtIndex:indexPath.row];
        ScheduleManagerModel* schedule_manager = [[ScheduleManagerModel alloc] initWithObjectContext:[self managedObjectContext]];
        [schedule_manager deleteScheduleWithCode:schedule.code];
        
        // Remove the schedule from the views array
        [self.scheduleCatalogArray removeObjectAtIndex:indexPath.row];
        
        // Delete the schedule from the UI
        [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
