//
//  ScheduleCatalogTableViewCell.m
//  ScheduleSharer
//
//  Created by user on 2014/5/31.
//  Copyright (c) 2014年 Collin Yen. All rights reserved.
//

#import "ScheduleCatalogTableViewCell.h"


@implementation ScheduleCatalogTableViewCell

@synthesize scheduleTitle,scheduleID,description;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
