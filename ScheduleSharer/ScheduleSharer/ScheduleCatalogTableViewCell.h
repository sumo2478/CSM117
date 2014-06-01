//
//  ScheduleCatalogTableViewCell.h
//  ScheduleSharer
//
//  Created by user on 2014/5/31.
//  Copyright (c) 2014年 Collin Yen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleCatalogTableViewCell : UITableViewCell


@property (nonatomic,strong) IBOutlet UILabel *scheduleTitle;
@property (weak, nonatomic) IBOutlet UILabel *description;

@property (nonatomic,strong) IBOutlet UILabel *scheduleID;
@end
