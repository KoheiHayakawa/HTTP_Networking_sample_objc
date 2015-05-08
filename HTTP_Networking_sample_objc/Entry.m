//
//  Entry.m
//  HTTP_Networking_sample_objc
//
//  Created by Kohei Hayakawa on 5/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

#import "Entry.h"
#import "AFNetworking.h"

static NSString* const kBaseURL = @"http://localhost:3000/api/v1";
static NSString* const kPath = @"entries";

@implementation Entry

- (id) initWithEntryDictionary: (NSDictionary*)entryDictionary {
    self = [super init];
    if (self) {
        self.iiid = [[entryDictionary objectForKey:@"id"] intValue];
        self.title = [entryDictionary objectForKey:@"title"];
        self.body = [entryDictionary objectForKey:@"body"];
    }
    return self;
}

+ (void)getEntriesWithSuccess:(void (^)(NSArray *))success
                    OrFailure:(void (^)(NSError *))failure {
 
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", kBaseURL, kPath];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSMutableArray *entries = [[NSMutableArray alloc] init];
             for (id entryDictionary in responseObject) {
                 Entry *entry = [[Entry alloc] initWithEntryDictionary:entryDictionary];
                 [entries addObject:entry];
             }
             success(entries);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(error);
         }
     ];
}

- (void)deleteEntryWithSuccess:(void (^)())success
                     OrFailure:(void (^)(NSError *))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%d", kBaseURL, kPath, self.iiid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:urlStr parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                success();
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failure(error);
            }
     ];
}


@end
