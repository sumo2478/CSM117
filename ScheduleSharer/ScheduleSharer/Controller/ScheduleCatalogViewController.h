//
//  ScheduleCatalogViewController.h
//  Schedule Adder
//
//  Created by user on 2014/5/11.
//  Copyright (c) 2014年 cs117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleDetailViewController.h"

@interface ScheduleCatalogViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ScheduleDetailViewController *scheduleDetailVC;
//- (IBAction)openScheduleDetail:(id)sender;
@property (strong,nonatomic) NSArray *scheduleCatalogArray;
@property (strong, nonatomic)NSDictionary *scheduleCatalogDictionary;

@end
