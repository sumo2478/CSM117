//
//  ScheduleDetailViewController.h
//  Schedule Adder
//
//  Created by user on 2014/5/11.
//  Copyright (c) 2014年 cs117. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleDetailViewController : UIViewController

@property (strong, nonatomic) NSString *selectedSchedule;
@property (weak, nonatomic) IBOutlet UILabel *scheduleTitle;
@property (weak, nonatomic) IBOutlet UILabel *scheduleTime;

@end
