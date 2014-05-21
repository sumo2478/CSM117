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

- (BOOL) downloadSchedule: (NSString*) code;

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

}

- (IBAction)scan:(id)sender
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: 0
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    [scanner setSymbology:ZBAR_QRCODE
                   config:ZBAR_CFG_ENABLE
                       to:1];

    
    [self presentViewController: reader animated: YES completion: nil];
}

# pragma mark ZBar Delegate
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    NSString* code = symbol.data;
    [self downloadSchedule:code];
    
}

#pragma mark Helper Functions

- (BOOL) downloadSchedule: (NSString*) code
{
    BOOL result = YES;
    
    [ConnectionModel retrieveScheduleWithCode:code completion:^(NSDictionary* results) {
        NSManagedObjectContext* context = [self managedObjectContext];
        ScheduleManagerModel* manager = [[ScheduleManagerModel alloc] initWithObjectContext: context];

        
        // Save the schedule to the local database
        if (![manager addScheduleWithData:results])
        {
            [self alertWithTitle:@"Error" Message:@"Unable to save schedule to phone"];
        }
        
    }];
    
    return result;

}
@end
