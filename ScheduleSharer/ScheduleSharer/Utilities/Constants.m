//
//  Constants.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//


#import "Constants.h"

NSString* const URL_BASE         = @"http://app.zapconnection.com/MyInvite/";
NSString* const URL_GET_SCHEDULE = @"testText.php";

NSString* const MODEL_SCHEDULE   = @"Schedules";
NSString* const MODEL_EVENT      = @"Events";

NSString* const API_SERVER_DATE_FORMAT = @"M/d/yyyy H:m";

NSString* const API_ITINERARY_TITLE_FIELD         = @"title";
NSString* const API_ITINERARY_DESCRIPTION_FIELD   = @"description";
NSString* const API_ITINERARY_CODE_FIELD          = @"code";

NSString* const API_EVENT_TITLE_FIELD             = @"title";
NSString* const API_EVENT_LOCATION_FIELD          = @"location";
NSString* const API_EVENT_DESCRIPTION_FIELD       = @"description";
NSString* const API_EVENT_START_TIME_FIELD        = @"start_time";
NSString* const API_EVENT_END_TIME_FIELD          = @"end_time";
NSString* const API_EVENT_RECURRING_FIELD         = @"recurring";
NSString* const API_EVENT_RECURRING_END_TIME_FIELD = @"recurring_end_time";

NSString* const CALENDAR_IDENTIFIER = @"ScheduleSharerIdentifier";
NSString* const CALENDAR_TITLE = @"Schedule Sharer";

int const RECURRING_NONE    = 0;
int const RECURRING_DAILY   = 1;
int const RECURRING_WEEKLY  = 2;
int const RECURRING_MONTHLY = 3;
int const RECURRING_YEARLY  = 4;


NSString* const TEST_CODE = @"33212";