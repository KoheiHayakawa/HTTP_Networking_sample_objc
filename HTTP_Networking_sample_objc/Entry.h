//
//  Entry.h
//  HTTP_Networking_sample_objc
//
//  Created by Kohei Hayakawa on 5/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Entry : NSObject

@property int iiid;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *body;

+ (void)getEntriesWithSuccess:(void (^)(NSArray *entries))success
                    OrFailure:(void (^)(NSError *error))failure;
- (void)deleteEntryWithSuccess:(void (^)())success
                     OrFailure:(void (^)(NSError *error))failure;

@end
