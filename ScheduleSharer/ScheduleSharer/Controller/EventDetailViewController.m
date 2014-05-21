//
//  EventDetailViewController.m
//  ScheduleSharer
//
//  Created by user on 2014/5/17.
//  Copyright (c) 2014年 Collin Yen. All rights reserved.
//

#import "EventDetailViewController.h"



@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *eventDetailTableView;

@end

@implementation EventDetailViewController
@synthesize myEvent;

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
            NSMutableString *identifier = [NSMutableString stringWithString: @"Identifier: "];
            [identifier appendString:myEvent.identifier];
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
            
            NSString *dateString = [dateFormatter stringFromDate:myEvent.start_time];
            [identifier appendString:dateString];
            [cell.textLabel setText:identifier];
            
        }
            break;
        case 3:
        {
            NSMutableString *identifier = [NSMutableString stringWithString: @"End Time: "];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            
            NSString *dateString = [dateFormatter stringFromDate:myEvent.end_time];
            [identifier appendString:dateString];
            [cell.textLabel setText:identifier];
            
        }
            break;
        case 4:
        {
            NSMutableString *identifier = [NSMutableString stringWithString: @"Recurring: "];
            //NSString *recurring = [myEvent.recurring stringValue];
            [identifier appendString:[myEvent.recurring stringValue]];
            [cell.textLabel setText:identifier];
            
        }
            break;
        case 5:
        {
            NSMutableString *identifier = [NSMutableString stringWithString: @"End Date: "];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            
            NSString *dateString = [dateFormatter stringFromDate:myEvent.recurring_end_date];
            [identifier appendString:dateString];
            [cell.textLabel setText:identifier];
            
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
    
    return cell;
    
}

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
    self.title = myEvent.title;
    self.eventDetailTableView.dataSource = self;
    self.eventDetailTableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
