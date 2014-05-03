//
//  ConnectionModel.m
//  ScheduleSharer
//
//  Created by Collin Yen on 5/2/14.
//  Copyright (c) 2014 Collin Yen. All rights reserved.
//

#import "ConnectionModel.h"

#import "AFNetworking.h"
#import "Constants.h"

@implementation ConnectionModel


-(id) init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

+(void)retrieveScheduleWithCode: (NSString*) code completion:(void (^)(NSDictionary* results))completion;
{
    NSURL* url = [NSURL URLWithString:URL_BASE];
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setValue:@"json" forKey:@"format"];
    
    [manager GET:URL_GET_SCHEDULE parameters:params
                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        completion((NSDictionary*) responseObject);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving schedule"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        
        [alertView show];
    }];
    
    return;
}

@end
