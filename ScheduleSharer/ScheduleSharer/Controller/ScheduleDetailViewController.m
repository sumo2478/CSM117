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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
