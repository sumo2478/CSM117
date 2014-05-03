//
//  AddScheduleViewController.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "AddScheduleViewController.h"

#import "ConnectionModel.h"
#import "ScheduleManagerModel.h"

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
        NSLog(@"%@", data);
        
        ScheduleManagerModel* manager = [[ScheduleManagerModel alloc] initWithObjectContext: self.managedObjectContext];
        [manager addScheduleWithTitle:@"Chicken" Description:@"Archer" Events:nil];
        
    }];

}


@end
