//
//  EventDetailViewController.m
//  ScheduleSharer
//
//  Created by user on 2014/5/17.
//  Copyright (c) 2014年 Collin Yen. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Constants.h"



@interface EventDetailViewController ()
//@property (weak, nonatomic) IBOutlet UITableView *eventDetailTableView;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *recurringLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;

@end

@implementation EventDetailViewController
@synthesize myEvent;
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 6;
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
    
    
    switch (indexPath.row) {
        case 0:
        {
            NSMutableString *identifier = [NSMutableString stringWithString: @"Description: "];
            [identifier appendString:myEvent.desc];
            [cell.textLabel setText:identifier];
            
        }
            break;
        case 1:
        {
            NSMutableString *identifier = [NSMutableString stringWithString: @"Location: "];
            [identifier appendString:myEvent.location];
            [cell.textLabel setText:identifier];
            
        }
            break;
        case 2:
        {
            NSMutableString *identifier = [NSMutableString stringWithString: @"Start Time: "];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            NSDate *start_time = myEvent.start_time;
            if (start_time == nil) {
                [cell.textLabel setText:@""];
            }
            else {
                NSString *dateString = [dateFormatter stringFromDate:start_time];
                [identifier appendString:dateString];
                [cell.textLabel setText:identifier];
            }
        }
            break;
        case 3:
        {
            NSMutableString *identifier = [NSMutableString stringWithString: @"End Time: "];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            NSDate *end_time = myEvent.end_time;
            if (end_time == nil) {
                [cell.textLabel setText:@""];
            }
            else {
                NSString *dateString = [dateFormatter stringFromDate:end_time];
                [identifier appendString:dateString];
                [cell.textLabel setText:identifier];
            }
            
        }
            break;
        case 4:
        {
            NSMutableString *identifier = [NSMutableString stringWithString: @"Recurring: "];
            NSString* rule = [Events recurrenceRuleToString:myEvent.recurring];
            [identifier appendString:rule];
            [cell.textLabel setText:identifier];
            
        }
            break;
        case 5:
        {
            NSMutableString *identifier = [NSMutableString stringWithString: @"End Date: "];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            

            NSDate *recurring_end_date = myEvent.recurring_end_date;
            if (recurring_end_date) {
                [cell.textLabel setText:@""];
                NSString *dateString = [dateFormatter stringFromDate:recurring_end_date];
                [identifier appendString:dateString];

                [cell.textLabel setText:identifier];
            }
            else
                [cell.textLabel setText:@""];
        }
            break;
            
        default:
            break;
    }
    
    //[cell.textLabel setText:myEvent.title];
    
    //[cell.textLabel setText:[self.scheduleCatalogArray objectAtIndex:indexPath.row]];
    //[cell.detailTextLabel setText:@"publisher"];
    
    /*
     UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
     [button addTarget:self action: @selector(addbuttonTapped:withEvent:) forControlEvents:UIControlEventTouchUpInside];
     //button.tag = indexPath.row;
     cell.accessoryView = button;
     //cell.accessoryType = UITableViewCellAccessoryCheckmark;
     */
 /*
    return cell;
    
}
*/

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"select");
    
    //NSString *title = [self.scheduleCatalogArray objectAtIndex:indexPath.row];
    //scheduleDetailVC.scheduleTitle.text = title;
    //scheduleDetailVC.scheduleTime.text = scheduleCatalogDictionary[title];
    //eventDetailVC.managedObjectContext = self.managedObjectContext;
    //eventDetailVC.mySchedule = [self.scheduleCatalogArray objectAtIndex:indexPath.row];
    
    //eventDetailVC.myEvent = myEvents[indexPath.row];
    //[self.navigationController pushViewController:self.eventDetailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
*/

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
    self.title = myEvent.title;
    //self.eventDetailTableView.dataSource = self;
    //self.eventDetailTableView.delegate = self;
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    //setting description
    self.eventDescriptionLabel.text = @"Description:";
    
    NSString *description = myEvent.desc;
    if (description) {
        self.eventDescriptionTextField.text = description;
    }
    else
        self.eventDescriptionTextField.text = @"";
    
    
    //setting location
    NSMutableString *identifier = [NSMutableString stringWithString: @"Location: "];
    [identifier appendString:myEvent.location];
    [self.locationLabel setText:identifier];
    
    
    //setting start time
    
    identifier = [NSMutableString stringWithString: @"Start Time: "];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *start_time = myEvent.start_time;
    if (start_time == nil) {
        [self.startTimeLabel setText:identifier];
    }
    else {
        NSString *dateString = [dateFormatter stringFromDate:start_time];
        [identifier appendString:dateString];
        [self.startTimeLabel setText:identifier];
    }
    //setting end time
    identifier = [NSMutableString stringWithString: @"End Time: "];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *end_time = myEvent.end_time;
    if (end_time == nil) {
        [self.endTimeLabel setText:@""];
    }
    else {
        NSString *dateString = [dateFormatter stringFromDate:end_time];
        [identifier appendString:dateString];
        [self.endTimeLabel setText:identifier];
    }
    
    //setting recurring
    identifier = [NSMutableString stringWithString: @"Recurring: "];
    NSString* rule = [Events recurrenceRuleToString:myEvent.recurring];
    [identifier appendString:rule];
    [self.recurringLabel setText:identifier];
    
    //setting end date
    identifier = [NSMutableString stringWithString: @"End Date: "];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSDate *recurring_end_date = myEvent.recurring_end_date;
    if (recurring_end_date) {
        NSString *dateString = [dateFormatter stringFromDate:recurring_end_date];
        [identifier appendString:dateString];
        
        [self.endDateLabel setText:identifier];
    }
    else
        [self.endDateLabel setText:identifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
