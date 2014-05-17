//
//  Constants.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//


#import "Constants.h"

//NSString* const URL_BASE         = @"http://app.zapconnection.com/MyInvite/";
//NSString* const URL_GET_SCHEDULE = @"testText.php";

NSString* const URL_BASE         = @"http://ec2-54-187-220-67.us-west-2.compute.amazonaws.com/";
NSString* const URL_GET_SCHEDULE = @"collinGetScheduleTest.php";

NSString* const MODEL_SCHEDULE   = @"Schedules";
NSString* const MODEL_EVENT      = @"Events";

NSString* const API_SERVER_DATE_FORMAT = @"yyyy-MM-dd HH:mm:ss";
NSString* const API_SERVER_RECURRING_FORMAT = @"yyyy-MM-dd";

NSString* const API_ITINERARY_TITLE_FIELD         = @"title";
NSString* const API_ITINERARY_DESCRIPTION_FIELD   = @"description";
NSString* const API_ITINERARY_CODE_FIELD          = @"id";
NSString* const API_ITINERARY_OWNER_FIELD         = @"creator";
NSString* const API_ITINERARY_EVENTS_FIELD        = @"events";

NSString* const API_EVENT_TITLE_FIELD             = @"event_title";
NSString* const API_EVENT_LOCATION_FIELD          = @"location";
NSString* const API_EVENT_DESCRIPTION_FIELD       = @"event_description";
NSString* const API_EVENT_START_TIME_FIELD        = @"start";
NSString* const API_EVENT_END_TIME_FIELD          = @"end";
NSString* const API_EVENT_RECURRING_FIELD         = @"recurring";
NSString* const API_EVENT_RECURRING_END_TIME_FIELD = @"endDate";

NSString* const CALENDAR_IDENTIFIER = @"ScheduleSharerIdentifier";
NSString* const CALENDAR_TITLE = @"Schedule Sharer";


NSString* const TEST_CODE = @"7";