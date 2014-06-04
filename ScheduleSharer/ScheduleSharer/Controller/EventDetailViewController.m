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
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    //self.eventDetailTableView.dataSource = self;
    //self.eventDetailTableView.delegate = self;
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    //setting description
    self.eventDescriptionLabel.text = @"Description:";
    
    NSString *description = myEvent.desc;
    self.title = myEvent.title;
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
