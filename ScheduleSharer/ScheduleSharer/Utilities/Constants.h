//
//  Constants.h
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//
// Stores all the constants used throughout the project

#ifndef Schedule_constants_h
#define Schedule_constants_h

// URL constants
extern NSString* const URL_BASE;          // URL base
extern NSString* const URL_GET_SCHEDULE;  // URL to get schedule

// Model constants
extern NSString* const MODEL_SCHEDULE;    // Schedule model name
extern NSString* const MODEL_EVENT;       // Event model name

// API constants
extern NSString* const API_SERVER_DATE_FORMAT;

// Itinerary API constants
extern NSString* const API_ITINERARY_TITLE_FIELD;
extern NSString* const API_ITINERARY_DESCRIPTION_FIELD;
extern NSString* const API_ITINERARY_CODE_FIELD;

// Event API constants
extern NSString* const API_EVENT_TITLE_FIELD;
extern NSString* const API_EVENT_LOCATION_FIELD;
extern NSString* const API_EVENT_DESCRIPTION_FIELD;
extern NSString* const API_EVENT_START_TIME_FIELD;
extern NSString* const API_EVENT_END_TIME_FIELD;
extern NSString* const API_EVENT_RECURRING_FIELD;
extern NSString* const API_EVENT_RECURRING_END_TIME_FIELD;

// Event Entity Recurring Constants
extern int const RECURRING_NONE;
extern int const RECURRING_DAILY;
extern int const RECURRING_WEEKLY;
extern int const RECURRING_MONTHLY;
extern int const RECURRING_YEARLY;

// Calendar constants
extern NSString* const CALENDAR_IDENTIFIER; // Identifier for the calendar
extern NSString* const CALENDAR_TITLE;      // Title for the calendar




extern NSString* const TEST_CODE;


#endif
