//
//  WebServices.h
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServices : NSObject

+(void)getProgramsWithCompletion:(void(^)(NSArray *jsonArray))completionBlock andFailure:(void(^)(NSError *error))failureBlock;

+(void)getCoursesWithCompletion:(void(^)(NSXMLParser *responseXmlParser))completionBlock andFailure:(void(^)(NSError *error))failureBlock;

@end
